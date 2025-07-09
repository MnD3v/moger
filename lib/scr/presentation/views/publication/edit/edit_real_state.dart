import 'dart:typed_data';

import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_images.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_localisation.dart';
import 'package:moger_web/scr/presentation/views/publication/publish/utlis/methods/notifications_methods.dart';

class Modifier extends StatelessWidget {
  Modifier({
    super.key,
  });

  var isLoading = false.obs;

  var isLocationLoading = Rx<bool?>(null);
  RealState? realState;
  @override
  Widget build(BuildContext context) {
    var id = Get.parameters['id'];

    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed("${RoutesNames.connexion}?return-url=${RoutesNames.editRealState}?id=$id");
      });
      return const Center();
    }
    id = EncryptionHelper().decryptText(id!);

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EScaffold(
        appBar: appBar(width),
        body: FutureBuilder(
            future: realState != null
                ? null
                : DB.firestore(Collections.biens).doc(id).get(),
            builder: (context, snapshot) {
              if (DB.waiting(snapshot)) {
                return const ECircularProgressIndicator(
                  label: "Chargement",
                );
              }
              realState = RealState.fromMap(snapshot.data!.data()!);
              if (realState!.uid !=
                  Utilisateur.currentUser.value!.telephone.numero) {
                return const Center(
                  child: EText("Une erreur s'est produite"),
                );
              }
              return Obx(
                () => IgnorePointer(
                  ignoring: isLoading.value,
                  child: EScaffold(
                    body: EColumn(
                      children: [
                        Center(
                          child: SizedBox(
                            width: width,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  12.h,
                                  const EText(
                                    "Modifier le bien",
                                    weight: FontWeight.w800,
                                    size: 35,
                                  ),
                                  12.h,
                                  _Element(
                                      width: width,
                                      onTap: () {
                                        Telephone contacts =
                                            realState!.contacts;

                                        changeContactsDialog(
                                            context, contacts, width);
                                      },
                                      title: "Contacts"),
                                  _Element(
                                      width: width,
                                      onTap: () {
                                        String description =
                                            realState!.description;
                                        var length =
                                            realState!.description.length.obs;
                                        changeDescriptionDialog(context,
                                            description, length, width);
                                      },
                                      title: "Description"),
                                  _Element(
                                      width: width,
                                      onTap: () {
                                        String exigence = realState!.exigence;
                                        var length =
                                            realState!.exigence.length.obs;
                                        changeExigenceDialog(
                                            context, exigence, length, width);
                                      },
                                      title: "Exigences"),
                                  _Element(
                                      width: width,
                                      onTap: () {
                                        int prix = realState!.prix;
                                        changePrixDialog(context, prix, width);
                                      },
                                      title: "Prix"),
                                  _Element(
                                      width: width,
                                      onTap: () {
                                        addGeolocalisation(context, width);
                                      },
                                      title: "Géolocalisation"),
                                  _Element(
                                      width: width,
                                      onTap: () {
                                        var linkImages = realState!.images.obs;
                                        var isLoadingImages = false.obs;
                                        var pickedImages =
                                            Rx<List<Uint8List>>([]);
                                        changeImagesDialog(
                                            context,
                                            isLoadingImages,
                                            linkImages,
                                            pickedImages, width);
                                      },
                                      title: "Images")
                                ]),
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: SimpleButton(
                            height: 50,
                            width: width,
                            onTap: () async {
                              isLoading.value = true;
                              realState!.status = null;
                              await RealState.setRealState(
                                  realState: realState!);
                              isLoading.value = false;
                              Get.offAndToNamed(RoutesNames.mesAnnonces);
                              Toasts.success(context,
                                  description:
                                      "Modification effectuée avec succès");
                              var token = (await DB
                                      .firestore(Collections.keys)
                                      .doc("admin_token")
                                      .get())
                                  .data()!["token"];
                              await sendToToken(
                                  id: realState!.id,
                                  body: "Un nouveau bien a verifier",
                                  title: "Moger moger",
                                  token: token);
                            },
                            child: Obx(
                              () => isLoading.value
                                  ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1.3,
                                      ))
                                  : const EText("Enregistrer",
                                      weight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                          ),
                        )),
                  ),
                ),
              );
            }),
      );
    });
  }

  void addGeolocalisation(BuildContext context, width) {
    return Custom.showDialog(EDialog(width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EColumn(
          children: [
            const Center(
                child: EText(
              "Géolocalisation",
              size: 28,
              weight: FontWeight.bold,
            )),
            12.h,
            InkWell(
              onTap: () async {
                isLocationLoading.value = true;
                try {
                  var position = await determinePosition(width);
                  realState!.localisation = position == null
                      ? null
                      : Localisation(
                          latitude: position.latitude,
                          longitude: position.longitude);
                  isLocationLoading.value = false;
                } on Exception {
                  Toasts.error(context,
                      description: "Une erreur s'est produite");
                  isLocationLoading.value = null;
                }
              },
              child: Obx(
                () => Container(
                    width: width,
                    height: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.1),
                        borderRadius: BorderRadius.circular(9)),
                    child: isLocationLoading.value == true
                        ? const ECircularProgressIndicator(
                            label: "Chargement",
                          )
                        : isLocationLoading.value == false
                            ? Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blue),
                                child:
                                    Icon(Icons.check, color: AppColors.white))
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add_location_alt_sharp,
                                      color: AppColors.blue),
                                  6.h,
                                  EText("Utiliser la localisation actuelle",
                                      weight: FontWeight.bold,
                                      color: AppColors.blue),
                                  EText("Cliquez pour ajouter",
                                      underline: true, color: AppColors.blue),
                                ],
                              )),
              ),
            ),
            12.h,
            SimpleButton(
                onTap: () {
                  Get.back();
                },
                text: "Ok"),
          ],
        ),
      ),
    ));
  }

  void changeImagesDialog(context, RxBool isLoadingImages,
      RxList<String> linkImages, Rx<List<Uint8List>> pickedImages, width) {
    return Custom.showDialog(
      Obx(
        () => IgnorePointer(
          ignoring: isLoadingImages.value,
          child: EScaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PChooseImages(
                    linkImages: linkImages,
                    isLoadingImages: isLoadingImages,
                    pickedFiles: pickedImages,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 50,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(9),
              child: SimpleButton(
                width: width,
                // padding: 9,
                height: 50,
                onTap: () async {
                  if (pickedImages.value.isNotEmpty) {
                    isLoadingImages.value = true;
                    var linkImages0 = <String>[];
                    for (var element in pickedImages.value) {
                      final link = await FStorage.putData(element);
              
                      linkImages0.add(link);
                    }
                    linkImages.value.addAll(linkImages0);
                    pickedImages.value = [];
                    isLoadingImages.value = false;
                  }
              
                  realState!.images = linkImages.value;
                  RealState.setRealState(realState: realState!);
                  Get.back();
                },
                child: Obx(
                  () => isLoadingImages.value
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.3,
                          ))
                      : const EText("OK",
                          weight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changePrixDialog(context, int prix, width) {
    return Custom.showDialog(EDialog(width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EText("Prix", weight: FontWeight.bold, size: 28),
            12.h,
            OutlineTextField(
                initialValue: realState!.prix.toString(),
                onChanged: (value) {
                  prix = int.parse(value.replaceAll(" ", ""));
                },
                separate: 3,
                label: "Prix",
                suffixText: realState!.vente
                    ? "F"
                    : realState!.categorie == Categories.terrains
                        ? "F/an"
                        : "F/Mois",
                phoneScallerFactor: phoneScallerFactor),
            12.h,
            SimpleButton(
                onTap: () {
                  if (prix <= 0) {
                    Custom.showDialog(EWarningWidget(width:width,
                        message: "Veuillez entrer un prix valide."));
                    return;
                  }

                  realState!.prix = prix;
                  Get.back();
                },
                text: "OK")
          ],
        ),
      ),
    ));
  }

  void changeExigenceDialog(context, String exigence, RxInt length, width) {
    return Custom.showDialog(EDialog(width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: EColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const EText("Exigences", weight: FontWeight.bold, size: 28),
            12.h,
            OutlineTextField(
                initialValue: realState!.exigence,
                onChanged: (value) {
                  exigence = value;
                  length.value = value.length;
                },
                label: "Exigences",
                maxLines: 8,
                minLines: 8,
                phoneScallerFactor: phoneScallerFactor),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width - 160,
                  child: const EText(
                    "",
                    maxLines: 4,
                  ),
                ),
                Obx(
                  () => EText("${length.value}/4000"),
                )
              ],
            ),
            12.h,
            SimpleButton(
                onTap: () {
                  realState!.exigence = exigence;
                  Get.back();
                },
                text: "OK")
          ],
        ),
      ),
    ));
  }

  void changeDescriptionDialog(
      context, String description, RxInt length, width) {
    return Custom.showDialog(EDialog(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: EColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const EText("Description", weight: FontWeight.bold, size: 28),
            12.h,
            OutlineTextField(
                initialValue: realState!.description,
                onChanged: (value) {
                  description = value;
                  length.value = value.length;
                },
                label: "Description",
                maxLines: 8,
                minLines: 8,
                phoneScallerFactor: phoneScallerFactor),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width - 160,
                  child: const EText(
                    "Mettez en avant ses atouts en utilisant au moins 15 caractères.",
                    maxLines: 4,
                  ),
                ),
                Obx(
                  () => EText("${length.value}/4000"),
                )
              ],
            ),
            12.h,
            SimpleButton(
                onTap: () {
                  if (description.length < 15) {
                    Custom.showDialog(EWarningWidget(width:width,
                        message:
                            "La description doit contenir aumoins 15 caractères."));
                    return;
                  }
                  realState!.description = description;
                  Get.back();
                },
                text: "OK")
          ],
        ),
      ),
    ));
  }

  void changeContactsDialog(context, Telephone contacts, width) {
    return Custom.showDialog(EDialog(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: EColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const EText("Contacts", weight: FontWeight.bold, size: 28),
            12.h,
            OutlineTextField(
                initialValue: realState!.contacts.numero,
                onChanged: (value) {
                  contacts.numero = value.replaceAll(" ", "");
                },
                label: "Numero de téléphone",
                prefix: EText(
                  "${realState!.contacts.indicatif} ",
                  weight: FontWeight.w500,
                ),
                phoneScallerFactor: phoneScallerFactor),
            12.h,
            SimpleButton(
                onTap: () {
                  if (!GFunctions.isPhoneNumber(
                      country: realState!.contacts.indicatif,
                      numero: realState!.contacts.numero)) {
                    Custom.showDialog(EWarningWidget(width:width,
                        message: "Veuillez entrer un numero valide."));
                    return;
                  }

                  realState!.contacts = contacts;
                  Get.back();
                },
                text: "OK")
          ],
        ),
      ),
    ));
  }
}

class _Element extends StatelessWidget {
  const _Element({
    required this.onTap,
    required this.width,
    required this.title,
  });
  final width;
  final onTap;
  final title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 75,
        width: width,
        padding: const EdgeInsets.all(9),
        margin: const EdgeInsets.all(9),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                EText(
                  title,
                  weight: FontWeight.w600,
                  size: 22,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }
}
