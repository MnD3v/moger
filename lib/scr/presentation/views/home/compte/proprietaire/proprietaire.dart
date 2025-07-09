import 'dart:math';

import 'package:moger_web/scr/configs/app/export.dart';

class Proprietaire extends StatelessWidget {
  const Proprietaire({super.key});

  static final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed(
            "${RoutesNames.connexion}?return-url=${RoutesNames.proprietaire}");
      });
      return const Center();
    }
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EScaffold(
        appBar: appBar(width),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: EColumn(
            children: [
              Center(
                child: SizedBox(
                  width: width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.h,
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFFEF4E4),
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width - 170,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    12.h,
                                    const BigTitleText(
                                      "Estimer mon bien",
                                    ),
                                    9.h,
                                    const EText(
                                        "Obtenez simplement une estimation sur mesure de votre bien immobilier",
                                        maxLines: 6,
                                        weight: FontWeight.w500,
                                        color: Colors.black45),
                                    9.h,
                                    SimpleButton(
                                      width: 136.0,
                                      height: 36,
                                      onTap: () {
                                        Get.toNamed(
                                            RoutesNames.estimationExplain);
                                      },
                                      color: Colors.black,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const EText(
                                            "Estimer",
                                            weight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          6.w,
                                          Transform.rotate(
                                              angle: pi,
                                              child: Image.asset(
                                                Assets.icons("arrow-left.png"),
                                                color: Colors.white,
                                                width: 25,
                                              ))
                                        ],
                                      ),
                                    ),
                                    12.h,
                                  ],
                                ),
                              ),
                              Image(
                                image: AssetImage(
                                  Assets.icons("estimation.png"),
                                ),
                                height: 90,
                                width: 90,
                              )
                            ],
                          ),
                        ),
                        12.h,
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFF4F4FF),
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width - 140,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    12.h,
                                    const BigTitleText(
                                      "Déposer une annonce",
                                    ),
                                    9.h,
                                    const EText(
                                        "Publication facilement l'annonce de votre vente ou location immobilière",
                                        maxLines: 6,
                                        weight: FontWeight.w500,
                                        color: Colors.black45),
                                    9.h,
                                    SimpleButton(
                                      width: 209.0,
                                      onTap: () {
                                        Get.toNamed(
                                            RoutesNames.publicationExplain);
                                      },
                                      color: Colors.black,
                                      height: 36,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const EText(
                                            "Créer une annonce",
                                            weight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          6.w,
                                          Transform.rotate(
                                              angle: pi,
                                              child: Image.asset(
                                                Assets.icons("arrow-left.png"),
                                                color: Colors.white,
                                                width: 25,
                                              ))
                                        ],
                                      ),
                                    ),
                                    12.h,
                                  ],
                                ),
                              ),
                              Image(
                                image: AssetImage(
                                  Assets.icons("announce.png"),
                                ),
                                height: 90,
                                width: 90,
                              )
                            ],
                          ),
                        ),
                        24.h,
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: BigTitleText(
                            "Mes services",
                          ),
                        ),
                        6.h,
                        InkWell(
                          onTap: () {
                            Get.toNamed(RoutesNames.mesAnnonces);
                          },
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                                // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
                                color: const Color.fromARGB(255, 141, 80, 0)
                                    .withOpacity(.2),
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(9),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width - 130,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const BigTitleText(
                                          "Gérer mes annonces",
                                        ),
                                        9.h,
                                        const EText(
                                          "Voir, Editer, Supprimer, Changer le statut de mes biens",
                                          maxLines: 4,
                                          // color: Colors.white,
                                        ),
                                        12.h,
                                        SimpleButton(
                                          width: 120,
                                          height: 50,
                                          onTap: () {
                                            Get.toNamed(
                                                RoutesNames.mesAnnonces);
                                          },
                                          color: const Color.fromARGB(
                                              255, 124, 70, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const EText("Gérer",
                                                  weight: FontWeight.bold,
                                                  color: Colors.white),
                                              6.w,
                                              Transform.rotate(
                                                  angle: pi,
                                                  child: Image.asset(
                                                    Assets.icons(
                                                        "arrow-left.png"),
                                                    color: Colors.white,
                                                    width: 25,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ]),
                                ),
                                Transform.rotate(
                                  angle: pi * .03,
                                  child: Image(
                                    image:
                                        AssetImage(Assets.icons("house.png")),
                                    height: 70,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        24.h,
                        const BigTitleText(
                          "Autres services",
                        ),
                        _Element(
                            width: width,
                            onTap: () {
                              // Get.to(const ProfessionnelExplainAndChoose(), fullscreenDialog: true);
                            },
                            title: "Trouvez une agence",
                            description:
                                "Confier la vente et la location de mon bien à un professionnel."),
                        12.h,
                        _Element(
                            width: width,
                            onTap: () {
                              Get.toNamed(RoutesNames.faq);
                            },
                            title: "Aide & Contact",
                            description:
                                "Retrouvez la réponse à vos questions et plus encore."),
                        90.h,
                      ]),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _Element extends StatelessWidget {
  const _Element(
      {required this.onTap,
      required this.title,
      required this.description,
      required this.width});
  final width;
  final onTap;
  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(9),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: width - 105,
                  child: TitleText(
                    title,
                  ),
                ),
                SizedBox(
                    width: width - 105,
                    child: EText(
                      description,
                      maxLines: 4,
                    )),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }
}
