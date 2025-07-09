
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/publication/publication.dart';

class PChoosePrix extends StatelessWidget {
  const PChoosePrix({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EColumn(children: [
      24.h,
      EText(
        Publication.realState.vente
            ? "A combien souhaitez vous vendre votre bien ?"
            : "A combien souhaitez vous louer votre bien ?",
        size: 26,
        maxLines: 4,
        weight: FontWeight.bold,
      ),
      24.h,
      const EText("* Information obligatoire"),
      12.h,
      OutlineTextField(
        separate: 3,
        phoneScallerFactor: phoneScallerFactor,
        // initialValue: max.toString(),
        onChanged: (value) {
          Publication.realState.prix =
              int.parse(value.replaceAll(" ", ""));
        },
        label: 'Prix*',
        number: true,
        suffix: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: EText(
              Publication.realState.vente
                  ? 'F'
                  : Publication.realState.categorie ==
                          Categories.terrains
                      ? "F/an"
                      : 'F/Mois',
              size: 19,
              weight: FontWeight.w900,
              color: AppColors.color500),
        ),
      ),
    ]);
  }
}
