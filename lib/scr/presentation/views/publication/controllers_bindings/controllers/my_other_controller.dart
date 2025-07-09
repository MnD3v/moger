// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:immobilier_apk/scr/config/app/export.dart';

// class MyOthersController extends GetxController {
//   var fetchEnd = false.obs;
//   var userTelephone = Utilisateur.currentUser!.telephone;
//   var realStates = Rx<List<RealState>?>(null);
//   DocumentSnapshot<Object?>? lastDocument;

//   getMyRealStates() async {
//     var totalElement = await countElements();
//     var realStateLength =
//         realStates.value == null ? -1 : realStates.value!.length;
//     if (totalElement == realStateLength) {
//       fetchEnd.value = true;
//     } else {
//       var temp = <RealState>[];

//       var q = await (lastDocument.isNul
//               ? DB
//                   .firestore(Categories.autres)
//                   .where('uid', isEqualTo: userTelephone)
//                   .orderBy('date', descending: true)
//               : DB
//                   .firestore(Categories.autres)
//                   .where('uid', isEqualTo: userTelephone)
//                   .orderBy('date', descending: true)
//                   .startAfterDocument(lastDocument!))
//           .limit(18)
//           .get();
//       for (var element in q.docs) {
//         temp.add(RealState.fromMap(element.data()));
//       }
//       if (realStates.value == null) {
//         realStates.value = [];
//         fetchEnd.value = false;
//       }
//       realStates.update((val) {
//         val?.addAll(temp);
//       });
//       temp.isEmpty
//           ? null
//           : lastDocument =
//               await DB.firestore(Categories.autres).doc(temp.last.id).get();
//       if (await countElements() == realStates.value!.length) {
//         fetchEnd.value = true;
//       }
//     }
//   }

//   Future<int?> countElements() async {
//     var a = await DB
//         .firestore(Categories.autres)
//         .where('uid', isEqualTo: userTelephone)
//         .orderBy('date', descending: true)
//         .count()
//         .get();
//     return a.count;
//   }

//   Future searchId(String id) async {
//     var q = await DB
//         .firestore(Categories.autres)
//         .where('uid', isEqualTo: userTelephone)
//         .where('id', isEqualTo: id)
//         .get();
//     var temp = <RealState>[];
//     for (var element in q.docs) {
//       temp.add(RealState.fromMap(element.data()));
//     }
//     realStates.value = temp;
//     fetchEnd.value = true;
//   }

//   Future delete(RealState realState) async {
//    await RealState.deleteRealState(
//         realState: realState, collection: Categories.autres);
//     realStates.update((val) {
//       val?.remove(realState);
//     });
//   }
// }
