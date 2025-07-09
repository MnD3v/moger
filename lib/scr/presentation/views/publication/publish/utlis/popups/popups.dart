// import 'package:flutter/cupertino.dart';
// import 'package:flutter_paygateglobal/paygate/models/new_transaction_response.dart';
// import 'package:flutter_paygateglobal/paygate/models/transaction_status.dart';
// import 'package:flutter_paygateglobal/paygate/paygate.dart';
// import 'package:immobilier_apk/scr/data/models/paiement.dart';
// import 'package:immobilier_apk/scr/config/app/export.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/menu/widgets/social_card.dart';

//  M_realStateProblemesDialog(realState) {
//   return Custom.showDialog(
// Dialog(
//     child: Padding(
//       padding: const EdgeInsets.all(21.0),
//       child: EColumn(
//         children: [
//           EText(
//             'Problemes',
//             size: 25,
//             color: AppColors.color500,
//             weight: FontWeight.bold,
//           ),
//           12.h,
//           IsNullString(realState.region)
//               ? const WarningElement(
//                   label: 'Veuillez selectionner la région',
//                 )
//               : 0.h,
//           IsNullString(realState.ville)
//               ? const WarningElement(
//                   label: 'Veuillez selectionner la ville',
//                 )
//               : 0.h,
//           IsNullString(realState.prix) || realState.prix == 0
//               ? const WarningElement(
//                   label: 'Veuillez saisir le prix',
//                 )
//               : 0.h,
//           !GFunctions.isPhoneNumber(realState.contacts)
//               ? const WarningElement(
//                   label: 'Veuillez saisir votre contact',
//                 )
//               : 0.h,
//           (realState.secondContacts != null &&
//                   !GFunctions.isPhoneNumber(realState.secondContacts!))
//               ? const WarningElement(
//                   label: 'Veuillez entrer un second numero Valide',
//                 )
//               : 0.h,
//           IsNullString(realState.description)
//               ? const WarningElement(
//                   label: 'Veuillez saisir une description du bien',
//                 )
//               : 0.h,
//           6.h,
//           SimpleButton(
//             onTap: () {
//               Get.back();
//             },
//             text: 'OK',
//             smallHeight: true,
//           )
//         ],
//       ),
//     ),
//   ));
// }

//  abonnementDialog(categorie) {
//   return Custom.showDialog(
// Dialog(
//     child: Padding(
//       padding: const EdgeInsets.all(9.0),
//       child: EColumn(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(Icons.warning_rounded, color: AppColors.color500, size: 35),
//           EText(
//             'Abonnement',
//             size: 26,
//             weight: FontWeight.bold,
//             color: AppColors.color500,
//           ),
//           12.h,
//           const EText(
//               'Vous avez epuisé votre nombre de publications gratuites pour ce mois. Veuillez vous abonner pour publier davantage',
//               maxLines: 5,
//               align: TextAlign.center,
//               size: 20),
//           12.h,
//           SimpleButton(
//             onTap: () {
//               Get.back();
//               paiementDialog(categorie);
//             },
//             text: "M'abonner",
//           ),
//         ],
//       ),
//     ),
//   ));
// }

//  paiementDialog(categorie) {
//   int numberMonths = 0;
//   String telephone = "";
//   return Custom.showDialog(
// Dialog(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: EColumn(
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           12.h,
//           Center(
//             child: EText('Abonnement',
//                 size: 25,
//                 weight: FontWeight.bold,
//                 color: AppColors.color500),
//           ),
//           12.h,
//           Row(
//             children: [
//               const EText('Nombre de mois'),
//               3.w,
//               EText('(3500 F / Mois)', color: AppColors.color500, size: 20)
//             ],
//           ),
//           ETextField(
//                     phoneScallerFactor: phoneScallerFactor,
//             onChanged: (value) {
//               numberMonths = int.tryParse(value) ?? 0;
//             },
//             placeholder: '1',
//             inputFormatter: [
//               FilteringTextInputFormatter.allow(RegExp("[0-9]")),
//               LengthLimitingTextInputFormatter(2),
//             ],
//           ),
//           12.h,
//           const EText('Numero'),
//           ETextField(
//                     phoneScallerFactor: phoneScallerFactor,
//             placeholder: "90909090",
//             inputFormatter: [
//               FilteringTextInputFormatter.allow(RegExp("[0-9]")),
//               LengthLimitingTextInputFormatter(8),
//             ],
//             onChanged: (value) {
//               telephone = value;
//             },
//             prefix: Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: EText("+228", size: 20, color: AppColors.color500),
//             ),
//             number: true,
//           ),
//           12.h,
//           SimpleButton(
//             onTap: () async {
//               if (numberMonths > 0) {
//                 if (GFunctions.isPhoneNumber(telephone)) {
//                   var apiKey = await getPaygateApiKey();
//                   if (apiKey == null) {
//                     Get.back();
//                     Custom.showDialog(
// const EWarningWidget(width:width,
//                       message:
//                           "Une erreur s'est produite, veuillez réessayer plus tard !",
//                     ));
//                     return;
//                   }
//                   Get.back();
//                   eLoading(width: width);
//                   Paygate.init(
//                     apiKey: apiKey,
//                     apiVersion: PaygateVersion.v1, // default PaygateVersion.v2

