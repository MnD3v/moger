import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/controllers/favoris_controller.dart';

class RealStateCardParent extends StatelessWidget {
  const RealStateCardParent(
      {super.key,
      required this.realState,
      required this.icon,
      required this.width,
      required this.isHovered,
      this.proprio,
      this.showEtat});
  final isHovered;
  final width;
  final showEtat;
  final RealState realState;
  final Widget icon;
  final proprio;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RechercheController>();
    final _width = width > 800 ? 800 : width;
    return AnimatedContainer(
      duration: 333.milliseconds,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6),
      padding: const EdgeInsets.all(3.0),
      color: isHovered == realState.id
          ? const Color.fromARGB(255, 231, 231, 231)
          : Colors.white,
      child: width > 700
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets(
                controller,
                isHovered: isHovered == realState.id,
                imageHeight: 240,
                imageWidth: 390.0,
                detailsWidth: _width - 430.0,
                otherWidget: 32.h,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets(
                controller,
                isHovered: isHovered == realState.id,
                imageHeight: 295,
                imageWidth: _width,
                detailsWidth: _width,
                otherWidget: 0.h,
              ),
            ),
    );
  }

  widgets(controller,
      {required imageWidth,
      required imageHeight,
      required detailsWidth,
      required isHovered,
      required otherWidget}) {
    return [
      Hero(
        tag: realState.id,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 22.0, top: 35),
              child: Container(
                height: imageHeight,
                width: imageWidth,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 226, 226),
                    borderRadius: BorderRadius.circular(6)),
                child: realState.images.isEmpty
                    ? const Image(
                        image: AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.cover,
                      )
                    : AnimatedScale(
                        duration: 333.milliseconds,
                        scale: isHovered ? .9 : 1,
                        child: EFadeInImage(
                          radius: 6,
                          image: NetworkImage(realState.images[0]),
                        ),
                      ),
              ),
            ),
            //Vu ou appelé
            showEtat != true
                ? 0.h
                : Obx(
                    () => !controller.vus.value.contains(realState.id) &&
                            !controller.appeles.value.contains(realState.id)
                        ? 0.h
                        : Positioned(
                            top: 39,
                            right: 6,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.circular(2)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 4),
                                child: EText(
                                    controller.appeles.value
                                            .contains(realState.id)
                                        ? "Contacté"
                                        : "Déjà vu",
                                    color: controller.appeles.value
                                            .contains(realState.id)
                                        ? Colors.amber
                                        : Colors.white,
                                    size: 18,
                                    weight: FontWeight.w600)),
                          ),
                  ),
            Positioned(
              bottom: 30,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(2)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      child: Row(children: [
                        const Icon(Icons.photo_camera_back_outlined,
                            size: 13, color: Colors.white),
                        3.w,
                        EText(
                          realState.images.length.toString(),
                          color: Colors.white,
                          size: 18,
                          weight: FontWeight.w600,
                        )
                      ])),
                  3.h,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 6.0),
                    decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(2)),
                    child: EText(
                        GFunctions.isToday(realState.date)
                            ? "Aujourd'hui"
                            : GFunctions.isYesterday(realState.date)
                                ? 'Hier'
                                : GFunctions.ilYa(realState.date),
                        color: AppColors.white,
                        weight: FontWeight.w600,
                        size: 18),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left:
                  proprio == true || realState.smallPartenaire == null ? 0 : 12,
              child: realState.smallPartenaire == null
                  ? const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: EText("Propriétaire particulier"),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            final id = EncryptionHelper()
                                .encryptText(realState.smallPartenaire!.id);

                            Get.toNamed("${RoutesNames.agences}?id=$id");
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(1, .5),
                                      blurRadius: 3,
                                      color: Colors.black26)
                                ]),
                            child: EFadeInImage(
                              radius: 3,
                              image: (realState.smallPartenaire!.profil.isNul
                                      ? AssetImage(Assets.icons("s_vendre.png"))
                                      : NetworkImage(
                                          realState.smallPartenaire!.profil!))
                                  as ImageProvider,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 9.0),
                          child: EText(
                            realState.smallPartenaire!.nom,
                            size: 20,
                            weight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
      18.w,
      SizedBox(
        width: detailsWidth,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                otherWidget,
                Row(
                  children: [
                    EText(
                        "${GFunctions.priceString(realState.prix.toInt().toString())} Fcfa",
                        size: 35,
                        weight: FontWeight.bold),
                    EText((realState.vente
                        ? ''
                        : realState.categorie == Categories.terrains
                            ? '/ an'
                            : '  / mois')),
                  ],
                ),
                6.h,
                EText(
                  categorieToPresentationSingle(realState.categorie) +
                      (realState.vente ? " à vendre" : " à louer"),
                  size: 26,
                  maxLines: 4,
                  color: AppColors.color500,
                  weight: FontWeight.bold,
                ),
                6.h,
                EText(
                    realState.description
                        .replaceAll('*', '')
                        .replaceAll('\n', ' '),
                    size: 23,
                    maxLines: 4,
                    weight: FontWeight.w500,
                    color: AppColors.textColor),
                6.h,
                ETextRich(
                  textSpans: [
                    ETextSpan(
                        text: realState.quartier,
                        // color: AppColors.color500,
                        size: 22,
                        weight: FontWeight.w700,
                        underline: true),
                    ETextSpan(text: " • "),
                    ETextSpan(
                        text: realState.ville,
                        size: 22,
                        weight: FontWeight.w700),
                    ETextSpan(text: " • "),
                    ETextSpan(
                        text: realState.region,
                        size: 22,
                        weight: FontWeight.w700),
                  ],
                ),
                6.h,
              ],
            ),
            FavorisButton(realState: realState, delete: false)
          ],
        ),
      ),
    ];
  }
}

