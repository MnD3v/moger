import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';
// import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/agences/trouver_professionnel.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ProfessionnelExplainAndChoose extends StatefulWidget {
  const ProfessionnelExplainAndChoose({super.key});

  @override
  State<ProfessionnelExplainAndChoose> createState() =>
      _ProfessionnelExplainAndChooseState();
}

class _ProfessionnelExplainAndChooseState
    extends State<ProfessionnelExplainAndChoose> {
  var tempProsSelected = Rx<List<String>>([]);

  Map<String, List<String>> interventions = {
    'Acheter': [
      'Agence immobilière',
      'Agent commercial',
      'Notaire',
      'Avocat immobilier'
    ],
    'Louer': ['Agence immobilière', 'Agent commercial', 'Avocat immobilier'],
    'Vendre': [
      'Agence immobilière',
      'Agent commercial',
      'Notaire',
      'Avocat immobilier'
    ],
    'Faire louer': [
      'Agence immobilière',
      'Agent commercial',
      'Avocat immobilier'
    ],
    'Construire': ['Constructeur', 'Notaire', 'Huissier', 'Avocat immobilier']
  };
  var interventionSelected = Rx<String?>(null);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EScaffold(
        appBar: appBar(width),
        body: EColumn(
          children: [
            Center(
              child: SizedBox(
                width: width,
                child: Column(children: [
                  Container(
                    width: width,
                    color: const Color.fromRGBO(255, 223, 208, 1),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: EText(
                            "Trouver un professionnel de l'immobilier",
                            size: 30,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: width - 25,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 9)
                              ],
                              borderRadius: BorderRadius.circular(6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const EText(
                                "Type de projet",
                                weight: FontWeight.bold,
                              ),
                              6.h,
                              DropdownButtonFormField(
                                items: interventions.keys
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
                                  interventionSelected.value = value as String;
                                },
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.black12,
                                            style: BorderStyle.solid)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.black12,
                                            style: BorderStyle.solid)),
                                    labelText: "Projet*",
                                    labelStyle: const TextStyle(
                                        fontSize: 22 * .7 / phoneScallerFactor,
                                        fontWeight: FontWeight.w500),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto),
                              ),
                              12.h,
                              const EText(
                                "Professionnels recherchés",
                                weight: FontWeight.bold,
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Obx(
                                      () => InkWell(
                                        onTap:
                                            interventionSelected.value == null
                                                ? null
                                                : () {
                                                    var temptempProsSelected =
                                                        Rx<List<String>>(
                                                            tempProsSelected
                                                                .value);

                                                    Custom.showDialog(EDialog(
                                                      width: width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(9.0),
                                                        child: Obx(
                                                          () => EColumn(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              12.h,
                                                              const EText(
                                                                  "Professionnels",
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                  size: 28),
                                                              12.h,
                                                              ...interventions[
                                                                      interventionSelected
                                                                          .value]!
                                                                  .map((e) => CheckboxListTile
                                                                      .adaptive(
                                                                          title: EText(
                                                                              e),
                                                                          value: temptempProsSelected.value.contains(
                                                                              e),
                                                                          onChanged:
                                                                              (value) {
                                                                            temptempProsSelected.update((val) {
                                                                              temptempProsSelected.value.contains(e) ? val?.remove(e) : val?.add(e);
                                                                            });
                                                                          }))
                                                                  ,
                                                              12.h,
                                                              SimpleButton(
                                                                onTap: () {
                                                                  tempProsSelected
                                                                      .update(
                                                                          (val) {
                                                                    val = temptempProsSelected
                                                                        .value;
                                                                  });

                                                                  Get.back();
                                                                },
                                                                text: "OK",
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                        child: Container(
                                          constraints: const BoxConstraints(
                                            minHeight: 60,
                                          ),
                                          width: width,
                                          padding: const EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Obx(
                                                () => SizedBox(
                                                  width: width - 100,
                                                  child: AnimatedSwitcher(
                                                    duration: 333.milliseconds,
                                                    child: Align(
                                                      key: Key(tempProsSelected
                                                          .value.length
                                                          .toString()),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          interventionSelected
                                                                      .value ==
                                                                  null
                                                              ? const EText(
                                                                  "Selectionner",
                                                                  color: Colors
                                                                      .grey,
                                                                )
                                                              : tempProsSelected
                                                                      .value
                                                                      .isEmpty
                                                                  ? const EText(
                                                                      "Selectionner",
                                                                      color: Colors
                                                                          .black,
                                                                    )
                                                                  : Wrap(
                                                                      children: tempProsSelected
                                                                          .value
                                                                          .map(
                                                                            (e) =>
                                                                                InkWell(
                                                                              onTap: () {
                                                                                tempProsSelected.update((val) {
                                                                                  val?.remove(e);
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                                                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                                                                                decoration: BoxDecoration(color: AppColors.blue.withOpacity(.2), borderRadius: BorderRadius.circular(12)),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    EText(e),
                                                                                    3.w,
                                                                                    const Icon(Icons.close, size: 12)
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                    ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 9.0),
                                    color: Colors.white,
                                    child: const EText(
                                      "Professionnels",
                                      size: 17,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              9.h,
                              SimpleButton(
                                  height: 40,
                                  onTap: () {
                                    if (tempProsSelected.value.isEmpty) {
                                      Toasts.error(context,
                                          description:
                                              "Selectionnez le type de professionnels recherchés");
                                      return;
                                    }
                                    var pros =
                                        jsonEncode(tempProsSelected.value);
                                        pros = EncryptionHelper().encryptText(pros);
                                    Get.toNamed(
                                        "${RoutesNames.trouverProfessionnel}?pros=$pros");
                                  },
                                  text: "Rechercher")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  12.h,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BigTitleText(
                          "Les agences en quelques questions",
                        ),
                        12.h,
                        Container(
                            height: 8,
                            width: 50,
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(21),
                                color: AppColors.color500)),
                        24.h,
                        ExpansionPanelList(
                          elevation: 0,
                          expandedHeaderPadding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 3),
                          expansionCallback: (panelIndex, isExpanded) {
                            safeSetState(
                              () {
                                items(width)[panelIndex].isExpanded =
                                    isExpanded;
                              },
                            );
                          },
                          children: items(width)
                              .map(
                                (item) => ExpansionPanel(
                                  canTapOnHeader: true,
                                  backgroundColor:
                                      AppColors.blue.withOpacity(.1),
                                  headerBuilder: (context, isExpanded) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 9.0, vertical: 12),
                                      child: EText(
                                        item.headerValue,
                                        weight: FontWeight.bold,
                                        maxLines: 4,
                                      ),
                                    );
                                  },
                                  body: item.expandedValue,
                                  isExpanded: item.isExpanded,
                                ),
                              )
                              .toList(),
                        ),
                        12.h,
                        Row(
                          children: [
                            Icon(CupertinoIcons.info_circle_fill,
                                size: 25, color: AppColors.blue),
                            6.w,
                            SizedBox(
                                width: width - 60,
                                child: EText(
                                    "Cliquez sur la question pour voir l'explication",
                                    color: AppColors.blue)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Item> items(width) => [
        Item(
            headerValue: "Pourquoi passer par une agence ?",
            isExpanded: false,
            expandedValue: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                children: [
                  const EText(
                    "En passant par une agence immobilière pour vendre votre bien, vous déléguez chaque étape de la vente à un professionnel aguerri qui connaît parfaitement le marché immobilier du secteur.",
                    weight: FontWeight.bold,
                  ),
                  const EText(
                    "Il va alors se charger de rédiger l'annonce de vente, publier des photos avantageuses, renseigner chaque prospect, organiser les visites, réaliser les visites, recevoir les offres d'achat, rédiger le compromis de vente, organiser la signature. De plus, vous bénéficiez d'un accompagnement et de conseils personnalisés en fonction de votre situation.",
                  ),
                  6.h,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.w,
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.radio_button_unchecked, size: 6),
                      ),
                      SizedBox(
                          width: width - 120,
                          child: const EText(
                              "L'agent immobilier vous fournit une estimation du prix juste et en cohérence avec le marché immobilier, il vous renseigne et réalise chaque démarche dans le respect du cadre légal. Il peut vous mettre en lien avec un notaire qui concrétisera la vente, ainsi qu'avec un diagnostiqueur qui réalisera les diagnostics immobiliers obligatoires.",
                              maxLines: 90))
                    ],
                  ),
                  6.h,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.w,
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.radio_button_unchecked, size: 6),
                      ),
                      SizedBox(
                          width: width - 120,
                          child: const EText(
                              "Enfin, il vous aide à y voir plus clair quant à la solvabilité et à la fiabilité des acquéreurs qui vous adressent une offre d'achat.",
                              maxLines: 90))
                    ],
                  ),
                ],
              ),
            )),
        Item(
          headerValue: "Comment choisir une agence immobilière ?",
          isExpanded: false,
          expandedValue: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              children: [
                const EText(
                  "Si vous souhaitez vendre par l'intermédiaire d'une agence immobilière, prenez le temps d'étudier plusieurs paramètres pour faire un choix judicieux.",
                  weight: FontWeight.bold,
                  maxLines: 90,
                ),
                9.h,
                const EText(
                  "Commencez par vérifier que l'agent immobilier détient sa carte professionnelle, car c'est un gage de sécurité. Il est préférable de choisir une agence spécialiste du secteur, et donc une agence de proximité. Opter pour une agence qui ne se situe pas trop loin du bien en vente est également un gage d'efficacité : cela maximise les chances de réaliser des visites plus rapidement aux prospects qui se rendent à l'agence pour prendre des renseignements. Choisissez également un agent immobilier ayant de l'expérience. Cela ne signifie pas que l'agence doit être implantée depuis plusieurs années, mais s'il s'agit d'une agence récente, assurez-vous que l'agent immobilier avait déjà exercé au sein d'une autre structure avant d'ouvrir son agence, et qu'il a l'habitude de commercialiser des biens similaires au vôtre. Enfin, assurez-vous également que l'agence immobilière met en place les moyens de communication nécessaires pour rendre l'annonce connue de toutes les personnes en recherche d'un bien ayant les caractéristiques du vôtre : annonce en vitrine, publication sur des sites d'annonces connus, listing en groupement d'agences, etc.",
                  maxLines: 90,
                )
              ],
            ),
          ),
        ),
        Item(
          headerValue: "Comment fonctionne une agence immobilière ?",
          isExpanded: false,
          expandedValue: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              children: [
                const EText(
                  "Il est important de comprendre comment fonctionne réellement une agence immobilière.",
                  weight: FontWeight.bold,
                  maxLines: 90,
                ),
                9.h,
                const EText(
                  "Une agence immobilière est une entreprise spécialisée dans les transactions immobilières, telles que la vente, l'achat, la location et la gestion de biens. Elle commence par accueillir les clients et évaluer les biens pour estimer leur valeur. Ensuite, un mandat de vente ou de location est signé, autorisant l'agence à commercialiser le bien via divers canaux. L'agent immobilier organise et réalise les visites, vérifie la solvabilité des prospects et négocie les offres. En cas d'accord, l'agence accompagne la rédaction des contrats et la finalisation de la transaction. Certaines agences offrent aussi des services de gestion locative, prenant en charge la gestion quotidienne des biens. Tout au long du processus, l'agence fournit des conseils et un accompagnement personnalisé.",
                  maxLines: 90,
                )
              ],
            ),
          ),
        )
      ];
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}