//                     identifierLength: 20, // optional, default 20
//                   );
//                   NewTransactionResponse response = await Paygate.payV1(
//                     amount: (3500 * numberMonths).toDouble(),

//                     provider: isMoov(telephone)
//                         ? PaygateProvider.moovMoney
//                         : PaygateProvider
//                             .tmoney, // required : PaygateProvider.moovMoney or PaygateProvider.tMoney
//                     identifier: DateTime.now()
//                         .millisecond
//                         .toString(), // optional : if empty, the transaction identifier will be generated by the plugin.
//                     description:
//                         '#MeLoger Publisher Transaction', // optional : description of the transaction
//                     phoneNumber:
//                         telephone, // required : phone number of the user
//                   );
//                   Get.back();
//                   if (response.ok) {
//                     var paiement = Paiement(
//                         phoneNumber: telephone,
//                         status: Paiement.waiting,
//                         txReference: response.txReference!,
//                         date: currentDate!.toString(),
//                         categorie: categorie,
//                         dateLimite: updateDate(numberMonths));

//                     //save waiting informations
//                     DB
//                         .firestore(Categories.paiements)
//                         .doc(Utilisateur.currentUser.value!.telephone)
//                         .collection(Categories.references)
//                         .doc(response.txReference)
//                         .set(paiement.toMap());

//                     confirmationDialog(telephone);
//                     // verify paiement status
//                     for (int i = 0; i < 66; i++) {
//                       await Future.delayed(6.seconds);
//                       var transaction = await response.verify();
//                       if (transaction.status == TransactionStatus.done) {
//                         paiement.status = Paiement.done;
//                         // save done status
//                         DB
//                             .firestore(Categories.paiements)
//                             .doc(Utilisateur.currentUser.value!.telephone)
//                             .collection(Categories.references)
//                             .doc(response.txReference)
//                             .set(paiement.toMap());

//                         if (Utilisateur.currentUser.value!.abonnements == null) {
//                           Utilisateur.currentUser.value!.abonnements = {
//                             Categories.chambres: null,
//                             Categories.terrains: null,
//                             Categories.maisons: null,
//                             Categories.boutiques: null,
//                             Categories.publication: null,
//                           };
//                         }
//                         Utilisateur.currentUser.value
//                                 ?.abonnements![Categories.publication] =
//                             updateDate(numberMonths);

//                         Utilisateur.setUser(Utilisateur.currentUser.value!);
//                         successDialog();
//                         break;
//                       }
//                     }
//                   } else {
//                     Get.back();
//                     Custom.showDialog(
// const EWarningWidget(width:width,
//                       message:
//                           "Une erreur s'est produite, veuillez réessayer plus tard !",
//                     ));
//                   }
//                 } else {
//                   Fluttertoast.showToast(
//                       msg: "Veuillez entrer un numero de telephone valide",
//                       fontSize: 20,
//                       backgroundColor: AppColors.color500,
//                       toastLength: Toast.LENGTH_LONG,
//                       gravity: ToastGravity.TOP);
//                 }

//                 Get.back();
//               } else {
//                 Fluttertoast.showToast(
//                     msg: "Entrez un nombre de mois valide",
//                     toastLength: Toast.LENGTH_LONG,
//                     fontSize: 22,
//                     backgroundColor: Colors.red,
//                     gravity: ToastGravity.TOP,
//                     textColor: Colors.white);
//               }
//             },
//             text: "Payer",
//           )
//         ],
//       ),
//     ),
//   ));
// }

// String updateDate(int numberMonths) {
//   var user = Utilisateur.currentUser;
//   String date = "";
//   if (user.value?.dateLimiteAbonnement == null) {
//     date = currentDate!.toString().split(' ')[0];
//   } else if (GFunctions.differencesOfDays(user.value!.dateLimiteAbonnement!, true) >
//       0) {
//     date = currentDate!.toString().split(' ')[0];
//   } else {
//     date = user.value!.dateLimiteAbonnement!;
//   }
//   var year = int.parse(date.split('-')[0]);
//   var month = int.parse(date.split('-')[1]);
//   var days = int.parse(date.split('-')[2]);

