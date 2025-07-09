
import 'package:moger_web/scr/configs/app/export.dart';

class Congratulation extends StatelessWidget {
  const Congratulation({super.key});

  @override
  Widget build(BuildContext context) {
    return EScaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TitleText(
            "Validation",
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: EColumn(
          children: [
            24.h,
            const EText(
              "Félicitations !\nVotre annonce a bien été créée",
              weight: FontWeight.bold,
              size: 28,
            ),
            24.h,
            const EText(
              "Elle est actuellement en cours de vérification. Vous pouvez suivre son statut depuis votre espace propriétaire.",
              maxLines: 5,
            ),
            12.h,
            Image(
              image: AssetImage(Assets.icons("congratulation.png")),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(9.0),
        child: SimpleButton(
          onTap: () {
            Get.back();
            // Get.to(const MesAnnonces(), binding: MesAnnoncesBinding());
          },
          text: "Decouvrir l'espace propriétaire",
        ),
      ),
    );
  }
}
