// import 'package:immobilier_apk/scr/config/app/export.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/home_page.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/pages/search/search_elements.dart/choose/s_budget.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/pages/search/search_elements.dart/choose/s_buy_locate.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/pages/search/search_elements.dart/choose/s_details.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/pages/search/search_elements.dart/choose/s_localisation.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/pages/search/search_elements.dart/choose/s_categorie.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/pages/search/search_elements.dart/search_option.dart';

// class Search extends StatelessWidget {
//   Search({super.key, this.currentSearchIndex});
//   int? currentSearchIndex;
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<RechercheController>();

//     var recherche = currentSearchIndex == null
//         ? Recherche.empty
//         : controller.lastSearchs.value[currentSearchIndex!];

//     var buyLocate = Rx<String?>(recherche.sell == null
//         ? null
//         : recherche.sell!
//             ? RealState.acheter
//             : RealState.louer);

//     var typeSelected = Rx<String?>(recherche.categorie);

//     var regionSelected = Rx<String?>(recherche.region);
//     var villeSelected = Rx<String?>(recherche.ville);
//     var quartiersSelected = Rx<List<String>>(recherche.quartiers ?? []);

//     var budgetMax = Rx<int?>(recherche.budgetMax);
//     var budgetMin = Rx<int?>(recherche.budgetMin);

//     var isMeuble = Rx<bool?>(recherche.logementDetails.meuble);
//     var nombrePieces = Rx<int?>(recherche.logementDetails.nombrePieces);

//     return EScaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: const TitleText(
//           "Ma nouvelle recherche",
//         ),
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Obx(
//           () {
//             waitAfter(333, () {
//               if (buyLocate.value == RealState.acheter) {
//                 if (typeSelected.value == "Appartement ou Chambre") {
//                   typeSelected.value = null;
//                 }
//               }
//               if (typeSelected.value != Categories.chambres) {
//                 nombrePieces.value = null;
//               }
//               if (typeSelected.value != Categories.chambres &&
//                   typeSelected.value != Categories.maisons) {
//                 isMeuble.value = null;
//               }
//             });

//             return EColumn(children: [
//               SearchOption(
//                   onTap: () {
//                     Get.to(Buy_Locate(
//                       buy_locate: buyLocate,
//                     ));
//                   },
//                   result: buyLocate.value,
//                   icon: "sell_locate.png",
//                   label: "Acheter ou Louer ?"),
//               const Divider(),
//               SearchOption(
//                   result: typeSelected.value,
//                   onTap: () {
//                     Get.to(ChooseCategorie(
//                       buy: buyLocate.value == RealState.acheter,
//                       typeSelected: typeSelected,
//                     ));
//                   },
//                   icon: "home_s.png",
//                   label: "Quel type de bien ?"),
//               const Divider(),
//               SearchOption(
//                   width: 21,
//                   result: regionSelected.value == null
//                       ? null
//                       : "${quartiersSelected.value.isEmpty
//                               ? "Tous"
//                               : quartiersSelected.value
//                                   .map((e) => e)
//                                   .toList()
//                                   .join(", ")} - ${villeSelected.value} - ${regionSelected.value!} ",
//                   onTap: () {
//                     Get.to(SChooseLocalisation(
//                         quartiersSelected: quartiersSelected,
//                         regionSelected: regionSelected,
//                         villeSelected: villeSelected));
//                   },
//                   icon: "map.png",
//                   label: "A quel endroit ?"),
//               const Divider(),
//               SearchOption(
//                   optionel: true,
//                   result: budgetLabel(
//                       achat: buyLocate.value == RealState.acheter,
//                       budgetMax: budgetMax.value,
//                       budgetMin: budgetMin.value),
//                   onTap: () {
//                     Get.to(ChooseBudget(
//                       max: budgetMax,
//                       min: budgetMin,
//                       location:
//                           buyLocate.value == RealState.louer ? true : false,
//                     ));
//                   },
//                   icon: "budget.png",
//                   label: "Budget ?"),
//               const Divider(),
//               SearchOption(
//                   optionel: true,
//                   result: nombrePieces.value == null && isMeuble.value == null
//                       ? null
//                       : ((nombrePieces.value != null
//                               ? "${nombrePieces.value} Pièce(s)  "
//                               : "") +
//                           (isMeuble.value != null
//                               ? (isMeuble.value! ? "Meublé" : "Non meublé")
//                               : "")),
//                   onTap: () {
//                     Get.to(ChooseDetails(
//                       noDetails: typeSelected != Categories.chambres &&
//                           typeSelected != Categories.maisons,
//                       notChambre: typeSelected != Categories.chambres,
//                       isMeuble: isMeuble,
//                       nombrePieces: nombrePieces,
//                     ));
//                   },
//                   icon: "favoris_s.png",
//                   label: "Plus de details ?"),
//               // const Divider(),
//               // SearchOption(
//               //     onTap: () {}, icon: "favoris_s.png", label: "Détails ?"),
//             ]);
//           },
//         ),
//       ),
//       bottomNavigationBar: Container(
//           height: 170,
//           padding: const EdgeInsets.all(6),
//           alignment: Alignment.bottomCenter,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Obx(
//                 () => buyLocate.value == null ||
//                         typeSelected.value == null ||
//                         regionSelected.value == null
//                     ? Stack(
//                         alignment: Alignment.bottomCenter,
//                         children: [
//                           Container(
//                             width: 180,
//                             height: 70,
//                             padding: const EdgeInsets.all(9),
//                             margin: const EdgeInsets.only(bottom: 33),
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.circular(12)),
//                             child: const EText(
//                               "Les trois premiers champs sont recquis",
//                               align: TextAlign.center,
//                               maxLines: 4,
//                               color: Colors.white,
//                               weight: FontWeight.bold,
//                             ),
//                           ),
//                           const Icon(Icons.arrow_drop_down,
//                               size: 60, color: Colors.grey),
//                         ],
//                       )
//                     : 0.h,
//               ),
//               Obx(
//                 () => SimpleButton(
//                   color: buyLocate.value == null ||
//                           regionSelected.value == null ||
//                           typeSelected.value == null
//                       ? Colors.grey
//                       : null,
//                   width: 180,
//                   onTap: buyLocate.value == null ||
//                           regionSelected.value == null ||
//                           typeSelected.value == null
//                       ? null
//                       : () async {
//                           var recherche = Recherche.empty.copyWith(
//                               budgetMax: budgetMax.value,
//                               budgetMin: budgetMin.value,
//                               categorie: typeSelected.value,
//                               quartiers: quartiersSelected.value,
//                               region: regionSelected.value,
//                               sell: buyLocate.value == RealState.acheter
//                                   ? true
//                                   : false,
//                               ville: villeSelected.value,
//                               logementDetails: LogementDetails(
//                                   meuble: isMeuble.value,
//                                   nombrePieces: nombrePieces.value));

