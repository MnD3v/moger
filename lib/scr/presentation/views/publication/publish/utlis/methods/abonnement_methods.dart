// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:immobilier_apk/scr/config/app/export.dart';

// bool abonnementIsValide(categorie) {
//   var user = Utilisateur.currentUser!;
//   if (user.abonnements == null) {
//     return false;
//   } else if (user.abonnements![categorie] == null) {
//     return false;
//   } else {
//     return double.parse(
//             currentDate.toString().split(' ')[0].split('-').join()) <=
//         double.parse(user.abonnements![categorie]!.split('-').join());
//   }
// }

// Future<bool> get isFree async {
//   var user = Utilisateur.currentUser!;
//   DocumentSnapshot<Map<String, dynamic>> q;
//   var free = false;
//   try {
//     q = await DB.firestore(Categories.keys).doc('free').get();
//     free = q.data()?['free'];
//   } on Exception {}
//   if (free == true) {
//     return true;
//   }

//   if (user.monthPublications != null) {
//     var userAbonnementMonth =
//         '${user.monthPublications!.split('.')[0].split('-')[0]}-${user.monthPublications!.split('.')[0].split('-')[1]}';
//     var currentMonth =
//         '${currentDate.toString().split(' ')[0].split('-')[0]}-${currentDate.toString().split(' ')[0].split('-')[1]}';

//     if (userAbonnementMonth == currentMonth) {
//       int pubNomber = int.parse(user.monthPublications!.split('.')[1]);
//       if (pubNomber >= 5) {
//         return false;
//       } else {
//         return true;
//       }
//     } else {
//       return true;
//     }
//   } else {
//     return true;
//   }
// }

// bool saveMonthPublications(Utilisateur user) {
//   if (currentDate.isNul) {
//     return false;
//   }
//   if (user.monthPublications != null) {
//     if (user.monthPublications!.split('.')[0] ==
//         currentDate.toString().split(' ')[0]) {
//       int pubNomber = int.parse(user.monthPublications!.split('.')[1]);
//       pubNomber++;
//       user.monthPublications =
//           '${user.monthPublications!.split('.')[0]}.$pubNomber';
//     } else {
//       user.monthPublications = '${currentDate.toString().split(' ')[0]}.1';
//     }
//   } else {
//     user.monthPublications = '${currentDate.toString().split(' ')[0]}.1';
//   }
//   Utilisateur.setUser(user);
//   return true;
// }
