import 'package:moger_web/scr/configs/app/export.dart';

class MeOrPros extends StatelessWidget {
  const MeOrPros({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;
      return EScaffold(
          appBar: appBar(width),
          body: EColumn(children: [
            Center(
              child: Wrap(
                children: [
                  Container(
                    width: 320,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black12,
                        )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          "Seul",
                          color: AppColors.color500,
                        ),
                        const BigTitleText(
                          "Vendez vous-même à votre rythme.",
                          size: 34,
                        ),
                        9.h,
                        const TitleText(
                            "Faites tout vous-même, des photos jusqu'à la publication."),
                        12.h,
                        SimpleButton(
                          width: 190,
                          height: 40,
                          onTap: () {
                            Get.toNamed(RoutesNames.publicationExplain);
                          },
                          text: "Déposer mon annonce",
                        )
                      ],
                    ),
                  ),
                  12.h,
                  12.w,
                  Container(
                    width: 320,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black12,
                        )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          "Bien accompagné",
                          color: AppColors.color500,
                        ),
                        const BigTitleText(
                          "Vendez avec une agence en toute confiance.",
                          size: 34,
                        ),
                        9.h,
                        const TitleText(
                            "Profitez de l'accompagnement d'un expert de l'immobilier à chaque étape."),
                        12.h,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.star_border_outlined),
                            5.w,
                            const SizedBox(
                                width: 264,
                                child: EText(
                                    "Expertise local&conseils dans vos démarches")),
                          ],
                        ),
                        6.h,

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.euro),
                            5.w,
                            const SizedBox(
                                width: 264,
                                child: EText("Estimation personnalisée du prix de vente.")),
                          ],
                        ),
                        6.h,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.supervised_user_circle_outlined),
                            5.w,
                            const SizedBox(
                                width: 264,
                                child: EText("Sélection des acheteurs & gestion des visites")),
                          ],
                        ),
                        12.h,
                        SimpleButton(
                          width: 190,
                          height: 40,
                          onTap: () {
                            Get.toNamed(RoutesNames.searchAndExplainProfessionnels);
                          },
                          text: "Trouver une agence",
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomAppBar(width: constraints.maxWidth)
          ]));
    });
  }
}
