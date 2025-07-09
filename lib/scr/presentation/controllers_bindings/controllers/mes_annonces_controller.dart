import 'package:moger_web/scr/configs/app/export.dart';

class MesAnnoncesController extends GetxController {
  var fetchEnd = false.obs;
  var realStates = Rx<List<RealState>?>(null);
  var isLoading = false.obs;
  DocumentSnapshot<Object?>? lastDocument;

  getMyRealStates({String? type, bool? restart}) async {
    print(type);
    if (restart == true) {
      isLoading.value = true;
      lastDocument = null;
    }

    var userTelephone = Utilisateur.currentUser.value!.telephone.numero;

    var totalElement = await countElements(type);
    //-1 pour eviter une egalité quand il n'y pas d'element
    var realStateLength =
        realStates.value == null ? -1 : realStates.value!.length;
    if (totalElement == realStateLength) {
      fetchEnd.value = true;
    } else {
      var temp = <RealState>[];

      var q = await (lastDocument.isNul
              ? (type == null
                  ? DB
                      .firestore(Collections.biens)
                      .where('uid', isEqualTo: userTelephone)
                      .orderBy('initialDate', descending: true)
                  : DB
                      .firestore(Collections.biens)
                      .where('uid', isEqualTo: userTelephone)
                      .where("categorie", isEqualTo: type)
                      .orderBy('initialDate', descending: true))
              : (type == null
                  ? DB
                      .firestore(Collections.biens)
                      .where('uid', isEqualTo: userTelephone)
                      .orderBy('initialDate', descending: true)
                      .startAfterDocument(lastDocument!)
                  : DB
                      .firestore(Collections.biens)
                      .where('uid', isEqualTo: userTelephone)
                      .where("categorie", isEqualTo: type)
                      .orderBy('initialDate', descending: true)
                      .startAfterDocument(lastDocument!)))
          .limit(18)
          .get();
      print(q.docs.length);
      for (var element in q.docs) {
        temp.add(RealState.fromMap(element.data()));
      }
      if (realStates.value == null) {
        realStates.value = [];
        fetchEnd.value = false;
      }
      if (restart == true) {
        realStates.value = temp;
      } else {
        realStates.update((val) {
          val?.addAll(temp);
        });
      }

      temp.isEmpty
          ? null
          : lastDocument =
              await DB.firestore(Collections.biens).doc(temp.last.id).get();
      if (await countElements(type) == realStates.value!.length) {
        fetchEnd.value = true;
      }
    }
    isLoading.value = false;
  }

  Future<int?> countElements(String? type) async {
    var userTelephone = Utilisateur.currentUser.value!.telephone.numero;

    var a = await (type == null
            ? DB
                .firestore(Collections.biens)
                .where('uid', isEqualTo: userTelephone)
                .orderBy('initialDate', descending: true)
                .count()
            : DB
                .firestore(Collections.biens)
                .where('uid', isEqualTo: userTelephone)
                .orderBy('initialDate', descending: true)
                .where("categorie", isEqualTo: type)
                .count())
        .get();
    return a.count;
  }

  Future searchId(String id) async {
    var userTelephone = Utilisateur.currentUser.value!.telephone.numero;
    var q = await DB
        .firestore(Collections.biens)
        .where('uid', isEqualTo: userTelephone)
        .where('id', isEqualTo: id)
        .get();
    var temp = <RealState>[];
    for (var element in q.docs) {
      temp.add(RealState.fromMap(element.data()));
    }
    realStates.value = temp;
    fetchEnd.value = true;
  }

  Future delete(RealState realState) async {
    for (var element in realState.images) {
      try {
        await FStorage.deleteImage(element);
      } on Exception catch (e) {
        print(e);
      }
    }
    await RealState.deleteRealState(
        realState: realState,);
    realStates.update((val) {
      val?.remove(realState);
    });
  }
}
