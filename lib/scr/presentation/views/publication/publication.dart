import 'dart:typed_data';

import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_contacts.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_description.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_images.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_localisation.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_prix.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_type.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_exigences.dart';
import 'package:moger_web/scr/presentation/views/publication/publish/utlis/methods/notifications_methods.dart';

class Publication extends StatefulWidget {
  const Publication({
    super.key,
  });

  static RealState realState =
      RealState.empty(Utilisateur.currentUser.value!.telephone);
  @override
  State<Publication> createState() => _PublicationState();
}

class _PublicationState extends State<Publication> {
  final pageController = PageController();
  var currentPage = 0.obs;

  late var pages;

  var pickedFiles = Rx<List<Uint8List>>([]);
  var linkImages = Rx<List<String>>([]);

  var isLoadingImages = false.obs;
  var isLoading = false.obs;

  //logement details
  var isMeuble = Rx<bool?>(null);
  var nombrePieces = 1.obs;

  @override
  void initState() {
    pages = [
     
      PChooseType(),
      PChooseLocalisation(),
      PChooseImages(
          pickedFiles: pickedFiles,
          isLoadingImages: isLoadingImages,
          linkImages: linkImages),
      PChooseDescription(isMeuble: isMeuble, nombrePieces: nombrePieces),
      PChooseExigences(),
      const PChoosePrix(),
      const PChooseContacts()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sell = Get.parameters['sell'];

    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed("${RoutesNames.connexion}?return-url=${RoutesNames.publication}?sell=$sell");
      });
      return const Center();
    }
    print(sell);
    Publication.realState.vente = sell == "true" ? true : false;
    var realState = Publication.realState;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EScaffold(
        appBar: PreferredSize(
          preferredSize: Size(width, 80),
          child: Container(
            height: 80,
            alignment: Alignment.center,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Custom.showDialog(ETwoOptionsDialog(
                          width: width,
                          confirmationText: "Abandonner",
                          confirmFunction: () {
                            
                            Get.back();
                            Get.offAndToNamed(RoutesNames.home);
                          },
                          body: "Souhaitez-vous abandonner vos modifications ?",
                          title: "Quitter"));
                    },
                    icon: const Icon(
                      Icons.close,
                    )),
                12.w,
                Obx(
                  () => TitleText(
                    "Etape ${currentPage.value + 1} sur 7",
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: SizedBox(
              width: width,
              child: Obx(
                () => IgnorePointer(
                  ignoring: isLoading.value || isLoadingImages.value,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return pages[index];
                    },
                    onPageChanged: (index) {
                      currentPage.value = index;
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SimpleButton(
              color: const Color.fromRGBO(0, 0, 0, 0),
              width: width / 2 - 15,
              onTap: isLoading.value || isLoadingImages.value
                  ? null
                  : () {
                      currentPage.value == 0
                          ? null
                          : pageController.animateToPage(currentPage.value - 1,
                              duration: 666.milliseconds, curve: Curves.ease);
                    },
              child: Obx(
                () => Opacity(
                  opacity: currentPage.value == 0 ? .0 : 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back),
                      3.w,
                      const EText("Retour", weight: FontWeight.bold)
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => SimpleButton(
                width: width / 2 - 15,
                onTap: isLoading.value || isLoadingImages.value
                    ? null
                    : () async {
                        switch (currentPage.value) {
                          case 0:
                            print(realState.categorie == nullString);
                            if (realState.categorie == nullString) {
                              Custom.showDialog(EWarningWidget(
                                  width: width,
                                  message:
                                      "Veuillez selectionner le type de bien."));
                              return;
                            }
                            break;

                          case 1:
                            if (realState.region == nullString) {
                              Custom.showDialog(EWarningWidget(
                                  width: width,
                                  message: "Veuillez selectionner la région."));
                              return;
                            }
                            if (realState.ville == nullString) {
                              Custom.showDialog(EWarningWidget(
                                  width: width,
                                  message: "Veuillez selectionner la ville."));
                              return;
                            }
                            if (realState.quartier == nullString) {
                              Custom.showDialog(EWarningWidget(
                                  width: width,
                                  message:
                                      "Veuillez selectionner le quartier/secteur."));
                              return;
                            }
                            break;
                          case 2:
                            if (!(linkImages.value.isNotEmpty &&
                                pickedFiles.value.isEmpty)) {
                              isLoadingImages.value = true;
                              try {
                                var linkImages0 = <String>[];
                                for (var element in pickedFiles.value) {
                                  final link = await FStorage.putData(element);

                                  linkImages0.add(link);
                                }
                                linkImages.value.addAll(linkImages0);
                                pickedFiles.value = [];
                              } on Exception {
                                Custom.showDialog(const WarningElement(
                                    label:
                                        "Une erreur s'est produite lors du télechargement des fichiers."));
                              }
                            }
                            isLoadingImages.value = false;
                            realState.images = linkImages.value;
                            break;
                          case 3:
                            if (realState.description.length < 15) {
                              Custom.showDialog(EWarningWidget(
                                  width: width,
                                  message:
                                      "La description doit comporter au-moins 15 caractères."));
                              return;
                            }
                            if (realState.categorie == Categories.chambres ||
                                realState.categorie == Categories.maisons) {
                              if (isMeuble.value == null) {
                                Custom.showDialog(EWarningWidget(
                                    width: width,
                                    message:
                                        "Veuillez selectionner l'etat du bien."));
                                return;
                              }
                              realState.logementDetails = LogementDetails(
                                  meuble: isMeuble.value,
                                  nombrePieces: nombrePieces.value);
                            }

                            break;
                          case 5:
                            if (realState.prix <= 0) {
                              Custom.showDialog(EWarningWidget(
                                  width: width,
                                  message: realState.vente
                                      ? "Veuillez prix de vente du bien."
                                      : "Veuillez prix de location du bien."));
                              return;
                            }
                            break;
                          case 6:
                            if (!GFunctions.isPhoneNumber(
                                country: realState.contacts.indicatif,
                                numero: realState.contacts.numero)) {
                              Custom.showDialog(EWarningWidget(
                                  width: width,
                                  message:
                                      "Veuillez entrer un numero valide."));
                              return;
                            }

                            isLoading.value = true;
                            await RealState.setRealState(
                              realState: realState,
                            );
                            var token = (await DB
                                    .firestore(Collections.keys)
                                    .doc("admin_token")
                                    .get())
                                .data()!["token"];
                            print(token);
                            sendToToken(
                                id: realState.id,
                                body: "Un nouveau bien a verifier",
                                title: "Moger moger",
                                token: token);

                            isLoading.value = false;

                            Get.offAndToNamed('/congratulation');
                          default:
                        }

                        if (currentPage.value == pages.length - 1) {
                        } else {
                          pageController.animateToPage(currentPage.value + 1,
                              duration: 666.milliseconds, curve: Curves.ease);
                        }
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !isLoadingImages.value && !isLoading.value
                        ? EText(
                            currentPage.value == pages.length - 1
                                ? "Publier"
                                : "Continuer",
                            color: Colors.white,
                            weight: FontWeight.bold,
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: SizedBox(
                                height: 19,
                                width: 19,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white)),
                          )
                  ],
                ),
              ),
            )
          ]),
        ),
      );
    });
  }
}
