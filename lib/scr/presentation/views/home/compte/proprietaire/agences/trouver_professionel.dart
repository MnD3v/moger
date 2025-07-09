import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/agences/widgets/pro_card.dart';
import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/agences/widgets/pro_empty.dart';
import 'package:moger_web/scr/presentation/views/home/search/widgets/search_elements/search_elements.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_localisation.dart';

class TrouverProfessionnel extends StatelessWidget {
  TrouverProfessionnel({
    super.key,
  });

  var partenaires = Rx<List<Partenaire>?>(null);
  var distances = [];
  int rayon = 50;
  var manuel = false.obs;

  var tempRegionSelected = Rx<String?>(null);
  var tempVilleSelected = Rx<String?>(null);
  var tempQuartiersSelected = Rx<List<String>>([]);
  var pros;
  @override
  Widget build(BuildContext context) {
    var pros = Get.parameters["pros"];
    pros = EncryptionHelper().decryptText(pros!);

    pros = jsonDecode(pros!);

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EScaffold(
        appBar: appBar(width),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Obx(
            () => partenaires.value.isNotNul
                ? partenaires.value!.isEmpty
                    ? ProsEmpty(
                        manuel: manuel.value,
                        chooseLocalisation: () {
                          chooseLocalisation(context, width);
                        },
                        changeRayon: () {
                          changeRayon(context, width);
                        })
                    : ListView.builder(
                        itemCount: listWidget(context, width).length,
                        itemBuilder: (context, index) {
                          return Center(
                              child: SizedBox(
                                  width: width,
                                  child: listWidget(context, width)[index]));
                        },
                      )
                : EColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      24.h,
                      Center(
                          child: Image(
                        image: AssetImage(Assets.icons("style_map.png")),
                        height: 70,
                      )),
                      12.h,
                      const EText(
                        "Trouver votre adresse.",
                        weight: FontWeight.bold,
                      ),
                      9.h,
                      const EText(
                        "La géolocalisation sera utilisée pour determiner votre localisation afin de vous proposer les professionnels les plus proches.",
                        maxLines: 8,
                        align: TextAlign.center,
                      ),
                      12.h,
                      const EText(
                        "ou",
                        weight: FontWeight.bold,
                      ),
                      24.h,
                      SimpleOutlineButton(
                        height: 40,
                        width: 190,
                        color: Colors.black,
                        onTap: () {
                          chooseLocalisation(context, width);
                        },
                        text: "Choisir manuellement",
                      )
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => partenaires.value.isNotNul
              ? 0.h
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: SimpleButton(
                      width: width,
                      onTap: () async {
                        manuel.value = false;
                        getProfessionnels(context, rayon, width);
                      },
                      text: "Continuer",
                    ),
                  ),
                ),
        ),
      );
    });
  }

  void chooseLocalisation(BuildContext context, width) {
    return Custom.showDialog(EDialog(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BigTitleText("Où voulez un professionnel ?"),
            12.h,
            DropdownButtonFormField(
              value: tempRegionSelected.value,
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
                tempRegionSelected.value = value;
                tempVilleSelected.value = null;
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.black12, style: BorderStyle.solid)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.black12, style: BorderStyle.solid)),
                  labelText: "Région*",
                  labelStyle: const TextStyle(
                      fontSize: 22 * .7 / phoneScallerFactor,
                      fontWeight: FontWeight.w500),
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
            ),
            24.h,
            Obx(
              () => DropdownButtonFormField(
                key: Key(tempVilleSelected.value.toString() +
                    tempRegionSelected.value.toString()),
                value: tempVilleSelected.value,
                items: tempRegionSelected.value == null
                    ? []
                    : sortStrings(Constants
                            .localites[tempRegionSelected.value]!.keys
                            .toList())
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
                  tempVilleSelected.value = value as String;
                  tempQuartiersSelected.value = [];
                },
                decoration: InputDecoration(
                    labelText: "Ville *",
                    labelStyle: const TextStyle(
                        fontSize: 22 * .7 / phoneScallerFactor,
                        fontWeight: FontWeight.w500),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Colors.black12, style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Colors.black12, style: BorderStyle.solid)),
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
              ),
            ),
            12.h,
            SimpleButton(
              onTap: () async {
                if (tempVilleSelected.value.isNul) {
                  Toasts.error(context,
                      description: "Veuillez selectionnez la ville");
                  return;
                }
                manuel.value = true;
                Get.back();
                eLoading(width: width);
                var q = await DB
                    .firestore(Collections.partenaires)
                    .where("authorized", isEqualTo: true)
                    .where("role", whereIn: pros)
                    .where("ville", isEqualTo: tempVilleSelected.value)
                    .get();
                var prts = <Partenaire>[];
                for (var element in q.docs) {
                  prts.add(Partenaire.fromMap(element.data()));
                }
                partenaires.value = prts;
                Get.back();
              },
              text: "Continuer",
            )
          ],
        ),
      ),
    ));
  }

  listWidget(context, width) {
    return [
      Obx(
        () => manuel.value
            ? Container(
                height: 50,
                width: width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(6),
                color: AppColors.color100,
                child: Wrap(
                  children: [
                    ETextRich(textSpans: [
                      ETextSpan(text: "Resultat obtenus dans"),
                      ETextSpan(
                          text:
                              " ${tempRegionSelected.value} -  ${tempVilleSelected.value}",
                          color: AppColors.color500,
                          weight: FontWeight.w600),
                    ]),
                    9.w,
                    InkWell(
                        onTap: () {
                          chooseLocalisation(context, width);
                        },
                        child: EText(
                          "Modifier",
                          underline: true,
                          color: AppColors.blue,
                          weight: FontWeight.bold,
                        ))
                  ],
                ),
              )
            : Container(
                height: 50,
                width: width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(6),
                color: AppColors.color100,
                child: Wrap(
                  children: [
                    ETextRich(textSpans: [
                      ETextSpan(text: "Resultat dans un rayon de "),
                      ETextSpan(
                          text: "$rayon km.",
                          color: AppColors.color500,
                          weight: FontWeight.w600),
                    ]),
                    9.w,
                    InkWell(
                        onTap: () {
                          changeRayon(context, width);
                        },
                        child: EText(
                          "Modifier",
                          underline: true,
                          color: AppColors.blue,
                          weight: FontWeight.bold,
                        ))
                  ],
                ),
              ),
      ),
      ...partenaires.value!
          .map((e) => PartenaireCard(
            width: width,
                partenaire: e,
              ))
          
    ];
  }

  void changeRayon(context, width) {
    return Custom.showDialog(EDialog(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: EColumn(
          children: [
            const TitleText("Entrez un nouveau rayon de recherche"),
            12.h,
            OutlineTextField(
                initialValue: rayon.toString(),
                number: true,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  LengthLimitingTextInputFormatter(15),
                ],
                label: "Rayon",
                onChanged: (value) {
                  rayon = int.tryParse(value) ?? 0;
                },
                suffix: EText(
                  "Km",
                  color: AppColors.color500,
                  weight: FontWeight.bold,
                  size: 22,
                ),
                phoneScallerFactor: phoneScallerFactor),
            12.h,
            SimpleButton(
              onTap: () async {
                Get.back();
                eLoading(width: width);

                await getProfessionnels(context, rayon, width);
                Get.back();
              },
              text: "OK",
            )
          ],
        ),
      ),
    ));
  }

  getProfessionnels(context, rayon, width) async {
    eLoading(width: width);
    print(0);
    var position = await determinePosition(width);
    print(1);

    if (position.isNul) {
      Toasts.error(context, description: "Une erreur s'est produite");
      return;
    }
    var partenaires0 = <Partenaire>[];
    QuerySnapshot<Map<String, dynamic>> q;
    try {
      q = await DB
          .firestore(Collections.partenaires)
          .where("authorized", isEqualTo: true)
          .where("role", whereIn: pros)
          .get();
    } on Exception catch (e) {
      print(e);
      return;
    }
    print(2);
    var prts = [];
    for (var element in q.docs) {
      var localisation = Localisation.fromMap(element.data()["localisation"]);
      final distance = calculateDistance(position!.latitude, position.longitude,
          localisation.latitude, localisation.longitude);
      if (true /* distance < rayon */) {
        partenaires0.add(Partenaire.fromMap(element.data()));
        distances.add(distance);
      }
    }
    partenaires.value = partenaires0;
    Get.back();
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    print(1);
    const double earthRadius = 6371; // Rayon de la Terre en kilomètres

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    print(2);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    print(3);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    print(4);

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
