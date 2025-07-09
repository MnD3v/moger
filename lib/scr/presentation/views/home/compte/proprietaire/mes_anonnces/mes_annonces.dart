import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/controllers/mes_annonces_controller.dart';

class MesAnnonces extends StatefulWidget {
  const MesAnnonces({super.key});

  @override
  State<MesAnnonces> createState() => _MesAnnoncesState();
}

class _MesAnnoncesState extends State<MesAnnonces> {
  bool firstFetch = false;

  var groupeValue = "Tous".obs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var sharedPreferences = await SharedPreferences.getInstance();
      var isOpen = sharedPreferences.getBool("openMesAnnonce") ?? false;
      if (!isOpen) {
        showInfo(Get.width);
        sharedPreferences.setBool("openMesAnnonce", true);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed(
            "${RoutesNames.connexion}?return-url=${RoutesNames.mesAnnonces}");
      });
      return const Center();
    }
    Get.lazyPut(() => MesAnnoncesController());
    final controller = Get.find<MesAnnoncesController>();
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return EScaffold(
        appBar: appBar(width),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200.0, left: 9),
              child: FutureBuilder(
                future: controller.realStates.value != null
                    ? null
                    : controller.getMyRealStates(restart: true),
                builder: (context, snapshot) {
                  return DB.waiting(snapshot)
                      ? const ECircularProgressIndicator(
                          label: "Chargement de mes annonces",
                        )
                      : Obx(
                          () => controller.realStates.value.isNul &&
                                  DB.hasError(snapshot)
                              ? EError(
                                  error: snapshot.error.toString(),
                                  retry: () async {
                                    eLoading(width: width);
                                    try {
                                      await controller.getMyRealStates(
                                          type: groupeValue.value == "Tous"
                                              ? null
                                              : groupeValue.value,
                                          restart: true);
                                    } catch (e) {
                                      print(e);
                                      Toasts.error(context,
                                          description:
                                              "Une erreur s'est produite");
                                    }
                                    Get.back();
                                  },
                                )
                              : controller.realStates.value!.isEmpty
                                  ? const Vide(
                                      message:
                                          "Aucune publication pour le moment",
                                    )
                                  : controller.isLoading.value
                                      ? const ECircularProgressIndicator(
                                          label: "Chargement",
                                        )
                                      : AnimatedSwitcher(
                                          duration: 333.milliseconds,
                                          child: NotificationListener<
                                              ScrollNotification>(
                                            key: Key(controller
                                                .realStates.value!.length
                                                .toString()),
                                            child: EColumn(
                                              children: [
                                                Center(
                                                    child: SizedBox(
                                                        width: width,
                                                        child: Wrap(
                                                            children: listWidgets(
                                                                controller, width)))),
                                              ],
                                            ),
                                            onNotification: (notification) {
                                              if (notification.metrics.pixels >
                                                      notification.metrics
                                                          .maxScrollExtent &&
                                                  !firstFetch) {
                                                controller.getMyRealStates();
                                                firstFetch = true;
                                              }
                                              if (notification.metrics.pixels <=
                                                  notification.metrics
                                                      .maxScrollExtent) {
                                                firstFetch = false;
                                              }
                                              return false;
                                            },
                                          ),
                                        ),
                        );
                },
              ),
            ),
            Container(
              //  color: AppColors.color500,
              padding: const EdgeInsets.all(12),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                24.h,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        EText("Mes annonces",
                            size: 35, weight: FontWeight.w800
                            //  color: Colors.white,
                            ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          showInfo(width);
                        },
                        icon: const Icon(
                          Icons.info,
                        ))
                  ],
                ),
                ETextField(
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Icon(Icons.search, color: Colors.black54),
                    ),
                    color: Colors.black12,
                    textInputAction: TextInputAction.search,
                    border: false,
                    placeholder: "Rechercher la réference",
                    placeholderColor: Colors.black45,
                    radius: 6,
                    number: true,
                    onChanged: (value) {},
                    onSubmitted: (value) async {
                      controller.isLoading.value = true;
                      try {
                        if (value!.isEmpty) {
                          await controller.getMyRealStates();
                        } else {
                          await controller.searchId(value);
                        }
                      } catch (e) {
                        print(e);
                        Toasts.error(context,
                            description: "Une erreur s'est produite");
                      }
                      controller.isLoading.value = false;
                    },
                    phoneScallerFactor: phoneScallerFactor),
                12.h,
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const CupertinoScrollBehavior()
                        .getScrollPhysics(context),
                    children: [
                      ...[
                        "Tous",
                        Categories.chambres,
                        Categories.terrains,
                        Categories.maisons,
                        Categories.boutiques,
                        Categories.bureau
                      ]
                          .map((e) => _Type(
                              value: e,
                              groupeValue: groupeValue,
                              controller: controller))
                          .toList() as List<Widget>
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
              backgroundColor: AppColors.color500,
              onPressed: () {
                Get.back();
                Get.toNamed(RoutesNames.publicationExplain);
              },
              child: const Icon(CupertinoIcons.add, color: Colors.white)),
        ),
      );
    });
  }

  void showInfo(width) {
    return Custom.showDialog(EDialog(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EColumn(
          children: [
            12.h,
            BigTitleText(
              "Mise à jour de vos annonces sur notre application immobilière",
              color: AppColors.blue,
            ),
            12.h,
            const EText(
                "Chers utilisateurs,\nAfin de garantir la fiabilité et la disponibilité des annonces sur notre plateforme, nous avons mis en place un système d'actualisation des annonces. Voici comment cela fonctionne :"),
            9.h,
            const TitleText("1. Actualisation régulière des annonces :"),
            const EText(
                "Vous avez la possibilité d'actualiser la date de votre annonce à tout moment. Cela permet aux autres utilisateurs d'être rassurés sur la disponibilité de votre bien immobilier."),
            const TitleText("2. Annonce inactive après 2 semaines :"),
            const EText(
                "Si votre annonce n'a pas été actualisée pendant plus de 2 semaines, elle deviendra inactive et sera invisible pour les autres utilisateurs. Vous recevrez une notification avant que cela ne se produise."),
            9.h,
            const TitleText("3. Suppression après 4 semaines :"),
            const EText(
                "Si votre annonce reste inactive pendant plus de 4 semaines, elle sera définitivement supprimée de notre plateforme. Une notification vous sera envoyée avant que cette action soit effectuée."),
            9.h,
            const EText(
                "Nous vous recommandons de vérifier et d'actualiser régulièrement vos annonces pour maximiser leur visibilité et garantir leur pertinence. Nous sommes là pour vous aider à tirer le meilleur parti de notre service."),
            9.h,
            SimpleOutlineButton(
              radius: 3,
              color: Colors.black,
              onTap: () {
                Get.back();
              },
              text: "D'accord",
            )
          ],
        ),
      ),
    ));
  }

  List<Widget> listWidgets(MesAnnoncesController controller, width) {
    print(controller.realStates.value!.length);
    return [
      ...controller.realStates.value!.map((RealState e) => InkWell(
            onTap: () {
              // il ne faut pas oublier qu'il y'a des fonctions differente pour le card et le details page.
              final id = EncryptionHelper().encryptText(e.id);
              Get.toNamed(
                  "${RoutesNames.publisherRealStateDetailsPage}?id=$id");
            },
            child: PublisherRealStateCard(
              actualiser: () async {
                eLoading(width: width);
                var index = controller.realStates.value!.indexOf(e);

                await RealState.setRealState(
                    realState: e.copyWith(
                        date: DateTime.now().toString(), status: Status.actif));
                controller.realStates.update((val) {
                  val?[index] = e.copyWith(
                      date: DateTime.now().toString(), status: Status.actif);
                });
                Get.back();
                Toasts.success(context,
                    description: "Modification effectuée avec succès");
              },
              delete: () {
                Custom.showDialog(ETwoOptionsDialog(
                  width: width,
                    confirmFunction: () async {
                      Get.back();
                      eLoading(width: width);
                      await controller.delete(e);
                      Get.back();
                      Toasts.success(context,
                          description: "Element supprimé avec succès");
                    },
                    confirmationText: "Supprimer",
                    body: "Souhaitez-vous vraiment supprimer ce bien ?",
                    title: "Suppression"));
              },
              modify: () {
                final id = EncryptionHelper().encryptText(e.id);
                Get.toNamed("${RoutesNames.editRealState}?id=$id");
              },
              realState: e,
            ),
          )),
      ...[
        6.h,
        Center(
          child: Obx(() => controller.fetchEnd.value
              ? 45.h
              : const EText('Chargement...', size: 20)),
        ),
        3.h,
      ]
    ];
  }
}

class _Type extends StatelessWidget {
  const _Type(
      {required this.value,
      required this.groupeValue,
      required this.controller});
  final MesAnnoncesController controller;
  final String value;
  final RxString groupeValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        groupeValue.value = value;
        controller.getMyRealStates(
            type: value == "Tous" ? null : value, restart: true);
      },
      child: Obx(
        () => AnimatedContainer(
            duration: 333.milliseconds,
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 9),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: groupeValue.value == value
                    ? Colors.black
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6)),
            child: EText(
              value == "Tous" ? "Tous" : categorieToPresentationPlural(value),
              color:
                  groupeValue.value == value ? AppColors.white : Colors.black,
              weight: groupeValue.value == value
                  ? FontWeight.w600
                  : FontWeight.w600,
            )),
      ),
    );
  }
}
