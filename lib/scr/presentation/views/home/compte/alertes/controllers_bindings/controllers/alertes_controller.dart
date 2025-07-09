
import 'package:moger_web/scr/configs/app/export.dart';

class AlertesController extends GetxController {
  var alertes = Rx<List<Recherche>?>(null);

  @override
  void onReady() async {
    
  }

  getAlertes() async {
    print(Utilisateur.currentUser.value!.telephone.numero);
    List docs = [];
    for (var element in Constants.categories) {
      var temp = await DB
          .firestore(Collections.alertes)
          .doc(element)
          .collection(Collections.alertes)
          .orderBy('id', descending: true)
          .where('uid', isEqualTo: Utilisateur.currentUser.value!.telephone.numero)
          .get();

      docs.addAll(temp.docs);
    }


    var temp = <Recherche>[];
    for (var element in docs) {
      final alerte = Recherche.fromMap(element.data());
      temp.add(alerte);
    }
    temp.sort(
      (a, b) => a.id.compareTo(b.id),
    );

    alertes.value = temp.reversed.toList();
  }

  delete({required Recherche alerte}) async {
    alertes.update((val) {
      val?.remove(alerte);
    });
    await DB
        .firestore(Collections.alertes)
        .doc(alerte.categorie)
        .collection(Collections.alertes)
        .doc(alerte.id)
        .delete();
  }
}
