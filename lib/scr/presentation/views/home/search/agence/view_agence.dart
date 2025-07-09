import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/search/agence/dialogs/signaler_service.dart';
import 'package:moger_web/scr/presentation/views/home/search/agence/dialogs/view_documents.dart';
import 'package:moger_web/scr/presentation/views/home/search/agence/view_all_real_states.dart';
import 'package:moger_web/scr/presentation/views/home/search/agence/widgets/collaborateur_card.dart';
import 'package:moger_web/scr/presentation/views/home/search/agence/widgets/view_agence_elements.dart';
import 'package:moger_web/scr/presentation/views/home/search/widgets/real_state_card.dart';

class ViewPartenaire extends StatelessWidget {
  ViewPartenaire({
    super.key,
  });
  var partenaire;
  List<RealState>? sells;
  List<RealState>? rents;
  var isSells = true.obs;
  var id;
  @override
  Widget build(BuildContext context) {
    id = Get.parameters['id'];

    id = EncryptionHelper().decryptText(id!);

    return EScaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;
        return FutureBuilder(
          future: partenaire != null ? null : getPartenaire(),
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
                            await getPartenaire();
                          } catch (e) {
                            print(e);
                            Toasts.error(context,
                                description: "Une erreur s'est produite");
                          }
                          Get.back();
                        },
                      )
                    : EColumn(
                        children: [
                          SizedBox(
                            width: width,
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      width: width,
                                      height: 200,
                                      decoration: const BoxDecoration(
                                          color: Colors.black),
                                      child: partenaire.couverture == null
                                          ? 0.h
                                          : InkWell(
                                              onTap: () {
                                                final imageProvider =
                                                    CachedNetworkImageProvider(
                                                        partenaire.couverture!);
                                                showImageViewer(
                                                    context, imageProvider,
                                                    doubleTapZoomable: true,
                                                    immersive: false,
                                                    useSafeArea: true,
                                                    onViewerDismissed: () {});
                                              },
                                              child: EFadeInImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          partenaire
                                                              .couverture!)),
                                            ),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                            width: width - 26,
                                            margin:
                                                const EdgeInsets.only(top: 150),
                                            padding: const EdgeInsets.all(9),
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 15,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(9)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  child:
                                                      partenaire.profil == null
                                                          ? 0.h
                                                          : InkWell(
                                                              onTap: () {
                                                                final imageProvider =
                                                                    CachedNetworkImageProvider(
                                                                        partenaire
                                                                            .profil!);
                                                                showImageViewer(
                                                                    context,
                                                                    imageProvider,
                                                                    doubleTapZoomable:
                                                                        true,
                                                                    immersive:
                                                                        false,
                                                                    useSafeArea:
                                                                        true,
                                                                    onViewerDismissed:
                                                                        () {});
                                                              },
                                                              child: EFadeInImage(
                                                                  radius: 3,
                                                                  image: CachedNetworkImageProvider(
                                                                      partenaire
                                                                          .profil!)),
                                                            ),
                                                ),
                                                12.h,
                                                Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 6,
                                                        vertical: 3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: AppColors.blue),
                                                    child: EText(
                                                        partenaire.role,
                                                        color:
                                                            AppColors.white)),
                                                EText(
                                                  partenaire.nomCommercial,
                                                  weight: FontWeight.w900,
                                                  size: 26,
                                                ),
                                                ETextRich(
                                                  textSpans: [
                                                    ETextSpan(
                                                      text:
                                                          partenaire.quartier!,
                                                    ),
                                                    ETextSpan(text: " • "),
                                                    ETextSpan(
                                                        text: partenaire.ville!,
                                                        weight:
                                                            FontWeight.w500),
                                                    ETextSpan(text: " • "),
                                                    ETextSpan(
                                                        text:
                                                            partenaire.region!,
                                                        weight:
                                                            FontWeight.w600),
                                                  ],
                                                ),
                                                EText(
                                                  partenaire
                                                      .localisationDescription,
                                                  maxLines: 3,
                                                  color: AppColors.color500,
                                                  weight: FontWeight.w500,
                                                ),
                                                12.h,
                                                const Divider(),
                                                12.h,
                                                EText(
                                                  partenaire.horaires,
                                                  maxLines: 4,
                                                ),
                                                Contacts(
                                                  partenaire: partenaire,
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                12.h,
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const EText(
                                        "Notre service immobilier",
                                        size: 28,
                                        weight: FontWeight.w900,
                                      ),
                                      Container(
                                          height: 6,
                                          width: 40,
                                          color: AppColors.color500),
                                      12.h,
                                      EText(partenaire.description,
                                          size: 22, weight: FontWeight.w500),
                                      24.h,
                                      FutureBuilder(
                                          future: sells != null
                                              ? null
                                              : fetchRealStates(),
                                          builder: (context, snapshot) {
                                            return DB.waiting(snapshot)
                                                ? const ECircularProgressIndicator(
                                                    label: "Chargement...",
                                                  )
                                                : DB.hasError(snapshot)
                                                    ? EError(
                                                        error: snapshot.error
                                                            .toString(),
                                                        retry: () async {
                                                          eLoading(width: width);
                                                          try {
                                                            await fetchRealStates();
                                                          } catch (e) {
                                                            print(e);
                                                            Toasts.error(
                                                                context,
                                                                description:
                                                                    "Une erreur s'est produite");
                                                          }
                                                          Get.back();
                                                        },
                                                      )
                                                    : Column(
                                                        children: [
                                                          Obx(
                                                            () => Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    isSells.value =
                                                                        true;
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      TitleText(
                                                                        "Biens en vente",
                                                                        color: AppColors
                                                                            .blue,
                                                                      ),
                                                                      6.h,
                                                                      AnimatedContainer(
                                                                          duration: 333
                                                                              .milliseconds,
                                                                          height:
                                                                              6,
                                                                          width: width / 2 -
                                                                              20,
                                                                          color: isSells.value
                                                                              ? AppColors.blue
                                                                              : Colors.white)
                                                                    ],
                                                                  ),
                                                                ),
                                                                9.w,
                                                                InkWell(
                                                                  onTap: () {
                                                                    isSells.value =
                                                                        false;
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      TitleText(
                                                                        "Biens en location",
                                                                        color: AppColors
                                                                            .blue,
                                                                      ),
                                                                      6.h,
                                                                      AnimatedContainer(
                                                                          duration: 333
                                                                              .milliseconds,
                                                                          height:
                                                                              6,
                                                                          width: width / 2 -
                                                                              20,
                                                                          color: !isSells.value
                                                                              ? AppColors.blue
                                                                              : Colors.white)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          9.h,
                                                          Obx(
                                                            () =>
                                                                AnimatedSwitcher(
                                                              duration: 333
                                                                  .milliseconds,
                                                              child: isSells
                                                                      .value
                                                                  ? sells!.isEmpty
                                                                      ? const Vide(
                                                                          message:
                                                                              "Aucun bien en vente.",
                                                                        )
                                                                      : Column(
                                                                          key:
                                                                              UniqueKey(),
                                                                          children: sells!
                                                                              .map((element) => InPartenaireRealStateCard(
                                                                                    realState: element,
                                                                                    width: width,
                                                                                  ))
                                                                              .toList(),
                                                                        )
                                                                  : rents!.isEmpty
                                                                      ? const Vide(
                                                                          message:
                                                                              "Aucun bien en location.",
                                                                        )
                                                                      : Column(
                                                                          key:
                                                                              UniqueKey(),
                                                                          children: rents!
                                                                              .map((element) => InPartenaireRealStateCard(
                                                                                    realState: element,
                                                                                    width: width,
                                                                                  ))
                                                                              .toList(),
                                                                        ),
                                                            ),
                                                          ),
                                                          9.h,
                                                          SimpleOutlineButton(
                                                            color: Colors.black,
                                                            onTap: () {
                                                              Get.to(
                                                                  SeeAllRealStates(
                                                                      id: id));
                                                            },
                                                            text: "Tout voir",
                                                          )
                                                        ],
                                                      );
                                          }),
                                      24.h,
                                      const BigTitleText(
                                        'Géolocalisation',
                                      ),
                                      12.h,
                                      EText(
                                        "Quartier ${partenaire.quartier}",
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
                                          child: partenaire.localisation == null
                                              ? Center(
                                                  child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(Icons.info),
                                                    6.h,
                                                    const EText(
                                                        "Localisation non pécisée"),
                                                  ],
                                                ))
                                              : Stack(
                                                  children: [
                                                    Map(partenaire: partenaire),
                                                    InkWell(
                                                      onTap: () {
                                                        final url =
                                                            'https://www.google.com/maps/search/?api=1&query=${partenaire.localisation!.latitude},${partenaire.localisation!.longitude}';
                                                        launchUrl(
                                                            Uri.parse(url));
                                                      },
                                                      child: Container(
                                                        height: width / 1.7,
                                                        width: width,
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                      24.h,
                                      partenaire.collaborateurs == null ||
                                              partenaire.collaborateurs!.isEmpty
                                          ? 0.h
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const EText(
                                                  "Nos collaborateurs",
                                                  size: 28,
                                                  weight: FontWeight.w900,
                                                ),
                                                ...partenaire.collaborateurs!
                                                    .map((element) =>
                                                        CollaborateurCard(
                                                            width: width,
                                                            element: element)),
                                                12.h,
                                              ],
                                            ),
                                      partenaire.siteInternet == null
                                          ? 0.h
                                          : InkWell(
                                              onTap: () {
                                                launchUrl(Uri.parse(
                                                    partenaire.siteInternet!));
                                              },
                                              child: Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        Assets.icons(
                                                            "internet.png")),
                                                    color: AppColors.blue,
                                                    height: 25,
                                                  ),
                                                  3.w,
                                                  EText("Site internet",
                                                      size: 22,
                                                      color: AppColors.blue,
                                                      weight: FontWeight.bold,
                                                      underline: true)
                                                ],
                                              ),
                                            ),
                                      partenaire.legalite == null ||
                                              (partenaire.legalite?.images
                                                      .isEmpty ??
                                                  true)
                                          ? 0.h
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                18.h,
                                                const BigTitleText("Legalité"),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    EText(partenaire
                                                        .legalite!.nom),
                                                    9.h,
                                                    InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                            ViewDocuments(
                                                                legalite: partenaire
                                                                    .legalite!),
                                                            fullscreenDialog:
                                                                true);
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        color:
                                                            Colors.transparent,
                                                        child: EText(
                                                          "Voir les documents",
                                                          underline: true,
                                                          color: AppColors
                                                              .color500,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                                notShowReseauxSociaux
                                    ? 0.h
                                    : ReseauSociaux(
                                        partenaire: partenaire,
                                      ),
                                12.h,
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      signalerDialog(
                                          context, partenaire.telephone.numero);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.flag_outlined,
                                          color: AppColors.color500,
                                        ),
                                        3.w,
                                        const EText(
                                          "Signaler le service",
                                          underline: true,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
          },
        );
      },
    ));
  }

  getPartenaire() async {
    var q = await DB.firestore(Collections.partenaires).doc(id).get();
    partenaire = Partenaire.fromMap(q.data()!);
  }

  fetchRealStates() async {
    sells = <RealState>[];
    rents = <RealState>[];
    var qSells = await DB
        .firestore(Collections.biens)
        .where("uid", isEqualTo: id)
        .where("vente", isEqualTo: true)
        .limit(10)
        .get();

    var qRents = await DB
        .firestore(Collections.biens)
        .where("uid", isEqualTo: id)
        .where("vente", isEqualTo: false)
        .limit(10)
        .get();

    for (var element in qSells.docs) {
      sells!.add(RealState.fromMap(element.data()));
    }
    for (var element in qRents.docs) {
      rents!.add(RealState.fromMap(element.data()));
    }
  }

  bool get notShowReseauxSociaux {
    if (partenaire.reseauxSociaux == null) {
      return true;
    }
    return (partenaire.reseauxSociaux!.facebook == null &&
        partenaire.reseauxSociaux!.instagram == null &&
        partenaire.reseauxSociaux!.linkedIn == null &&
        partenaire.reseauxSociaux!.twitter == null);
  }
}
