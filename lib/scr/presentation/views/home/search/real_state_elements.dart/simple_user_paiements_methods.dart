// import 'package:flutter/cupertino.dart';
// import 'package:flutter_paygateglobal/paygate/models/new_transaction_response.dart';
// import 'package:flutter_paygateglobal/paygate/models/transaction_status.dart';
// import 'package:flutter_paygateglobal/paygate/paygate.dart';
// import 'package:immobilier_apk/scr/data/models/paiement.dart';
// import 'package:immobilier_apk/scr/presentation/views/home/menu/widgets/social_card.dart';
// import 'package:immobilier_apk/scr/presentation/views/publication/publish/utlis/popups/popups.dart';
// import 'package:immobilier_apk/scr/config/app/export.dart';

// avertissementPaiementPopup(context, {required RealState element}) {
//   double price = element.categorie == Categories.chambres 
//       ? 900
//       : 1800;
//   return Custom.showDialog(
//     Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(9.0),
//         child: EColumn(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             6.h,
//             EText('Contacts',
//                 size: 30,
//                 weight: FontWeight.w900,
//                 color: AppColors.color500),
//             12.h,
//             Text.rich(
//               TextSpan(children: [
//                 const TextSpan(
//                     text:
//                         "Pour obtenir les contacts de l'auteur de cette publication et les informations complètes de "),
//                 TextSpan(
//                     text: "${element.categorie == Categories.terrains
//                             ? "tous"
//                             : "toutes"} les autres "),
//                 TextSpan(
//                     text: element.categorie.toLowerCase(),
//                     style: TextStyle(
//                         color: AppColors.color500,
//                         fontWeight: FontWeight.bold)),
//                 const TextSpan(text: " pendant"),
//                 TextSpan(
//                     text: " UN MOIS",
//                     style: TextStyle(color: AppColors.color500)),
//                 const TextSpan(text: ", vous devez éffectuer un payement de "),
//                 TextSpan(
//                     text: "${price.toInt()} F",
//                     style: TextStyle(
//                         color: AppColors.color500,
//                         fontWeight: FontWeight.bold)),
//               ], style: TextStyle(fontSize: 20, color: AppColors.textColor)),
//               textScaleFactor: .7,
//               textAlign: TextAlign.center,
//             ),
//             12.h,
//             const EText(
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
//                     color: Colors.blue,
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
//             SimpleButton(
//                 onTap: () {
//                   Get.back();

//                   simpleUserPaiementPopup(context,
//                       element: element, price: price);
//                 },
//                 text: "D'accord")
//           ],
//         ),
//       ),
//     ),
//   );
// }

// simpleUserPaiementPopup(context, {required RealState element, required price}) {
//   String telephone = "";
//   return Custom.showDialog(EDialog(width: width,
//     child: Padding(
//       padding: const EdgeInsets.all(9.0),
//       child: EColumn(
//           // crossAxisAlignment:
//           //     CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: EText(
//                 'Paiement',
//                 size: 30,
//                 weight: FontWeight.bold,
//                 color: AppColors.color500,
//               ),
//             ),
//             12.h,
//             const EText('Telephone'),
//             3.h,
//             ETextField(
//               color: Colors.white30,
//               phoneScallerFactor: phoneScallerFactor,
//               onChanged: (value) {
//                 telephone = value;
//               },
//               number: true,
//               placeholder: '90 00 00 00',
//               inputFormatter: [
//                 FilteringTextInputFormatter.allow(RegExp("[0-9]")),
//                 LengthLimitingTextInputFormatter(8),
//               ],
//               prefix: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: EText('+228',
//                     color: AppColors.color500,
//                     size: 18,
//                     font: Fonts.poppins,
//                     weight: FontWeight.bold),
//               ),
//             ),
//             12.h,
//             SimpleButton(
//                 onTap: () async {
//                   if (!GFunctions.isPhoneNumber(telephone)) {
//                     Toasts.error(
//                       context,
//                       description:
//                           "Veuillez entrer un numero de telephone valide",
//                     );
//                     return;
//                   }
//                   var apiKey = await getPaygateApiKey();
//                   if (apiKey == null) {
//                     Get.back();
//                     Custom.showDialog(const EWarningWidget(width:width,
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
//                     amount: price,
//                     provider: isMoov(telephone)
//                         ? PaygateProvider.moovMoney
//                         : PaygateProvider
//                             .tmoney, // required : PaygateProvider.moovMoney or PaygateProvider.tMoney
//                     identifier: DateTime.now()
//                         .millisecond
//                         .toString(), // optional : if empty, the transaction identifier will be generated by the plugin.
//                     description:
//                         '#MeLoger Simple User Transaction', // optional : description of the transaction
//                     phoneNumber:
//                         telephone, // required : phone number of the user
//                   );