//   var totalMonth = (month + numberMonths);

//   for (var i = 0; i < numberMonths; i++) {
//     month == 12 ? month = 1 : month++;
//   }
//   year += totalMonth ~/ 13;

//   var result =
//       '$year-${GFunctions.intToHourString(month)}-${GFunctions.intToHourString(days)}';

//   return result;
// }

// bool isMoov(String telephone) {
//   if (telephone.startsWith("96") ||
//       telephone.startsWith("97") ||
//       telephone.startsWith("98") ||
//       telephone.startsWith("99") ||
//       telephone.startsWith("78") ||
//       telephone.startsWith("79")) {
//     return true;
//   }
//   return false;
// }

// confirmationDialog(String telephone) {
//   return Custom.showDialog(
// Dialog(
//     child: Padding(
//       padding: const EdgeInsets.all(9.0),
//       child: EColumn(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           EText("Confirmation",
//               size: 25,
//               font: Fonts.poppins,
//               color: AppColors.color500,
//               weight: FontWeight.w900),
//           9.h,
//           isMoov(telephone)
//               ? Text.rich(
//                   TextSpan(children: [
//                     const TextSpan(text: "Vous recevrez bientôt un message "),
//                     TextSpan(
//                         text: "FLOOZ",
//                         style: TextStyle(
//                             color: AppColors.color500,
//                             fontFamily: Fonts.poppins,
//                             fontWeight: FontWeight.w700)),
//                     const TextSpan(text: " vous indiquant de taper "),
//                     TextSpan(
//                         text: "*155*27#",
//                         style: TextStyle(
//                             color: AppColors.color500,
//                             fontFamily: Fonts.poppins,
//                             fontWeight: FontWeight.w700)),
//                     const TextSpan(text: " pour confirmer la transaction"),
//                     TextSpan(
//                         text: "\n\nRemarque:",
//                         style: TextStyle(
//                             fontSize: 22,
//                             decorationColor: AppColors.color500,
//                             decoration: TextDecoration.underline,
//                             // decorationStyle: TextDecorationStyle.double,
//                             color: AppColors.color500,
//                             fontWeight: FontWeight.bold)),
//                     const TextSpan(text: " Si votre solde FLOOZ est "),
//                     TextSpan(
//                         text: "insuffisant, ",
//                         style: TextStyle(
//                             color: AppColors.color500,
//                             fontWeight: FontWeight.bold)),
//                     const TextSpan(
//                         text:
//                             "vous ne recevrez pas le message de confirmation"),
//                   ]),
//                   style: const TextStyle(fontSize: 20),
//                   textScaleFactor: .7,
//                   textAlign: TextAlign.start)
//               : const EText(
//                   "Veuillez confirmer le payement sur votre telephone",
//                   maxLines: 5,
//                   align: TextAlign.center),
//                     const EText(
//               "En cas de probleme, contactez: ",
//               weight: FontWeight.w600,
//             ),
//             6.h,
//             SocialCard(
//               label: "98 78 45 89",
//               icon: Container(
//                 height: 25,
//                 width: 25,
//                 decoration: BoxDecoration(
//                     color: AppColors.coffee,
//                     borderRadius: BorderRadius.circular(9)),
//                 child:
//                     const Icon(CupertinoIcons.phone_fill, color: Colors.white),
//               ),
//               onTap: () async {
//                 eLoading(width: width);
//                 var androidUrl = "tel://+22898784589";
//                 await launchUrl(Uri.parse(androidUrl));
//                 Get.back();
//               },
//             ),
//             12.h,
//           6.h,
//           SimpleButton(
//               onTap: () {
//                 Get.back();
//               },
//               text: "D'accord")
//         ],
//       ),
//     ),
//   ));
// }

// successDialog() {
//   Custom.showDialog(
// Dialog(
//     child: Padding(
//       padding: const EdgeInsets.all(9.0),
//       child: EColumn(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           EText("Succès",
//               size: 25,
//               font: Fonts.poppins,
//               color: AppColors.color500,
//               weight: FontWeight.w900),
//           12.h,
//           const EText(
//             "Votre paiement s'est terminé avec succès",
//             maxLines: 4,
//             align: TextAlign.center,
//           ),
//           6.h,
//           SimpleButton(
//             onTap: () {},
//             text: "OK",
//           )
//         ],
//       ),
//     ),
//   ));
// }
