import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/search/widgets/search_elements/search_elements.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_type.dart';
import 'package:moger_web/scr/presentation/views/publication/publication.dart';

class PChooseLocalisation extends StatelessWidget {
  PChooseLocalisation({
    super.key,
  });

  var regionSelected = Rx<String?>(null);
  var villeSelected = Rx<String?>(null);
  var quartierSelected = Rx<String?>(null);

  var isLocationLoading = Rx<bool?>(null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

          return EColumn(
            children: [
              SizedBox(
                width: width,
                child: Column(
                  children: [
                    12.h,
                    const EText(
                      "Où se trouve le bien ?",
                      size: 26,
                      weight: FontWeight.bold,
                    ),
                    12.h,
                    const EText("* Information obligatoire"),
                    12.h,
                    DropdownButtonFormField(
                      value: regionSelected.value,
                      items: [
                        Regions.savanes,
                        Regions.kara,
                        Regions.centrale,
                        Regions.plateaux,
                        Regions.maritime
                      ]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: EText(
                                  e,
                                  size: 21,
                                  weight: FontWeight.w600,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        regionSelected.value = value as String;
                        villeSelected.value = null;
                        Publication.realState.region = value;
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: const BorderSide(
                                  color: Colors.black26, style: BorderStyle.solid)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: const BorderSide(
                                  color: Colors.black26, style: BorderStyle.solid)),
                          labelText: "Région*",
                          labelStyle: const TextStyle(fontSize: 22 * .7 / phoneScallerFactor),
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                    ),
                    24.h,
                    Obx(
                      () => DropdownButtonFormField(
                        key: Key(villeSelected.value.toString() +
                            regionSelected.value.toString()),
                        value: villeSelected.value,
                        items: regionSelected.value == null
                            ? []
                            : [
                                ...sortStrings(Constants
                                    .localites[regionSelected.value]!.keys
                                    .toList()),
                                "Ajouter une ville"
                              ]
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: EText(
                                        e,
                                        size: 21,
                                        color: e == "Ajouter une ville"
                                            ? AppColors.color500
                                            : null,
                                        weight: FontWeight.w600,
                                      ),
                                    ))
                                .toList(),
                        onChanged: (value) {
                          if (value == "Ajouter une ville") {
                            addVille(context, villeSelected, regionSelected, width);
                          } else {
                            Publication.realState.ville = value as String;
                            villeSelected.value = value;
                          }
                          quartierSelected.value = null;
                        },
                        decoration: InputDecoration(
                            labelText: "Ville *",
                            labelStyle: const TextStyle(
                              fontSize: 22 * .7 / phoneScallerFactor,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: const BorderSide(
                                    color: Colors.black26, style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: const BorderSide(
                                    color: Colors.black26, style: BorderStyle.solid)),
                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                      ),
                    ),
                    24.h,
                    InkWell(
                      onTap: () {
                        if (villeSelected.value.isNul) {
                          Toasts.error(context,
                              description: "Veuillez selectionner la ville.");
                          return;
                        }
                        chooseQuartier(context,
                            quartiersSelected: quartierSelected,
                            tempRegionSelected: regionSelected,
                            tempVilleSelected: villeSelected);
                      },
                      child: Stack(
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                              minHeight: 60,
                            ),
                            width: width,
                            padding: const EdgeInsets.all(9),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedSwitcher(
                                    duration: 333.milliseconds,
                                    child: Obx(() => quartierSelected.value.isNotNul
                                        ? EText(
                                            quartierSelected.value,
                                            weight: FontWeight.bold,
                                          )
                                        : const EText('Selectionnez'))),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            margin: const EdgeInsets.symmetric(horizontal: 9.0),
                            color: Colors.white,
                            child: const EText(
                              "Quartiers",
                              size: 17,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    12.h,
                     NoChangeInfos(width: width,),
                    24.h,
                    const EText(
                      "Ajouter la géolocalisation",
                      weight: FontWeight.bold,
                    ),
                    6.h,
                    InkWell(
                      onTap: () async {
                        isLocationLoading.value = true;
                        try {
                          var position = await determinePosition(width);
                          Publication.realState.localisation = position == null
                              ? null
                              : Localisation(
                                  latitude: position.latitude,
                                  longitude: position.longitude);
                          isLocationLoading.value = position == null ? null : false;
                        } on Exception {
                          Toasts.error(context, description: "Une erreur s'est produite");
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
                                        child: Icon(Icons.check, color: AppColors.white),
                                      )
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
                    6.h,
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.info_circle_fill,
                          color: AppColors.color500,
                        ),
                        6.w,
                        EText(
                          "Vous pourrez l'ajouter plutard",
                          color: AppColors.color500,
                        ),
                      ],
                    ),
                    12.h,
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  void chooseQuartier(
    context, {
    required Rx<String?> tempRegionSelected,
    required Rx<String?> tempVilleSelected,
    required Rx<String?> quartiersSelected,
    width
  }) {
    var quartiers = sortStrings(Constants
            .localites[tempRegionSelected.value]![tempVilleSelected.value]!)
        .obs;
    return Custom.showDialog(EDialog(width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: EColumn(
          children: [
            12.h,
            const Center(
                child: EText("Quartiers",
                    weight: FontWeight.bold, size: 28)),
            12.h,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ETextField(
                  placeholder: "Rechercher",
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 9.0),
                    child: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    quartiers.value = search(value, tempRegionSelected.value,
                        tempVilleSelected.value);
                  },
                  phoneScallerFactor: phoneScallerFactor),
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...quartiers.value
                      .map((e) => TextButton(
                          onPressed: () {
                            Get.back();
                            quartierSelected.value = e;
                            Publication.realState.quartier = e;
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: EText(
                              e,
                              weight: FontWeight.bold,
                            ),
                          )))
                      ,
                  TextButton(
                      onPressed: () {
                        Get.back();
                        addQuartier(context, quartierSelected, regionSelected,
                            villeSelected, width);
                      },
                      child: EText("Ajouter quartier",
                          color: AppColors.color500,
                          weight: FontWeight.bold,
                          underline: true)),
                  12.h,
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  addQuartier(
      context, Rx<String?> quartierSelected, regionSelected, villeSelected, width) {
    String quartier = "";
    return Custom.showDialog(EDialog(width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child:
            EColumn(crossAxisAlignment: CrossAxisAlignment.center, children: [
          9.h,
          const EText(
            "Ajouter un quartier/secteur",
            weight: FontWeight.bold,
            size: 28,
          ),
          12.h,
          Image(
            image: AssetImage(Assets.icons("style_map.png")),
            height: 50,
          ),
          12.h,
          UnderLineTextField(
              phoneScallerFactor: phoneScallerFactor,
              label: "Nom du quartier",
              onChanged: (value) {
                quartier = value;
              }),
          12.h,
          SimpleButton(
              onTap: () {
                if (quartier.length < 2) {
                  Toasts.error(context, description: "Entrez un nom valide");
                  return;
                }
                Constants.localites[regionSelected.value]![villeSelected.value]!
                    .add(quartier.toLowerCase().capitalizeFirst!);
                quartierSelected.value = quartier;
                try {
                  Publication.realState.quartier = quartier;
                } catch (e) {}
                DB
                    .firestore(Collections.utils)
                    .doc(Collections.localites)
                    .set(Constants.localites);
                Get.back();
              },
              text: "Enregistrer")
        ]),
      ),
    ));
  }

  addVille(
    context,
    Rx<String?> villeSelected,
    regionSelected,
    width
  ) {
    String ville = "";
    return Custom.showDialog(EDialog(width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child:
            EColumn(crossAxisAlignment: CrossAxisAlignment.center, children: [
          9.h,
          const EText(
            "Ajouter une ville ",
            weight: FontWeight.bold,
            size: 28,
          ),
          12.h,
          Image(
            image: AssetImage(Assets.icons("style_map.png")),
            height: 50,
          ),
          12.h,
          UnderLineTextField(
              phoneScallerFactor: phoneScallerFactor,
              label: "Nom du lieu",
              onChanged: (value) {
                ville = value;
              }),
          12.h,
          SimpleButton(
              onTap: () {
                if (ville.length < 2) {
                  Toasts.error(context, description: "Entrez un nom valide");
                  return;
                }
                Constants.localites[regionSelected.value]!.putIfAbsent(
                    ville.toLowerCase().capitalizeFirst!, () => []);
                villeSelected.value = ville;
                Publication.realState.ville = ville;

                Get.back();
              },
              text: "Enregistrer")
        ]),
      ),
    ));
  }
}

Future<Position?> determinePosition(width) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      Custom.showDialog( EWarningWidget(width:width,
          message:
              "Veuillez activer la permission à la géolocalisation sur votre téléphone."));
      return null;
    }
  }
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    if (Get.isDialogOpen!) {
      Get.back();
    }
    Custom.showDialog( EWarningWidget(width:width,
        message: "Veuillez activer la localisation sur votre téléphone."));
    return null;
  }

  if (permission == LocationPermission.deniedForever) {
    print("denied forever");
    if (Get.isDialogOpen!) {
      Get.back();
    }
    Custom.showDialog( EWarningWidget(width:width,
        message:
            "Veuillez activer la permission à la géolocalisation sur votre téléphone."));
    return null;
  }

  // When we reach here, permis
  //
  //sions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
