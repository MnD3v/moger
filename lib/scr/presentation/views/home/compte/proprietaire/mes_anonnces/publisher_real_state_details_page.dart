import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:latlong2/latlong.dart';

class PublisherRealSTateDetailsPage extends StatelessWidget {
  PublisherRealSTateDetailsPage({
    super.key,
  });

  FlutterCarouselController buttonCarouselController = FlutterCarouselController();
  var currentImage = 0.obs;
  var realState;

  @override
  Widget build(BuildContext context) {
    var id = Get.parameters['id'];

    id = EncryptionHelper().decryptText(id!);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;
        return EScaffold(
          appBar: appBar(constraints.maxWidth),
          body: Center(
            child: FutureBuilder(
                future: realState != null
                    ? null
                    : DB.firestore(Collections.biens).doc(id).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ECircularProgressIndicator(
                      label: "Chargement",
                    );
                  }
                  realState = RealState.fromMap(snapshot.data!.data()!);
                  print(realState);
                  return EScaffold(
                    body: EColumn(
                      children: [
                        SizedBox(
                          width: width,
                          child: Column(
                            children: [
                              _ImageWidget(
                                  width: width,
                                  realState: realState,
                                  buttonCarouselController:
                                      buttonCarouselController,
                                  currentImage: currentImage),
                              12.h,
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ETextRich(textSpans: [
                                      ETextSpan(
                                          text: "Ref",
                                          underline: true,
                                          weight: FontWeight.bold),
                                      ETextSpan(text: ': '),
                                      ETextSpan(text: realState.id)
                                    ]),
                                    EText(
                                      categorieToPresentationSingle(
                                              realState.categorie) +
                                          (realState.vente
                                              ? " à vendre"
                                              : " à louer"),
                                      size: 26,
                                      maxLines: 4,
                                      weight: FontWeight.bold,
                                    ),
                                    9.h,
                                    EText(
                                      realState.quartier,
                                    ),
                                    Text.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                            text: "${realState.ville} - ",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600)),
                                        TextSpan(
                                            text: realState.region,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ]),
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 20,
                                      ),
                                      textScaleFactor: .7,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    9.h,
                                    Row(
                                      children: [
                                        EText(
                                          "${GFunctions.priceString(realState.prix.toInt().toString())} F",
                                          color: AppColors.textColor,
                                          weight: FontWeight.w700,
                                          size: 26,
                                        ),
                                        EText((realState.vente
                                            ? ''
                                            : realState.categorie ==
                                                    Categories.terrains
                                                ? '/ an'
                                                : '  / mois'))
                                      ],
                                    ),
                                    12.h,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black38,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: EText(
                                          GFunctions.isToday(realState.date)
                                              ? "Aujourd'hui"
                                              : GFunctions.isYesterday(
                                                      realState.date)
                                                  ? 'Hier'
                                                  : GFunctions.ilYa(
                                                      realState.date),
                                          color: AppColors.white,
                                          weight: FontWeight.w600,
                                          size: 18),
                                    ),
                                    const Divider(),
                                    12.h,
                                    const BigTitleText(
                                      'Descriptif du bien',
                                    ),
                                    6.h,
                                    EText(
                                      realState.description.replaceAll('*', ''),
                                      maxLines: 40,
                                      size: 23,
                                      weight: FontWeight.w500,
                                      color: AppColors.textColor,
                                    ),
                                    12.h,
                                    const BigTitleText(
                                      'Exigences',
                                    ),
                                    6.h,
                                    EText(
                                      IsNullString(realState.exigence)
                                          ? 'Aucune'
                                          : realState.exigence,
                                      weight: FontWeight.w500,
                                      maxLines: 30,
                                    ),
                                    12.h,
                                    const Divider(),
                                    12.h,
                                    const BigTitleText(
                                      'Géolocalisation',
                                    ),
                                    12.h,
                                    EText(
                                      "Quartier ${realState.quartier}",
                                      size: 22,
                                      weight: FontWeight.w500,
                                    ),
                                    9.h,
                                    Container(
                                        height: width / 1.9,
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 216, 216),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: realState.localisation == null
                                            ? Center(
                                                child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Icons.info),
                                                  6.h,
                                                  const EText(
                                                      "Localisation non pécisée"),
                                                ],
                                              ))
                                            : Stack(
                                                children: [
                                                  FlutterMap(
                                                    options: MapOptions(
                                                      initialCenter: LatLng(
                                                          realState
                                                              .localisation!
                                                              .latitude,
                                                          realState
                                                              .localisation!
                                                              .longitude),
                                                      initialZoom: 12.2,
                                                    ),
                                                    children: [
                                                      TileLayer(
                                                        urlTemplate:
                                                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                        userAgentPackageName:
                                                            'com.example.app',
                                                      ),
                                                      MarkerLayer(
                                                        markers: [
                                                          marker(
                                                            LatLng(
                                                                realState
                                                                    .localisation!
                                                                    .latitude,
                                                                realState
                                                                    .localisation!
                                                                    .longitude),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      final url =
                                                          'https://www.google.com/maps/search/?api=1&query=${realState.localisation!.latitude},${realState.localisation!.longitude}';
                                                      launchUrl(Uri.parse(url));
                                                    },
                                                    child: Container(
                                                      height: width / 1.7,
                                                      width: width,
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                    12.h,
                                    const Divider(),
                                    12.h,
                                    realState.smallPartenaire == null
                                        ? 0.h
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const BigTitleText(
                                                'Proposé par',
                                              ),
                                              12.h,
                                              InkWell(
                                                onTap: () {
                                                  final id = EncryptionHelper()
                                                      .encryptText(realState
                                                          .smallPartenaire!.id);

                                                  Get.toNamed(
                                                      "${RoutesNames.agences}?id=$id");
                                                },
                                                child: Container(
                                                  width: width,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 15,
                                                      horizontal: 9),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              21),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 5,
                                                          offset: Offset(1, .5),
                                                        )
                                                      ]),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: width - 110,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            EText(
                                                              realState
                                                                  .smallPartenaire!
                                                                  .nom,
                                                              size: 24,
                                                              weight: FontWeight
                                                                  .bold,
                                                              maxLines: 4,
                                                            ),
                                                            6.h,
                                                            Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        3),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                6),
                                                                    color: AppColors
                                                                        .blue),
                                                                child: EText(
                                                                    realState
                                                                        .smallPartenaire!
                                                                        .role,
                                                                    color: AppColors
                                                                        .white)),
                                                            9.h,
                                                            EText(
                                                              realState
                                                                  .smallPartenaire!
                                                                  .localisationDescription,
                                                              maxLines: 4,
                                                            ),
                                                            9.h,
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const EText(
                                                                  "Voir les autres annonces",
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                  size: 20,
                                                                ),
                                                                3.w,
                                                                const Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    size: 12)
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 65,
                                                        width: 65,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    realState
                                                                        .smallPartenaire!
                                                                        .profil!))),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              12.h,
                                              const Divider(),
                                              24.h,
                                            ],
                                          ),
                                    /*    notInSearch == true
                                    ? 0.h
                                    :  */
                                    12.h,
                                 
                                  ],
                                ),
                              ),
                              24.h,
                            ],
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SimpleOutlineButton(
                            height: 50,
                            radius: 3,
                            width: width - 130,
                            color: GFunctions.isToday(realState.date)
                                ? Colors.grey
                                : null,
                            onTap: GFunctions.isToday(realState.date)
                                ? () {}
                                : () async {
                                    eLoading(width: width);

                                    await RealState.setRealState(
                                        realState: realState.copyWith(
                                            date: DateTime.now().toString(),
                                            status: Status.actif));
                                    Get.back();
                                    Get.toNamed(RoutesNames.mesAnnonces);
                                    Toasts.success(context,
                                        description:
                                            "Modification effectuée avec succès");
                                  },
                            child: EText(
                              "Actualiser",
                              color: GFunctions.isToday(realState.date)
                                  ? Colors.grey
                                  : Theme.of(context).primaryColor,
                              weight: FontWeight.bold,
                            ),
                          ),
                          6.w,
                          SimpleOutlineButton(
                            radius: 3,
                            width: 50,
                            height: 50,
                            color: Colors.black54,
                            onTap: () {
                              final id =
                                  EncryptionHelper().encryptText(realState.id);
                              Get.toNamed(
                                  "${RoutesNames.editRealState}?id=$id");
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                    image:
                                        AssetImage(("assets/icons/edit.png")),
                                    height: 25,
                                    color: Colors.black54),
                              ],
                            ),
                          ),
                          6.w,
                          SimpleButton(
                            radius: 3,
                            width: 50,
                            height: 50,
                            color: Colors.black,
                            onTap: () {
                              Custom.showDialog(ETwoOptionsDialog(
                                width: width,
                                  confirmFunction: () async {
                                    Get.back();
                                    Get.back();
                                    eLoading(width: width);
                                    for (var element in realState.images) {
                                      try {
                                        await FStorage.deleteImage(element);
                                      } on Exception catch (e) {
                                        print(e);
                                      }
                                    }
                                    await RealState.deleteRealState(
                                      realState: realState,
                                    );

                                    Get.back();
                                    Toasts.success(context,
                                        description:
                                            "Element supprimé avec succès");
                                  },
                                  confirmationText: "Supprimer",
                                  body:
                                      "Souhaitez-vous vraiment supprimer ce bien ?",
                                  title: "Suppression"));
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.trash,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }


  Future<void> saveAppeles(RechercheController rController) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var appeles = sharedPreferences.getStringList("appeles") ?? [];
    // if (!appeles.contains(realState.id)) {
    //   rController.appeles.update((val) {
    //     val?.add(realState.id);
    //   });
    //   appeles.add(realState.id);
    // }
    // appeles.length > 150 ? appeles.removeAt(0) : null;
    // sharedPreferences.setStringList("appeles", appeles);
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.realState,
    required this.buttonCarouselController,
    required this.currentImage,
    required this.width,
  });
  final width;
  final RealState realState;
  final FlutterCarouselController buttonCarouselController;
  final RxInt currentImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 2.7,
      width: width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: Get.height / 2.3,
            width: width,
            decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 226, 226, 226),
                ),
            child: realState.images.isEmpty
                ? const Image(
                    image: AssetImage('assets/images/placeholder.png'),
                    fit: BoxFit.cover,
                  )
                : FlutterCarousel(
                      options: FlutterCarouselOptions(
                        controller: buttonCarouselController,
                        onPageChanged: (index, reason) {
                          currentImage.value = index;
                        },
                        showIndicator: false,
                        disableCenter: true,
                        physics: BouncingScrollPhysics(),
                        viewportFraction: 1
                      ),
                      items: realState.images
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                final imageProvider =
                                    CachedNetworkImageProvider(e);
                                showImageViewer(context, imageProvider,
                                    doubleTapZoomable: true,
                                    immersive: false,
                                    useSafeArea: true,
                                    onViewerDismissed: () {});
                              },
                              child: SizedBox(
                                height: 100,
                                width: Get.width,
                                child: EFadeInImage(
                                  image: CachedNetworkImageProvider(e),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  buttonCarouselController.previousPage();
                },
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    child: const Icon(Icons.arrow_back_ios)),
              ),
              InkWell(
                onTap: () {
                  buttonCarouselController.nextPage();
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(12),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Obx(
              () => Container(
                height: 30,
                width: 50,
                padding: const EdgeInsets.symmetric(horizontal: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)),
                child: EText(realState.images.isNotEmpty
                    ? "${currentImage.value + 1}/${realState.images.length}"
                    : "${currentImage.value}/0"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Marker marker(location) => Marker(
      width: 80.0,
      height: 80.0,
      point: location,
      child: Container(
        child: const Icon(
          Icons.location_pin,
          size: 40.0,
          color: Colors.red,
        ),
      ),
    );
