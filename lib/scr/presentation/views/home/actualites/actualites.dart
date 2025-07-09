import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/actualites/widgets/actualite_card.dart';

class ActualitePage extends StatelessWidget {
  ActualitePage({super.key,required this.actualites});

  Rx<List<Actu>?> actualites;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

        return FutureBuilder(
            future:actualites.value!=null?null: getActus(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const ECircularProgressIndicator(
                      label: "Chargement des publications",
                    )
                  : Obx(
                      () => actualites.value == null && DB.hasError(snapshot)
                          ? EError(
                              error: snapshot.error.toString(),
                              retry: () async {
                                eLoading(width: width);
                                try {
                                  await getActus();
                                } catch (e) {
                                  Toasts.error(context,
                                      description: "Une erreur s'est produite");
                                }
                                Get.back();
                              },
                            )
                          : actualites.value!.isEmpty
                              ? const Vide(message: "Aucune publication")
                              : Wrap(
                                  children: actualites.value!
                                      .map((element) => ActualiteCard(
                                        width: width,
                                            actu: element,
                                          ))
                                      .toList(),
                                ),
                    );
            });
      }
    );
  }

  getActus() async {
    var actualites0 = <Actu>[];
    var q = await DB.firestore(Collections.actualites).orderBy("date").get();
    for (var element in q.docs) {
      actualites0.add(Actu.fromMap(element.data()));
    }
    actualites.value = actualites0;
  }
}
