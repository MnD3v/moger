
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/search/widgets/real_state_card.dart';

class SeeAllRealStates extends StatelessWidget {
  SeeAllRealStates({super.key, required this.id});
  final String id;

  var sells = <RealState>[];
  var rents = <RealState>[];
  var isSells = true.obs;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

        return EScaffold(
          appBar: PreferredSize(
              preferredSize: Size(width, 100),
              child: Container(
                color: AppColors.color500,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Leading(color: Colors.white,),
                        9.w,
                        const BigTitleText("Biens du service", color: Colors.white),
                      ],
                    ),
                    9.h,
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              isSells.value = true;
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  TitleText(
                                    "Biens en vente",
                                    color: AppColors.white,
                                  ),
                                  6.h,
                                  AnimatedContainer(
                                      duration: 333.milliseconds,
                                      height: 6,
                                      width: width / 2 - 20,
                                      color:
                                          isSells.value ? AppColors.white : Colors.transparent)
                                ],
                              ),
                            ),
                          ),
                          9.w,
                          InkWell(
                            onTap: () {
                              isSells.value = false;
                            },
                            child: Container(
                              color: Colors.transparent,
        
                              child: Column(
                                children: [
                                  TitleText(
                                    "Biens en location",
                                    color: AppColors.white,
                                  ),
                                  6.h,
                                  AnimatedContainer(
                                      duration: 333.milliseconds,
                                      height: 6,
                                      width: width / 2 - 20,
                                      color: !isSells.value
                                          ? AppColors.white
                                          : Colors.transparent)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          body: FutureBuilder(
              future: fetchRealStates(),
              builder: (context, snapshot) {
                return DB.waiting(snapshot)
                    ? const ECircularProgressIndicator(
                        label: "Chargement...",
                      )
                    : DB.hasError(snapshot)
                        ? EError(
                            error: snapshot.error.toString(),
                            retry: () async {
                              eLoading(width: width);
                              try {
                                await fetchRealStates();
                              } catch (e) {
                                print(e);
                                Toasts.error(context,
                                    description: "Une erreur s'est produite");
                              }
                              Get.back();
                            },
                          )
                        : Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 9.0),
                              child: AnimatedSwitcher(
                                duration: 333.milliseconds,
                                child: isSells.value
                                    ? sells.isEmpty
                                        ? const Vide(
                                            message: "Aucun bien en vente.",
                                          )
                                        : ListView(
                                            key: UniqueKey(),
                                            children: sells
                                                .map((element) =>
                                                    InPartenaireRealStateCard(
                                                      width: 100,
                                                      realState: element,
                                                    ))
                                                .toList(),
                                          )
                                    : rents.isEmpty
                                        ? const Vide(
                                            message: "Aucun bien en location.",
                                          )
                                        : ListView(
                                            key: UniqueKey(),
                                            children: rents
                                                .map((element) =>
                                                    InPartenaireRealStateCard(
                                                      width: 100,
                                                      realState: element,
                                                    ))
                                                .toList(),
                                          ),
                              ),
                            ),
                          );
              }),
        );
      }
    );
  }

  fetchRealStates() async {
    sells.clear();
    rents.clear();
    var qSells = await DB
        .firestore(Collections.biens)
        .where("uid", isEqualTo: id)
        .where("vente", isEqualTo: true)
        .get();

    var qRents = await DB
        .firestore(Collections.biens)
        .where("uid", isEqualTo: id)
        .where("vente", isEqualTo: false)
        .get();

    for (var element in qSells.docs) {
      sells.add(RealState.fromMap(element.data()));
    }
    for (var element in qRents.docs) {
      rents.add(RealState.fromMap(element.data()));
    }
  }
}
