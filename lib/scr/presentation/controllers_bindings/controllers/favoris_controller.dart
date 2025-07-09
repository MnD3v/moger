
import 'package:moger_web/scr/configs/app/export.dart';

class FavorisController extends GetxController {
  var realStates = Rx<List<RealState>?>(null);

  Future getFavoris() async {
    var temp = <RealState>[];
    for (var element in Utilisateur.currentUser.value!.favoris!) {
      try {
        var q = await DB.firestore(Collections.biens).doc(element).get();
      q.data().isNul? null:  temp.add(RealState.fromMap(q.data() as Map<String, dynamic>));
      } on Exception catch (e) {
       print(e);
      }
    }
    realStates.value = temp;
  }
}
