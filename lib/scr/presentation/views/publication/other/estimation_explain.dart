
import 'package:moger_web/scr/configs/app/export.dart';

class EstimationExplain extends StatelessWidget {
  const EstimationExplain({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

        return EScaffold(
          appBar: appBar(width),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            child: EColumn(children: [
              12.h,
              Center(
                child: Image(
                  image: AssetImage(Assets.icons("estimer_bien.png")),
                  height: 150,
                ),
              ),
              24.h,
              const EText(
                  "Lors de l'estimation d'un bien immobilier, de nombreux paramètres entrent en jeu, et il est essentiel de se faire accompagner par un professionnel pour obtenir une estimation précise et équitable. Voici quelques-uns des paramètres clés à prendre en considération :",
                  maxLines: 10,
                  weight: FontWeight.w500),
              12.h,
              const _Element(
                  title: "Emplacement : ",
                  description:
                      "L'emplacement est l'un des facteurs les plus importants dans la détermination de la valeur d'un bien immobilier. Des éléments tels que la proximité des commodités, des transports en commun, des écoles et des zones commerciales peuvent avoir un impact significatif sur le prix."),
              const _Element(
                title: "Taille et configuration : ",
                description:
                    "La taille de la propriété, y compris le nombre de chambres, de salles de bains et d'espaces de vie, ainsi que la configuration générale de la maison, jouent un rôle majeur dans son évaluation. Les acheteurs potentiels auront des besoins différents en fonction de leur situation familiale et de leurs préférences personnelles.",
              ),
              const _Element(
                title: "État de la propriété : ",
                description:
                    "L'état général de la propriété, y compris son âge, son niveau de rénovation et son entretien, peut influencer sa valeur sur le marché. Les propriétés bien entretenues et rénovées peuvent souvent se vendre à un prix plus élevé que celles qui nécessitent des travaux importants.",
              ),
              const _Element(
                title: "Comparables sur le marché : ",
                description:
                    "Les professionnels de l'immobilier utilisent souvent des ventes comparables pour estimer la valeur d'une propriété. Cela implique de rechercher des biens similaires récemment vendus dans la même région pour établir un prix de référence.",
              ),
              const _Element(
                title: "Tendances du marché : ",
                description:
                    "Les conditions du marché immobilier local et national peuvent avoir un impact sur la valeur d'une propriété. Un agent immobilier peut fournir des informations précieuses sur les tendances du marché actuelles et prévoir comment celles-ci pourraient influencer le prix de vente.",
              ),
              const _Element(
                title: "Réglementations locales : ",
                description:
                    "Il est important de prendre en compte les réglementations locales, telles que les taxes foncières, les restrictions de zonage et les règlements de construction, qui peuvent affecter la valeur d'une propriété.",
              ),
              const _Element(
                title: "Négociation et marketing : ",
                description:
                    "Les agents immobiliers sont formés pour négocier efficacement avec les acheteurs potentiels et pour commercialiser la propriété de manière à attirer un large éventail d'acheteurs. Leur expertise peut être précieuse pour maximiser le prix de vente final.",
              )
            ]),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(9.0),
            child: SimpleButton(
                onTap: () {
                  Get.back();
                  // Get.to(TrouverProfessionnel(
                  //   pros: [
                  //     'Agence immobilière',
                  //     'Agent commercial',
                  //   ],
                  // ));
                },
                text: "Trouver un professionnel"),
          ),
        );
      }
    );
  }
}

class _Element extends StatelessWidget {
  const _Element({required this.description, required this.title});
  final description;
  final title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_right_alt,
            color: AppColors.color500,
          ),
          9.w,
          SizedBox(
            width: Get.width - 70,
            child: ETextRich(
              textSpans: [
                ETextSpan(text: title, weight: FontWeight.bold, size: 22),
                ETextSpan(
                  text: description,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
