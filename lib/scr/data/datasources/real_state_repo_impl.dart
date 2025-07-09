// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moger_web/scr/configs/app/export.dart';

class RealStateRepoImpl {
  String categorie;
  String region;
  String? ville;
  int? budgetMax;
  int budgetMin;
  bool sell;
  bool? meuble;
  int? nombrePieces;
  List<String> quartiers;
  int level;
  RealStateRepoImpl({
    required this.categorie,
    required this.region,
    this.ville,
    this.budgetMax,
    required this.budgetMin,
    required this.sell,
    this.meuble,
    this.nombrePieces,
    required this.level,
    required this.quartiers,
  });

  Query<Map<String, dynamic>> get niveau0 {
    return DB
        .firestore(Collections.biens)
        .where('categorie', isEqualTo: categorie)
        .where('level', isEqualTo: level)
        .where('status', isEqualTo: Status.actif)
        .orderBy('prix', descending: true)
        .where('region', isEqualTo: region)
        .where('ville', isEqualTo: ville)
        .where('quartier', whereIn: quartiers)
        .where('vente', isEqualTo: sell)
        .where('prix', isGreaterThan: budgetMin - 1);
  }

  Query<Map<String, dynamic>> get niveau1 {
    return niveau0.where('prix', isLessThan: budgetMax! + 1);
  }

  Query<Map<String, dynamic>> get niveau2 {
    return (budgetMax == null ? niveau0 : niveau1)
        .where("logementDetails.meuble", isEqualTo: meuble);
  }

  Query<Map<String, dynamic>> get niveau3 {
    return niveau2.where("logementDetails.nombrePieces",
        isEqualTo: nombrePieces);
  }

  Query<Map<String, dynamic>> queryWithConditions() {
    if (nombrePieces != null) {
      return niveau3;
    }
    if (meuble != null) {
      return niveau2;
    }
    if (budgetMax != null) {
      return niveau1;
    }
    return niveau0;
  }

  AggregateQuery countQueryWithCondition() {
    if (nombrePieces != null) {
      return niveau3.count();
    }
    if (meuble != null) {
      return niveau2.count();
    }
    if (budgetMax != null) {
      return niveau1.count();
    }
    return niveau0.count();
  }
}