//                   if (response.ok) {
//                     Get.back();
//                     var paiement = Paiement(
//                         phoneNumber: telephone,
//                         status: Paiement.waiting,
//                         txReference: response.txReference!,
//                         date: DateTime.now().toString(),
//                         categorie: element.categorie,
//                         dateLimite: GFunctions.datePlusDays(28));
//                     //save waiting status
//                     DB
//                         .firestore(Categories.paiements)
//                         .doc(Utilisateur.currentUser.value!.telephone)
//                         .collection(Categories.references)
//                         .doc(response.txReference)
//                         .set(paiement.toMap());

//                     confirmationDialog(telephone);
//                     for (int i = 0; i < 66; i++) {
//                       await Future.delayed(6.seconds);
//                       var transaction = await response.verify();

//                       if (transaction.status == TransactionStatus.done) {
//                         paiement.status = Paiement.done;
//                         //save paiement new status
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
//                         Utilisateur
//                                 .currentUser.value!.abonnements![element.categorie] =
//                             GFunctions.datePlusDays(28);
//                         Utilisateur.setUser(Utilisateur.currentUser.value!);

//                         Get.isDialogOpen == true ? Get.back() : null;
//                         publishInformationsDialog(element: element);
//                         break;
//                       }
//                     }
//                   } else {
//                     Get.back();
//                     Custom.showDialog(const EWarningWidget(width:width,
//                       message:
//                           "Une erreur s'est produite, veuillez réessayer plus tard !",
//                     ));
//                   }
//                 },
//                 text: 'Payer')
//           ]),
//     ),
//   ));
// }

// publishInformationsDialog({required RealState element}) {
//   return Custom.showDialog(EDialog(width: width,
//     child: Padding(
//       padding: const EdgeInsets.all(9.0),
//       child: EColumn(crossAxisAlignment: CrossAxisAlignment.center, children: [
//         9.h,
//         EText(
//           'Contacts',
//           size: 30,
//           weight: FontWeight.w900,
//           color: AppColors.color500,
//         ),
//         9.h,
//         EText(
//           '+228 ${element.contacts}',
//           size: 22,
//           weight: FontWeight.bold,
//         ),
//         9.h,
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () async {
//                 eLoading(width: width);
//                 var androidUrl = '''tel://+228${element.contacts}''';
//                 await launchUrl(Uri.parse(androidUrl));
//                 Get.back();
//               },
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: AppColors.coffee,
//                     borderRadius: BorderRadius.circular(12)),
//                 child:
//                     const Icon(CupertinoIcons.phone_fill, color: Colors.white),
//               ),
//             ),
//             12.w,
//             InkWell(
//               onTap: () async {
//                 eLoading(width: width);
//                 var contact = '+228${element.contacts}';
//                 var androidUrl =
//                     "whatsapp://send?phone=$contact&text=*MOGER*\n\nSalut, je m'interesse a ce bien immobilier, est-il toujours disponible ?\n\n*Réference*: ${element.id}\n\n*Localisation*: ${element.region} / ${element.ville} / ${element.quartier}\n\n*Prix*: ${element.prix}${element.vente
//                             ? " F"
//                             : element.categorie == Categories.terrains
//                                 ? " F/An"
//                                 : " F/Mois"}\n*Description*: ${element.description}";
//                 await launchUrl(Uri.parse(androidUrl));
//                 Get.back();
//               },
//               child: const Image(
//                 image: AssetImage('assets/icons/social/whatsapp.png'),
//                 height: 50,
//               ),
//             ),
//           ],
//         ),
//         element.secondContacts == null ? 0.h : 9.h,
//         element.secondContacts == null
//             ? 0.h
//             : EText(
//                 '+228 ${element.secondContacts}',
//                 size: 22,
//                 weight: FontWeight.bold,
//               ),
//         element.secondContacts == null ? 0.h : 9.h,
//         element.secondContacts == null
//             ? 0.h
//             : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () async {
//                       var androidUrl =
//                           '''tel://+228${element.secondContacts}''';
//                       await launchUrl(Uri.parse(androidUrl));
//                     },
//                     child: Container(
//                       height: 40,
//                       width: 40,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(12)),
//                       child: const Icon(CupertinoIcons.phone_fill,
//                           color: Colors.white),
//                     ),
//                   ),
//                   12.w,
//                   InkWell(
//                     onTap: () async {
//                       var contact = '+228${element.secondContacts}';
//                       var androidUrl =
//                           '''whatsapp://send?phone=$contact&text=Salut, je m'interesse a ce bien immobilier, est-il toujours disponible ?\n\nID: ${element.id}\n\nRegion: ${element.region}\n\nDescription: ${element.description}''';
//                       await launchUrl(Uri.parse(androidUrl));
//                     },
//                     child: const Image(
//                       image: AssetImage('assets/icons/social/whatsapp.png'),
//                       height: 50,
//                     ),
//                   ),
//                 ],
//               ),
//         9.h,
//       ]),
//     ),
//   ));
// }
