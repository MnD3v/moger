import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/data/datasources/real_state_repo_impl.dart';

class RechercheController extends GetxController {
  Recherche recherche = Recherche.empty;

  DocumentSnapshot<Object?>? lastDocument3;
  DocumentSnapshot<Object?>? lastDocument2;
  DocumentSnapshot<Object?>? lastDocument1;
  DocumentSnapshot<Object?>? lastDocument0;

  var animatedKey = DateTime.now().millisecondsSinceEpoch.toString();

  var hasError = false.obs;
  var fetchEnd = false.obs;
  var realStates = Rx<List<RealState>?>(null);

  var currentSearchIndex = 0.obs;

  var realStateSize = 0.obs;

  var vus = Rx<List<String>>([]);
  var appeles = Rx<List<String>>([]);

  var alertesIds = Rx<List<String>>([]);
  @override
  void onReady() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var result = sharedPreferences.getStringList("lastSearchs") ?? [];

    appeles.value = sharedPreferences.getStringList("appeles") ?? [];
    vus.value = sharedPreferences.getStringList("vus") ?? [];
    alertesIds.value = sharedPreferences.getStringList("alertesIds") ?? [];
    super.onReady();
  }


  Future<void> getRealStates(
      {bool? search, bool? restart,}) async {
    var tempAll = <RealState>[];
    if (search == true || restart == true) {
      lastDocument3 = null;
      lastDocument2 = null;
      lastDocument1 = null;
      lastDocument0 = null;
      animatedKey = DateTime.now().millisecondsSinceEpoch.toString();
    }

    var totalElement3 = await countElements3;
    var totalElement2 = await countElements2;
    var totalElement1 = await countElements1;
    var totalElement0 = await countElements0;

    var realStateLength = (realStates.value == null || search == true)
        ? -1
        : realStates.value!.length;

    realStateSize.value =
        totalElement3 + totalElement2 + totalElement1 + totalElement0;

    int countElements = 0;
    if (realStateSize.value == realStateLength) {
      fetchEnd.value = true;
    } else {
      var q;

      //

      //

      if (realStateLength < totalElement3) {
        q = await _queries3;
        var temp = <RealState>[];
        for (var element in q.docs) {
          temp.add(RealState.fromMap(element.data()));
        }
        temp.isEmpty
            ? null
            : lastDocument3 =
                await DB.firestore(Collections.biens).doc(temp.last.id).get();
        tempAll.addAll(temp);
        countElements = lengthCondition(realStates.value) + tempAll.length;
      }

      //

      //

      if (countElements == totalElement3) {
        q = await _queries2;
        var temp = <RealState>[];
        for (var element in q.docs) {
          temp.add(RealState.fromMap(element.data()));
        }
        temp.isEmpty
            ? null
            : lastDocument2 =
                await DB.firestore(Collections.biens).doc(temp.last.id).get();

        tempAll.addAll(temp);
        countElements = lengthCondition(realStates.value) + tempAll.length;
      }

      //

      //

      if (countElements == totalElement3 + totalElement2) {
        q = await _queries1;

        var temp = <RealState>[];
        for (var element in q.docs) {
          temp.add(RealState.fromMap(element.data()));
        }
        temp.isEmpty
            ? null
            : lastDocument1 =
                await DB.firestore(Collections.biens).doc(temp.last.id).get();

        tempAll.addAll(temp);
        countElements = lengthCondition(realStates.value) + tempAll.length;
      }

      //

      //

      if (countElements == totalElement3 + totalElement2 + totalElement1) {
        q = await _queries0;
        var temp = <RealState>[];
        for (var element in q.docs) {
          temp.add(RealState.fromMap(element.data()));
        }
        temp.isEmpty
            ? null
            : lastDocument0 =
                await DB.firestore(Collections.biens).doc(temp.last.id).get();

        tempAll.addAll(temp);
        countElements = lengthCondition(realStates.value) + tempAll.length;
      }

      //
      //

      if (search == true || restart == true) {
        realStates.value = tempAll;
      } else {
        realStates.update((val) {
          tempAll.isEmpty ? null : val?.addAll(tempAll);
        });
      }

      if (countElements == realStates.value!.length) {
        fetchEnd.value = true;
      }

      // var temp = <RealState>[];
      // for (var element in q.docs) {
      //   temp.add(RealState.fromMap(element.data()));
      // }
      // temp.isEmpty
      //     ? null
      //     : lastDocument1 =
      //         await DB.firestore(Collections.biens).doc(temp.last.id).get();
      // if (search == true || restart == true) {
      //   realStates.value = temp;
      // } else {
      //   realStates.update((val) {
      //     temp.isEmpty ? null : val?.addAll(temp);
      //   });
      // }
      // fetchEnd.value = false;

      // if (await countElements == realStates.value!.length) {
      //   fetchEnd.value = true;
      // }
    }
  }

  Future<int> get countElements3 async {
    var a = await realStateRepoImpl(recherche: recherche, level: 3)
        .countQueryWithCondition()
        .get();

    return a.count ?? 0;
  }

  Future<int> get countElements2 async {
    var a = await realStateRepoImpl(recherche: recherche, level: 2)
        .countQueryWithCondition()
        .get();

    return a.count ?? 0;
  }

  Future<int> get countElements1 async {
    var a = await realStateRepoImpl(recherche: recherche, level: 1)
        .countQueryWithCondition()
        .get();

    return a.count ?? 0;
  }

  Future<int> get countElements0 async {
    var a = await realStateRepoImpl(recherche: recherche, level: 0)
        .countQueryWithCondition()
        .get();

    return a.count ?? 0;
  }

  List<String> quartiersCondition(Recherche recherche) {
    return recherche.quartiers == null || recherche.quartiers!.isEmpty
        ? Constants.localites[recherche.region]![recherche.ville]!
        : recherche.quartiers!;
  }

  bool? meubleCondition(Recherche recherche) {
    return recherche.logementDetails.meuble;
  }

  int? nombrePieceCondition(Recherche recherche) {
    return recherche.logementDetails.nombrePieces;
  }

  Future<dynamic> get _queries3 async {
    if (lastDocument3.isNotNul) {
      return await realStateRepoImpl(recherche: recherche, level: 3)
          .queryWithConditions()
          .startAfterDocument(lastDocument3!)
          .limit(18)
          .get();
    } else {
      return await realStateRepoImpl(recherche: recherche, level: 3)
          .queryWithConditions()
          .limit(18)
          .get();
    }
  }

  Future<dynamic> get _queries2 async {
    if (lastDocument2.isNotNul) {
      return await realStateRepoImpl(recherche: recherche, level: 2)
          .queryWithConditions()
          .startAfterDocument(lastDocument2!)
          .limit(18)
          .get();
    } else {
      return await realStateRepoImpl(recherche: recherche, level: 2)
          .queryWithConditions()
          .limit(18)
          .get();
    }
  }

  Future<dynamic> get _queries1 async {
    if (lastDocument1.isNotNul) {
      return await realStateRepoImpl(recherche: recherche, level: 1)
          .queryWithConditions()
          .startAfterDocument(lastDocument1!)
          .limit(18)
          .get();
    } else {
      return await realStateRepoImpl(recherche: recherche, level: 1)
          .queryWithConditions()
          .limit(18)
          .get();
    }
  }

  Future<dynamic> get _queries0 async {
    if (lastDocument0.isNotNul) {
      return await realStateRepoImpl(recherche: recherche, level: 0)
          .queryWithConditions()
          .startAfterDocument(lastDocument0!)
          .limit(18)
          .get();
    } else {
      return await realStateRepoImpl(recherche: recherche, level: 0)
          .queryWithConditions()
          .limit(18)
          .get();
    }
  }

  RealStateRepoImpl realStateRepoImpl({required recherche, required level}) =>
      RealStateRepoImpl(
          level: level,
          nombrePieces: nombrePieceCondition(recherche),
          meuble: meubleCondition(recherche),
          quartiers: quartiersCondition(recherche),
          ville: recherche.ville,
          budgetMin: recherche.budgetMin ?? 0,
          categorie: recherche.categorie!,
          region: recherche.region!,
          budgetMax: recherche.budgetMax,
          sell: recherche.sell!);
}

//

int lengthCondition(List? list) {
  if (list == null) {
    return 0;
  }
  return list.length;
}
