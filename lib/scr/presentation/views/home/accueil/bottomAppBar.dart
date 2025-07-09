import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/actualites/actualites.dart';
import 'package:moger_web/scr/presentation/views/home/search/agence/widgets/social_element.dart';

class bottomAppBar extends StatelessWidget {
  const bottomAppBar({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ETextRich(
                    textSpans: [
                      ETextSpan(
                          text: "Les actualités de ", weight: FontWeight.w500),
                      ETextSpan(text: "l'immobiler", weight: FontWeight.bold)
                    ],
                    size: 36,
                  ),
                  Container(height: 4, width: 35, color: AppColors.color500),
                  24.h,
                  ActualitePage(
                    actualites: actualites,
                  )
                ],
              ),
            ),
          ),
        ),
        48.h,
        Container(
            color: Colors.black,
            padding: const EdgeInsets.all(12),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: 230,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EText("Rétrouvez-nous sur...",
                              weight: FontWeight.w500,
                              size: 24,
                              color: Colors.white),
                          Wrap(
                            children: [
                              SocialElement(
                                url: "partenaire.reseauxSociaux!.facebook",
                                image: "facebook",
                              ),
                              SocialElement(
                                url: "partenaire.reseauxSociaux!.instagram",
                                image: "instagram",
                              ),
                              SocialElement(
                                url: "partenaire.reseauxSociaux!.linkedIn",
                                image: "linkedin",
                              ),
                              SocialElement(
                                url: " partenaire.reseauxSociaux!.twitter",
                                image: "twitter",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    24.w,
                    SizedBox(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BigTitleText("NOS APPLICATIONS",
                              color: Colors.white),
                          const EText("Decrouvrez nos application",
                              color: Colors.white),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(
                                  image:
                                      AssetImage(Assets.icons("android.png")),
                                  height: 35,
                                  color: Colors.white),
                              9.w,
                              const Icon(
                                  IconData(0xf04be,
                                      fontFamily: 'MaterialIcons'),
                                  color: Colors.white,
                                  size: 45),
                            ],
                          )
                        ],
                      ),
                    ),
                    24.w,
                    SizedBox(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BigTitleText("L'ENTREPRISE",
                              color: Colors.white),
                          9.h,
                          const EText("Qui sommes-nous ?", color: Colors.white),
                          const EText("Nous contacter", color: Colors.white),
                        ],
                      ),
                    ),
                    24.w,
                    SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BigTitleText("A DÉCOUVRIR",
                              color: Colors.white),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  RoutesNames.searchAndExplainProfessionnels);
                            },
                            child: const EText("Annuaire de professionnels",
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                12.h,
                const Divider(color: Colors.white),
                12.h,
                Wrap(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RoutesNames.conditionGenerale);
                      },
                      child: const EText(
                        "Conditions Générales d'Utilisation",
                        color: Colors.white,
                        underline: true,
                      ),
                    ),
                    12.w,
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RoutesNames.protectionDeDonnes);
                      },
                      child: const EText(
                        "Politique Générale de Protection des Données",
                        color: Colors.white,
                        underline: true,
                      ),
                    ),
                    12.w,
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RoutesNames.fonctionnementService);
                      },
                      child: const EText(
                        "Fonctionnement de notre service",
                        color: Colors.white,
                        underline: true,
                      ),
                    )
                  ],
                ),
              ],
            ))
      ],
    );
  }
}