//                           var sharedPreferences =
//                               await SharedPreferences.getInstance();
//                           var list =
//                               sharedPreferences.getStringList("lastSearchs") ??
//                                   [];
//                           if (currentSearchIndex.isNotNul) {
//                             controller.lastSearchs.update((val) {
//                               val?[currentSearchIndex!] = recherche;
//                             });

//                             controller.currentSearchIndex.value =
//                                 currentSearchIndex!;
//                             list[currentSearchIndex!] = recherche.toJson();
//                             sharedPreferences.setStringList(
//                                 "lastSearchs", list);
//                           } else {
//                             controller.currentSearchIndex.value = 0;
//                             controller.lastSearchs.update((val) {
//                               val?.insert(0, recherche);
//                             });

//                             list.insert(0, recherche.toJson());
//                             controller.lastSearchs.value.length > 5
//                                 ? controller.lastSearchs.value.removeLast()
//                                 : null;
//                             list.length > 5 ? list.removeLast() : null;

//                             sharedPreferences.setStringList(
//                                 "lastSearchs", list);
//                           }

//                           Get.back();
//                           controller.realStates.value = null;
//                           waitAfter(999, () {
//                             HomePage.pageController.jumpToPage(1);
//                           });
//                           waitAfter(666, () {
//                             controller.load();
//                           });
//                         },
//                   child: const EText(
//                     "Voir les biens",
//                     color: Colors.white,
//                     weight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }

// String? budgetLabel(
//     {required budgetMin, required budgetMax, required bool achat}) {
//   if (budgetMin == null && budgetMax == null) {
//     return null;
//   } else if (budgetMax == null) {
//     return "entre $budgetMin et plus ${!achat ? "F/mois" : "F"}";
//   } else
//     return "entre ${budgetMin ?? 0} et $budgetMax ${!achat ? "F/mois" : "F"}";
// }
