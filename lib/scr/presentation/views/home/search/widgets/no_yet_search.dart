
import 'package:moger_web/scr/configs/app/export.dart';

class NoYetSearch extends StatelessWidget {
  const NoYetSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const TitleText("Recherche", )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
            EColumn(crossAxisAlignment: CrossAxisAlignment.center, children: [
          24.h,
          Image(
            image: AssetImage(Assets.icons('search.png')),
            height: 90,
          ),
          24.h,
          const EText("Vous n'avez encore effectué aucune recherche.",
              weight: FontWeight.bold),
          12.h,
          const EText(
            "Entrez tous vos critères (type de bien, localisation, budget, etc.) pour obtenir des résultats précis et adaptés à vos besoins.",
            maxLines: 6,
            align: TextAlign.center,
          ),
          24.h,
          SimpleButton(
            width: 230,
            onTap: () {
              // Get.to(Search(), fullscreenDialog: true);
            },
            text: "Ma première recherche",
          )
        ]),
      ),
    );
  }
}
