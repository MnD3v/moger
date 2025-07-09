// import 'package:diacritic/diacritic.dart';
// import 'package:moger_web/scr/configs/app/export.dart';
// import 'package:my_widgets/my_widgets.dart';

// class SChooseLocalisation extends StatelessWidget {
//   SChooseLocalisation(
//       {super.key,
//       required this.regionSelected,
//       required this.villeSelected,
//       required this.quartiersSelected});
//   Rx<String?> regionSelected;
//   Rx<String?> villeSelected;
//   Rx<List<String>> quartiersSelected;

//   @override
//   Widget build(BuildContext context) {
//     var tempRegionSelected = Rx<String?>(regionSelected.value);
//     var tempVilleSelected = Rx<String?>(villeSelected.value);
//     var tempQuartiersSelected = Rx<List<String>>(quartiersSelected.value);
//     var controller = Get.find<RechercheController>();

//     return StreamBuilder<Object>(
//       stream: null,
//       builder: (context, snapshot) {
//         return EScaffold(
//           appBar: AppBar(
//             title: const TitleText(
//               "Localisation",
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: EColumn(
//               children: [
//                 Center(
//                     child: Image(
//                   image: AssetImage(Assets.icons("style_map.png")),
//                   height: 50,
//                 )),
//                 24.h,
//                 DropdownButtonFormField(
//                   value: tempRegionSelected.value,
//                   items: [
//                     Regions.savanes,
//                     Regions.kara,
//                     Regions.centrale,
//                     Regions.plateaux,
//                     Regions.maritime
//                   ]
//                       .map((e) => DropdownMenuItem(
//                             value: e,
//                             child: EText(
//                               e,
//                               size: 21,
//                               weight: FontWeight.w600,
//                             ),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     tempRegionSelected.value = value;
//                     tempVilleSelected.value = null;
//                   },
//                   decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                               color: Colors.black12, style: BorderStyle.solid)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                               color: Colors.black12, style: BorderStyle.solid)),
//                       labelText: "Région*",
//                       labelStyle: TextStyle(
//                           fontSize: 22 * .7 / phoneScallerFactor,
//                           fontWeight: FontWeight.w500),
//                       floatingLabelBehavior: FloatingLabelBehavior.auto),
//                 ),
//                 24.h,
//                 Obx(
//                   () => DropdownButtonFormField(
//                     key: Key(tempVilleSelected.value.toString() +
//                         tempRegionSelected.value.toString()),
//                     value: tempVilleSelected.value,
//                     items: tempRegionSelected.value == null
//                         ? []
//                         : sortStrings(Constants
//                                 .localites[tempRegionSelected.value]!.keys
//                                 .toList())
//                             .map((e) => DropdownMenuItem(
//                                   value: e,
//                                   child: EText(
//                                     e,
//                                     size: 21,
//                                     weight: FontWeight.w600,
//                                   ),
//                                 ))
//                             .toList(),
//                     onChanged: (value) {
//                       tempVilleSelected.value = value as String;
//                       tempQuartiersSelected.value = [];
//                     },
//                     decoration: InputDecoration(
//                         labelText: "Ville *",
//                         labelStyle: TextStyle(
//                             fontSize: 22 * .7 / phoneScallerFactor,
//                             fontWeight: FontWeight.w500),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                                 color: Colors.black12, style: BorderStyle.solid)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                                 color: Colors.black12, style: BorderStyle.solid)),
//                         floatingLabelBehavior: FloatingLabelBehavior.auto),
//                   ),
//                 ),
//                 24.h,
//                 Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Obx(
//                         () => InkWell(
//                           onTap: tempVilleSelected.value == null
//                               ? null
//                               : () {
//                                   var temptempQuartiersSelected =
//                                       Rx<List<String>>(tempQuartiersSelected.value);
        
//                                   chooseQuartiers(
//                                     width: width,
//                                       tempRegionSelected,
//                                       tempVilleSelected,
//                                       temptempQuartiersSelected,
//                                       tempQuartiersSelected);
//                                 },
//                           child: Container(
//                             constraints: const BoxConstraints(
//                               minHeight: 60,
//                             ),
//                             width: Get.width,
//                             padding: const EdgeInsets.all(9),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black12),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Obx(
//                                   () => SizedBox(
//                                     width: Get.width - 80,
//                                     child: AnimatedSwitcher(
//                                       duration: 333.milliseconds,
//                                       child: Align(
//                                         key: Key(tempQuartiersSelected.value.length
//                                             .toString()),
//                                         alignment: Alignment.centerLeft,
//                                         child: tempVilleSelected.value == null
//                                             ? const EText(
//                                                 "Aucun",
//                                               )
//                                             : tempQuartiersSelected.value.isEmpty
//                                                 ? const EText(
//                                                     "Sélectionnez",
//                                                   )
//                                                 : Wrap(
//                                                     children: tempQuartiersSelected
//                                                         .value
//                                                         .map(
//                                                           (e) => QuartierChoosed(
//                                                             onTap: () {
//                                                               tempQuartiersSelected
//                                                                   .update((val) {
//                                                                 val?.remove(e);
//                                                               });
//                                                             },
//                                                             text: e,
//                                                           ),
//                                                         )
//                                                         .toList(),
//                                                   ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const Icon(Icons.arrow_drop_down)
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 6.0),
//                       margin: const EdgeInsets.symmetric(horizontal: 9.0),
//                       color: Colors.white,
//                       child: const EText(
//                         "Quartiers",
//                         size: 17,
//                         weight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 12.h
//               ],
//             ),
//           ),
//           bottomNavigationBar: Padding(
//             padding: const EdgeInsets.all(9.0),
//             child: SimpleButton(
//               width: 170,
//               onTap: () {
//                 if (tempRegionSelected.value == null) {
//                   Toasts.error(context,
//                       description:
//                           "Veuillez sélectionner la région dans laquelle vous souhaitez avoir le bien.");
//                   return;
//                 }
//                 if (tempVilleSelected.value == null) {
//                   Toasts.error(context,
//                       description:
//                           "Veuillez sélectionner la ville dans laquelle vous souhaitez avoir le bien.");
//                   return;
//                 }
//                 regionSelected.value = tempRegionSelected.value;
//                 villeSelected.value = tempVilleSelected.value;
//                 quartiersSelected.value = tempQuartiersSelected.value;
//                 Get.back();
//               },
//               child: const EText(
//                 "Continuer",
//                 color: Colors.white,
//                 weight: FontWeight.bold,
//               ),
//             ),
//           ),
//         );
//       }
//     );
//   }

