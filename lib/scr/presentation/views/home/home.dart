import 'package:moger_web/scr/presentation/views/home/search/real_state_elements.dart/real_states_body_page.dart';
import 'package:moger_web/scr/presentation/views/home/search/widgets/search_elements/search_elements.dart';

import '../../../configs/app/export.dart';

var searchContainerWidth = 410.0;
var actualites = Rx<List<Actu>?>(null);

class Home extends StatelessWidget {
  Home({super.key});

  var sell = false.obs;

  var categorieSelected = Rx<String?>(null);

  var regionSelected = Rx<String?>(null);
  var villeSelected = Rx<String?>(null);
  var quartiersSelected = Rx<List<String>>([]);

  var budgetMax = Rx<int?>(null);
  var budgetMin = Rx<int?>(null);

  var isMeuble = Rx<bool?>(null);
  var nombrePieces = Rx<int?>(null);
  int currentSearchIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      if (width < 410) {
        searchContainerWidth = width;
      }
      return EScaffold(
        appBar: appBar(width),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: AppColors.color500,
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/1571463/pexels-photo-1571463.jpeg"),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        24.h,
                        const EText(
                          "Que recherchez-vous",
                          size: 45,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        Column(
                          children: [
                            Obx(
                              () => Stack(
                                children: [
                                  AnimatedPositioned(
                                    curve: Curves.ease,
                                    duration: 333.milliseconds,
                                    left: sell.value
                                        ? searchContainerWidth / 2 - 6
                                        : 0,
                                    child: Container(
                                        height: 46,
                                        margin: const EdgeInsets.all(3),
                                        width: searchContainerWidth / 2,
                                        decoration: BoxDecoration(
                                            color: AppColors.color500,
                                            borderRadius:
                                                BorderRadius.circular(0))),
                                  ),
                                  Container(
                                    width: searchContainerWidth ,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            60, 255, 150, 150),
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              sell.value = false;
                                            },
                                            child: SellOrLocate(
                                                label: "Louer",
                                                selected: sell.value)),
                                        InkWell(
                                            onTap: () {
                                              sell.value = true;
                                            },
                                            child: SellOrLocate(
                                                label: "Acheter",
                                                selected: !sell.value))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            3.h,
                            Container(
                              width: searchContainerWidth,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3)),
                              child: Column(
                                children: [
                                  12.h,
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width:
                                                  searchContainerWidth / 2 - 18,
                                              child: DropdownButtonFormField(
                                                value: regionSelected.value,
                                                items: [
                                                  Regions.savanes,
                                                  Regions.kara,
                                                  Regions.centrale,
                                                  Regions.plateaux,
                                                  Regions.maritime
                                                ]
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                          value: e,
                                                          child: EText(
                                                            e,
                                                            size: 21,
                                                            weight:
                                                                FontWeight.w600,
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  regionSelected.value = value;
                                                  villeSelected.value = null;
                                                },
                                                decoration: InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                3),
                                                        borderSide: const BorderSide(
                                                            color:
                                                                Colors.black12,
                                                            style: BorderStyle
                                                                .solid)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                3),
                                                        borderSide: const BorderSide(
                                                            color:
                                                                Colors.black12,
                                                            style: BorderStyle
                                                                .solid)),
                                                    labelText: "Région*",
                                                    labelStyle: const TextStyle(
                                                        fontSize: 22 *
                                                            .7 /
                                                            phoneScallerFactor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    floatingLabelBehavior: FloatingLabelBehavior.auto),
                                              ),
                                            ),
                                            Obx(
                                              () => SizedBox(
                                                width:
                                                    searchContainerWidth / 2 -
                                                        18,
                                                child: DropdownButtonFormField(
                                                  key: Key(villeSelected.value
                                                          .toString() +
                                                      regionSelected.value
                                                          .toString()),
                                                  value: villeSelected.value,
                                                  items: regionSelected.value ==
                                                          null
                                                      ? []
                                                      : sortStrings(Constants
                                                              .localites[
                                                                  regionSelected
                                                                      .value]!
                                                              .keys
                                                              .toList())
                                                          .map((e) =>
                                                              DropdownMenuItem(
                                                                value: e,
                                                                child: EText(
                                                                  e,
                                                                  size: 21,
                                                                  weight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ))
                                                          .toList(),
                                                  onChanged: (value) {
                                                    villeSelected.value =
                                                        value as String;
                                                    quartiersSelected.value =
                                                        [];
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: "Ville *",
                                                      labelStyle: const TextStyle(
                                                          fontSize: 22 *
                                                              .7 /
                                                              phoneScallerFactor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                  style: BorderStyle
                                                                      .solid)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          borderSide: const BorderSide(
                                                              color: Colors.black12,
                                                              style: BorderStyle.solid)),
                                                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        24.h,
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Obx(
                                                () => InkWell(
                                                  onTap: villeSelected.value ==
                                                          null
                                                      ? null
                                                      : () {
                                                          var tempquartiersSelected =
                                                              Rx<List<String>>(
                                                                  quartiersSelected
                                                                      .value);

                                                          chooseQuartiers(
                                                              width: width,
                                                              regionSelected,
                                                              villeSelected,
                                                              tempquartiersSelected,
                                                              quartiersSelected);
                                                        },
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minHeight: 60,
                                                    ),
                                                    width: Get.width,
                                                    padding:
                                                        const EdgeInsets.all(9),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Obx(
                                                          () => SizedBox(
                                                            child:
                                                                AnimatedSwitcher(
                                                              duration: 333
                                                                  .milliseconds,
                                                              child: Align(
                                                                key: Key(
                                                                    quartiersSelected
                                                                        .value
                                                                        .length
                                                                        .toString()),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: villeSelected
                                                                            .value ==
                                                                        null
                                                                    ? const EText(
                                                                        "Aucun",
                                                                      )
                                                                    : quartiersSelected
                                                                            .value
                                                                            .isEmpty
                                                                        ? const EText(
                                                                            "Sélectionnez",
                                                                          )
                                                                        : Wrap(
                                                                            children: quartiersSelected.value
                                                                                .map(
                                                                                  (e) => QuartierChoosed(
                                                                                    onTap: () {
                                                                                      quartiersSelected.update((val) {
                                                                                        val?.remove(e);
                                                                                      });
                                                                                    },
                                                                                    text: e,
                                                                                  ),
                                                                                )
                                                                                .toList(),
                                                                          ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Icon(Icons
                                                            .arrow_drop_down)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6.0),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 9.0),
                                              color: Colors.white,
                                              child: const EText(
                                                "Quartiers",
                                                size: 19,
                                                weight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        12.h,
                                        SizedBox(
                                          child: ETextField(
                                            onChanged: (value) {},
                                            phoneScallerFactor: 1,
                                            placeholder: "Budget max",
                                            suffix: const Padding(
                                              padding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 6.0),
                                              child: EText("Fcfa",
                                                  weight: FontWeight.bold,
                                                  size: 24,
                                                  color: Colors.black45),
                                            ),
                                          ),
                                        ),
                                        12.h,
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Categories.chambres,
                                            Categories.terrains,
                                            Categories.maisons,
                                            Categories.boutiques,
                                            Categories.bureau
                                          ]
                                              .map((element) =>
                                                  CategorieChoosed(
                                                    label: element,
                                                    categorieSelected:
                                                        categorieSelected,
                                                  ))
                                              .toList(),
                                        ),
                                        12.h,
                                        SimpleButton(
                                          // width: 180,
                                          radius: 0,
                                          onTap: () async {
                                            var controller =
                                                Get.find<RechercheController>();
                                            var recherche = Recherche.empty
                                                .copyWith(
                                                    budgetMax: budgetMax.value,
                                                    budgetMin: budgetMin.value,
                                                    categorie: categorieSelected
                                                        .value,
                                                    quartiers:
                                                        quartiersSelected.value,
                                                    region:
                                                        regionSelected.value,
                                                    sell: sell.value,
                                                    ville: villeSelected.value,
                                                    logementDetails:
                                                        LogementDetails(
                                                            meuble:
                                                                isMeuble.value,
                                                            nombrePieces:
                                                                nombrePieces
                                                                    .value));

                                            var sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            var list =
                                                sharedPreferences.getStringList(
                                                        "lastSearchs") ??
                                                    [];

                                            var recherche0 = recherche.toJson();
                                            print(recherche0);
                                            final a = recherche0;

                                            final encryptionHelper =
                                                EncryptionHelper();
                                            print("Encrypt");
                                            recherche0 = encryptionHelper
                                                .encryptText(recherche0);

                                            Get.toNamed('${RoutesNames.search}?q=$recherche0');
                                            controller.realStates.value = null;
                                          },
                                          text: "Rechercher",
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        24.h,
                      ],
                    ),
                  )),
              32.h,
              bottomAppBar(width: width),
            ],
          ),
        ),
      );
    });
  }

  void chooseQuartiers(
      Rx<String?> regionSelected,
      Rx<String?> villeSelected,
      Rx<List<String>> tempquartiersSelected,
      Rx<List<String>> quartiersSelected,
      {required width}) {
    var quartiers = sortStrings(
            Constants.localites[regionSelected.value]![villeSelected.value]!)
        .obs;
    return Custom.showDialog(EDialog(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: EColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              12.h,
              const EText("Quartiers", weight: FontWeight.bold, size: 28),
              12.h,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ETextField(
                    placeholder: "Rechercher",
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 9.0),
                      child: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      quartiers.value = search(
                          value, regionSelected.value, villeSelected.value);
                    },
                    phoneScallerFactor: phoneScallerFactor),
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...quartiers.value
                        .map((e) => CheckboxListTile.adaptive(
                            title: EText(e),
                            value: tempquartiersSelected.value.contains(e),
                            onChanged: (value) {
                              tempquartiersSelected.update((val) {
                                tempquartiersSelected.value.contains(e)
                                    ? val?.remove(e)
                                    : val?.add(e);
                              });
                            }))
                        ,
                    12.h,
                    SimpleButton(
                      onTap: () {
                        quartiersSelected.update((val) {
                          val = tempquartiersSelected.value;
                        });

                        Get.back();
                      },
                      text: "OK",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

