import 'package:moger_web/scr/configs/app/export.dart';

class PartenaireCard extends StatelessWidget {
  const PartenaireCard({
    super.key,
    required this.partenaire,
    required this.width
  });
  final width;
  final Partenaire partenaire;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final id = EncryptionHelper().encryptText(partenaire.telephone.numero);

        Get.toNamed("${RoutesNames.agences}?id=$id");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
                width: 110,
                height: 110,
                child: EFadeInImage(
                    radius: 6, image: NetworkImage(partenaire.profil ?? ""))),
            6.w,
            SizedBox(
              width: width - 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.blue),
                      child: EText(partenaire.role, color: AppColors.white)),
                  TitleText(
                    partenaire.nomCommercial,
                    color: AppColors.color500,
                  ),
                  EText(
                    partenaire.description ?? "",
                    maxLines: 1,
                  ),
                  ETextRich(
                    textSpans: [
                      ETextSpan(
                        text: partenaire.quartier!,
                      ),
                      ETextSpan(text: " • "),
                      ETextSpan(
                          text: partenaire.ville!, weight: FontWeight.w500),
                      ETextSpan(text: " • "),
                      ETextSpan(
                          text: partenaire.region!, weight: FontWeight.w600),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