class RealStateCard extends StatelessWidget {
  const RealStateCard(
      {super.key,
      required this.realState,
      required this.width,
      required this.isHovered});
  final isHovered;
  final width;
  final RealState realState;
  @override
  Widget build(BuildContext context) {
    return RealStateCardParent(
      isHovered: isHovered,
      width: width,
      showEtat: true,
      realState: realState,
      icon: FavorisButton(
        delete: false,
        realState: realState,
      ),
    );
  }
}

class FavorisRealStateCard extends StatelessWidget {
  const FavorisRealStateCard(
      {super.key, required this.realState, required this.width});
  final width;
  final RealState realState;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavorisController>();
    var rController = Get.find<RechercheController>();
    return RealStateSimilaireCard(
        realState: realState, favorisController: controller);
    const Column(
      children: [
        /*     RealStateCardParent(
            isHovered: true,
            width: width,
            showEtat: true,
            realState: realState,
            icon: InkWell(
              onTap: () {
                Utilisateur.setFavorite(realState.id);

                controller.realStates.update((val) {
                  val?.remove(realState);
                });
              },
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 12),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          color: Colors.black12)
                    ]),
                child: Icon(
                  CupertinoIcons.trash,
                  color: AppColors.textColor,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SimpleOutlineButton(
                width: Get.width / 2 - 30,
                height: 45,
                color: Colors.black,
                onTap: () async {
                  var androidUrl =
                      "tel://${realState.contacts.indicatif + realState.contacts.numero}";
                  launchUrl(Uri.parse(androidUrl));
                  await saveAppeles(rController);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.phone),
                    EText(
                      "Appeler",
                      weight: FontWeight.bold,
                    )
                  ],
                ),
              ),
              SimpleButton(
                width: Get.width / 2 - 30,
                height: 45,
                color: Colors.black,
                onTap: () {
                  Get.bottomSheet(Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            var androidUrl =
                                '''whatsapp://send?phone=${realState.contacts.indicatif + realState.contacts.numero}&text=Bonjour !\nLe bien à la réference ${realState.id} m'interesse; est-il toujours disponible ?''';
                            launchUrl(Uri.parse(androidUrl));
                            await saveAppeles(rController);
                            Get.back();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Image(
                                  image: AssetImage(
                                      "assets/icons/social/whatsapp.png"),
                                  height: 60),
                              6.h,
                              const EText("Whatsapp", weight: FontWeight.bold)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var androidUrl =
                                'sms:${realState.contacts.indicatif + realState.contacts.numero}?body=Bonjour !\nLe bien à la réference ${realState.id} m\'interesse; est-il toujours disponible ?';
                            launchUrl(Uri.parse(androidUrl));
                            Get.back();
                            await saveAppeles(rController);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.mail,
                                  size: 60, color: AppColors.textColor),
                              6.h,
                              const EText("SMS", weight: FontWeight.bold)
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.mail,
                      color: Colors.white,
                    ),
                    3.w,
                    const EText(
                      "Message",
                      weight: FontWeight.bold,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      */
      ],
    );
  }

  Future<void> saveAppeles(RechercheController rController) async {
    waitAfter(1000, () async {
      var sharedPreferences = await SharedPreferences.getInstance();
      var appeles = sharedPreferences.getStringList("appeles") ?? [];
      if (!appeles.contains(realState.id)) {
        rController.appeles.update((val) {
          val?.add(realState.id);
        });
        appeles.add(realState.id);
      }
      appeles.length > 150 ? appeles.removeAt(0) : null;
      sharedPreferences.setStringList("appeles", appeles);
    });
  }
}

class RealStateSimilaireCard extends StatelessWidget {
  const RealStateSimilaireCard(
      {super.key,
      required this.realState,
      required this.favorisController,
      this.delete});
  final delete;
  final RealState realState;
  final favorisController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          width: 260,
          height: 240,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 5,
                    spreadRadius: 4,
                    color: Colors.black12)
              ]),
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(6)),
                child: SizedBox(
                  width: 260,
                  height: 120.0,
                  child: realState.images.isEmpty
                      ? const Image(
                          image: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover,
                        )
                      : EFadeInImage(
                          image: NetworkImage(realState.images[0]),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BigTitleText(
                          "${GFunctions.priceString(realState.prix.toInt().toString())} F",
                        ),
                        EText((realState.vente
                            ? ''
                            : realState.categorie == Categories.terrains
                                ? '/ an'
                                : '  / mois'))
                      ],
                    ),
                    TitleText(
                      realState.categorie,
                    ),
                    6.h,
                    EText(
                        realState.description
                            .replaceAll('*', '')
                            .replaceAll('\n', ' '),
                        maxLines: 1,
                        weight: FontWeight.w500,
                        color: AppColors.textColor),
                    6.h,
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: realState.quartier,
                            style: const TextStyle(
                              color: Colors.black,
                            )),
                        const TextSpan(text: " • "),
                        TextSpan(
                            text: realState.ville,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        const TextSpan(text: " • "),
                        TextSpan(
                            text: realState.region,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ]),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                      textScaleFactor: .7,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FavorisButton(
            delete: delete == true ? true : false,
            realState: realState,
          ),
        )
      ],
    );
  }
}

