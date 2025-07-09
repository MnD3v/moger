
// import 'package:moger_web/scr/configs/app/export.dart';

// class ChooseBudget extends StatelessWidget {
//   ChooseBudget(
//       {super.key,
//       required this.max,
//       required this.min,
//       required this.location});
//   var max;
//   var min;

//   var location;

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<RechercheController>();

//     var tempMax = max.value;
//     var tempMin = min.value;
//     return EScaffold(
//         appBar: AppBar(
//           title: const TitleText(
//             "Budget",
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: EColumn(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               24.h,
             
//               Image(
//                 image: AssetImage(Assets.icons("budget_style.png")),
//                 height: 40,
//               ),
//                24.h,
//               UnderLineTextField(
//                 phoneScallerFactor: phoneScallerFactor,
//                 initialValue: GFunctions.separate(3, tempMin.toString()),
//                 separate: 3,
//                 onChanged: (value) {
//                   tempMin = int.tryParse(value.replaceAll(" ", "")) ?? 0;
//                 },
//                 label: 'Minimal',
//                 number: true,
//                 suffix: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 9.0),
//                   child: EText(!location ? 'F' : 'F/Mois',
//                       size: 22,
//                       weight: FontWeight.bold,
//                       color: AppColors.color500
//                       // weight: FontWeight.bold,
//                       ),
//                 ),
//               ),
//               24.h,
//               UnderLineTextField(
//                 phoneScallerFactor: phoneScallerFactor,
//                 initialValue: GFunctions.separate(3, tempMax.toString()),
//                 onChanged: (value) {
//                   tempMax = int.tryParse(value.replaceAll(" ", ""));
//                   // value.isEmpty ? controller.budgetMax == null : null;
//                 },
//                 separate: 3,
//                 label: 'Maximal',
//                 number: true,
//                 suffix: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 9.0),
//                   child: EText(!location ? 'F' : 'F/Mois',
//                       size: 22,
//                       weight: FontWeight.bold,
//                       color: AppColors.color500),
//                 ),
//               ),
             
//             ],
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: SimpleButton(
//             width: 170,
//             onTap: () {
//               if (tempMax != null && tempMin != null) {
//                 if (tempMin > tempMax) {
//                   Custom.showDialog(const EWarningWidget(width:width,
//                     message:
//                         "Le budget Minimal doit être inferieur ou égale budget Maximal",
//                   ));
//                   return;
//                 }
//               }
//               max.value = tempMax;
//               min.value = tempMin;
//               Get.back();
//             },
//             child: const EText(
//               "Continuer",
//               color: Colors.white,
//               weight: FontWeight.bold,
//             ),
//           ),
//         ));
//   }
// }
