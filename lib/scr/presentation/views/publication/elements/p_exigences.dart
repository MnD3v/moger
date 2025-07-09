import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/publication/publication.dart';

class PChooseExigences extends StatelessWidget {
  PChooseExigences({
    super.key,
  });

  var length = 0.obs;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EColumn(
        children: [
          const EText(
            "Passons aux exigences s'il y'en a",
            size: 26,
            weight: FontWeight.bold,
          ),
          12.h,
          OutlineTextField(
              maxLines: 8,
              minLines: 8,
              label: "Exigences du proprietaire",
              onChanged: (value) {
                length.value = value.length;
                Publication.realState.exigence = value;
              },
              phoneScallerFactor: phoneScallerFactor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width - 100,
                child: const EText(
                    "Précisez les conditions de l'acquisition du bien."),
              ),
              Obx(
                () => EText("${length.value}/4000"),
              )
            ],
          )
        ],
      );
    });
  }
}