//   void chooseQuartiers(
//       Rx<String?> tempRegionSelected,
//       Rx<String?> tempVilleSelected,
//       Rx<List<String>> temptempQuartiersSelected,
//       Rx<List<String>> tempQuartiersSelected,{required width}) {
//     var quartiers = sortStrings(Constants
//             .localites[tempRegionSelected.value]![tempVilleSelected.value]!)
//         .obs;
//     return Custom.showDialog(EDialog(width: width,
//       child: Padding(
//         padding: const EdgeInsets.all(9.0),
//         child: EColumn(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             12.h,
//             const EText("Quartiers", weight: FontWeight.bold, size: 28),
//             12.h,
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: ETextField(
//                   placeholder: "Rechercher",
//                   prefix: Padding(
//                     padding: const EdgeInsets.only(left: 9.0),
//                     child: Icon(Icons.search),
//                   ),
//                   onChanged: (value) {
//                     quartiers.value = search(value, tempRegionSelected.value,
//                         tempVilleSelected.value);
//                   },
//                   phoneScallerFactor: phoneScallerFactor),
//             ),
//             Obx(
//               () => Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ...quartiers.value
//                       .map((e) => CheckboxListTile.adaptive(
//                           title: EText(e),
//                           value: temptempQuartiersSelected.value.contains(e),
//                           onChanged: (value) {
//                             temptempQuartiersSelected.update((val) {
//                               temptempQuartiersSelected.value.contains(e)
//                                   ? val?.remove(e)
//                                   : val?.add(e);
//                             });
//                           }))
//                       .toList(),
//                   12.h,
//                   SimpleButton(
//                     onTap: () {
//                       tempQuartiersSelected.update((val) {
//                         val = temptempQuartiersSelected.value;
//                       });

//                       Get.back();
//                     },
//                     text: "OK",
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }


// }
//   search(String value, region, ville) {
//     var qs = Constants.localites[region]![ville]!;
//     return qs.where((element) {
//       String normalizedItem = removeDiacritics(element.toLowerCase());
//       String normalizedQuery = removeDiacritics(value.toLowerCase());
//       return normalizedItem.toLowerCase().contains(normalizedQuery.toLowerCase());
//     }).toList();
//   }

// List<String> sortStrings(List<String> list) {
//   list.sort();
//   return list;
// }

// class QuartierChoosed extends StatelessWidget {
//   const QuartierChoosed({super.key, required this.text, required this.onTap});
//   final onTap;
//   final text;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//         margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
//         decoration: BoxDecoration(
//             color: AppColors.blue.withOpacity(.2),
//             borderRadius: BorderRadius.circular(12)),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [EText(text), 3.w, const Icon(Icons.close, size: 12)],
//         ),
//       ),
//     );
//   }
// }
