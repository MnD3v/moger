import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/controllers/favoris_controller.dart';
import 'package:moger_web/scr/presentation/views/home/search/widgets/real_state_card.dart';

class Favoris extends StatelessWidget {
  const Favoris({super.key});

  @override
  Widget build(BuildContext context) {
    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed(
            "${RoutesNames.connexion}?return-url=${RoutesNames.favoris}");
      });
      return const Center();
    }
    Get.lazyPut(
      () => FavorisController(),
    );
    var controller = Get.find<FavorisController>();
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 900.0 ? 900.0 : constraints.maxWidth;

      return EScaffold(
        appBar: appBar(width),
        body: Align(
          alignment: Alignment.topCenter,
          child: Obx(
            () => Utilisateur.currentUser.value == null
                ? const FavorisNoAccount()
                : FutureBuilder(
                    future: controller.realStates.value.isNotNul
                        ? null
                        : controller.getFavoris(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState ==
                              ConnectionState.waiting
                          ? const ECircularProgressIndicator(
                              label: "Chargement des favoris",
                            )
                          : controller.realStates.value.isNul &&
                                  DB.hasError(snapshot)
                              ? EError(
                                  error: snapshot.error.toString(),
                                  retry: () async {
                                    eLoading(width: width);
                                    try {
                                      await controller.getFavoris();
                                    } catch (e) {
                                      print(e);
                                      Toasts.error(context,
                                          description:
                                              "Une erreur s'est produite");
                                    }
                                    Get.back();
                                  },
                                )
                              : EColumn(
                                children: [
                                  SizedBox(
                                    width: width,
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Obx(
                                          () => AnimatedSwitcher(
                                            duration: 666.milliseconds,
                                            child: controller
                                                    .realStates.value!.isEmpty
                                                ? const FavorisEmpty()
                                                : Obx(
                                                    () => AnimatedSwitcher(
                                                      duration: 666.milliseconds,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        key: Key(controller
                                                            .realStates
                                                            .value!
                                                            .length
                                                            .toString()),
                                                        children: [
                                                          const EText("Mes favoris",
                                                              size: 35,
                                                              weight:
                                                                  FontWeight.w800),
                                                          12.h,
                                                          Wrap(
                                                            key: Key(controller
                                                                .realStates
                                                                .value!
                                                                .length
                                                                .toString()),
                                                            children: listWidgets(
                                                                controller, width),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        )),
                                  ),
                                  bottomAppBar(width: constraints.maxWidth)
                                ],
                              );
                    }),
          ),
        ),
      );
    });
  }

  List<Widget> listWidgets(controller, width) => [
        ...controller.realStates.value
            .map((e) => InkWell(
                  onTap: () async {
                    final id = EncryptionHelper().encryptText(e.id);
                    Get.toNamed("${RoutesNames.biens}?id=$id");
                  },
                  child: RealStateSimilaireCard(
                    delete: true,
                    favorisController: controller,
                    realState: e,
                  ),
                ))
            .toList(),
        6.h,
        // controller.realStates.value.isEmpty
        //     ? 45.h
        //     : Obx(() => controller.fetchEnd.value
        //         ? 45.h
        //         : const Center(child: EText('Chargement...', size: 20))),
        // 3.h,
        70.h,
      ];
}

class FavorisNoAccount extends StatelessWidget {
  const FavorisNoAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: EColumn(crossAxisAlignment: CrossAxisAlignment.center, children: [
        12.h,
        Image(
          image: AssetImage(Assets.icons("account_2.png")),
          height: 90,
        ),
        12.h,
        const TitleText(
          "Connectez vous pour enregistrer vos favoris.",
        ),
        24.h,
        const EText(
          "Partagez votre liste de favoris avec vos proches et retrouvez-la sur tous vos appareils.",
          maxLines: 4,
          align: TextAlign.center,
        ),
        24.h,
        SimpleOutlineButton(
            height: 50,
            color: Colors.black,
            text: "Me connecter",
            onTap: () {
              // Get.to(
              //     Connexion(
              //       function: () {},
              //     ),
              //     fullscreenDialog: true);
            }),
        12.h,
        SimpleButton(
          height: 50,
          onTap: () {
            // Get.to(
            //     Inscription(
            //       function: () {},
            //     ),
            //     fullscreenDialog: true);
          },
          text: "Créer un compte",
        )
      ]),
    );
  }
}

class FavorisEmpty extends StatelessWidget {
  const FavorisEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RechercheController>();

    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        children: [
          Image(
            image: AssetImage(Assets.icons("empty_favoris.png")),
            height: 100,
          ),
          24.h,
          const EText("Vous n'avez pas encore de favoris",
              weight: FontWeight.bold, size: 20),
          12.h,
          const EText(
            "Lorsque vous faites une recherche, appuyez sur le coeur pour ajouter une annonce aux favoris.",
            align: TextAlign.center,
            size: 20,
            maxLines: 4,
          ),
          24.h,
        
        ],
      ),
    );
  }
}