class FavorisButton extends StatelessWidget {
  const FavorisButton(
      {super.key, required this.realState, this.big, required this.delete});
  final bool delete;
  final big;
  final RealState realState;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Utilisateur.currentUser.value == null) {
          // Get.bottomSheet(NoAccount(
          //   function: () {
          //     Utilisateur.setFavorite(realState.id);
          //     if (controller.realStates.value != null) {
          //       controller.realStates.update((val) {
          //         controller.realStates.value!.contains(realState)
          //             ? val?.remove(realState)
          //             : val?.insert(0, realState);
          //       });
          //     }
          //   },
          //   title: "Créez un compte pour enregistrer vos annonces favorites",
          //   desc1: "Enregistrez vos favoris et revenez plus tard.",
          //   desc2: "Retrouvez vos favoris sur tous vos appareils.",
          // ));
          return;
        } else {
          Utilisateur.setFavorite(realState.id);
        }
      },
      child: Container(
        height: big == true ? 55 : 45,
        width: big == true ? 55 : 45,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              big == true
                  ? const BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 5,
                      color: Colors.black26)
                  : const BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      color: Colors.black12)
            ]),
        child: delete
            ? const Icon(CupertinoIcons.trash)
            : Obx(
                () => AnimatedSwitcher(
                  duration: 999.milliseconds,
                  child: Icon(
                    key: UniqueKey(),
                    Utilisateur.currentUser.value == null
                        ? CupertinoIcons.heart
                        : Utilisateur.currentUser.value!.favoris!
                                .contains(realState.id)
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                    color: Utilisateur.currentUser.value == null
                        ? Colors.black
                        : Utilisateur.currentUser.value!.favoris!
                                .contains(realState.id)
                            ? AppColors.color500
                            : AppColors.textColor,
                  ),
                ),
              ),
      ),
    );
  }
}

class InPartenaireRealStateCard extends StatelessWidget {
  const InPartenaireRealStateCard(
      {super.key, required this.realState, required this.width});
  final width;
  final RealState realState;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final id = EncryptionHelper().encryptText(realState.id);
        Get.toNamed("${RoutesNames.biens}?id=$id");
      },
      child: Container(
        height: 145,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(9)),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: realState.id,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 145,
                    width: 145,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 226, 226, 226),
                        borderRadius: BorderRadius.circular(6)),
                    child: realState.images.isEmpty
                        ? const Image(
                            image: AssetImage('assets/images/placeholder.png'),
                            fit: BoxFit.cover,
                          )
                        : EFadeInImage(
                            radius: 6,
                            image: NetworkImage(realState.images[0]),
                          ),
                  ),
                  Positioned(
                    bottom: 6,
                    left: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(2)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 4),
                            child: Row(children: [
                              const Icon(Icons.photo_camera_back_outlined,
                                  size: 13, color: Colors.white),
                              3.w,
                              EText(
                                realState.images.length.toString(),
                                color: Colors.white,
                                size: 18,
                                weight: FontWeight.w600,
                              )
                            ])),
                        3.h,
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 6.0),
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(2)),
                          child: EText(
                              GFunctions.isToday(realState.date)
                                  ? "Aujourd'hui"
                                  : GFunctions.isYesterday(realState.date)
                                      ? 'Hier'
                                      : GFunctions.ilYa(realState.date),
                              color: Colors.white,
                              weight: FontWeight.w600,
                              size: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            6.w,
            SizedBox(
              width: width - 183.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BigTitleText(
                        "${GFunctions.priceString(realState.prix.toInt().toString())} F",
                      ),
                      EText((realState.vente
                          ? ''
                          : realState.categorie == Categories.terrains
                              ? '/ an'
                              : '  / mois'))
                    ],
                  ),
                  TitleText(
                    realState.categorie,
                  ),
                  6.h,
                  EText(
                      realState.description
                          .replaceAll('*', '')
                          .replaceAll('\n', ' '),
                      maxLines: 1,
                      weight: FontWeight.w500,
                      color: Colors.black),
                  6.h,
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: realState.quartier,
                          style: const TextStyle(
                            color: Colors.black,
                          )),
                      const TextSpan(text: " • "),
                      TextSpan(
                          text: realState.ville,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const TextSpan(text: " • "),
                      TextSpan(
                          text: realState.region,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ]),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                    textScaleFactor: .7,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  6.h,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
