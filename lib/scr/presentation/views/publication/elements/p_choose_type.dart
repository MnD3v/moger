import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/publication/publication.dart';

class PChooseType extends StatelessWidget {
  PChooseType({
    super.key,
  });
  var groupeValue = "".obs;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EColumn(
        children: [
          SizedBox(
            width: width,
            child: Column(
              children: [
                24.h,
                EText(
                  Publication.realState.vente
                      ? "Quel bien vendez-vous ?"
                      : "Quel bien louez-vous ?",
                  size: 26,
                  weight: FontWeight.bold,
                ),
                12.h,
                const EText("* Information obligatoire"),
                24.h,
                const EText(
                  "Type de bien*",
                  weight: FontWeight.bold,
                ),
                6.h,
                Publication.realState.vente
                    ? 0.h
                    : _ChooseType(
                        image: "chambre",
                        label: Categories.chambres,
                        groupeValue: groupeValue),
                _ChooseType(
                  image: "maison",
                  label: Categories.maisons,
                  groupeValue: groupeValue,
                ),
                _ChooseType(
                  image: "terrain",
                  label: Categories.terrains,
                  groupeValue: groupeValue,
                ),
                _ChooseType(
                    image: "boutique",
                    label: Categories.boutiques,
                    groupeValue: groupeValue),
                _ChooseType(
                  image: "bureau",
                  label: Categories.bureau,
                  groupeValue: groupeValue,
                ),
                12.h,
                NoChangeInfos(width: width)
              ],
            ),
          ),
        ],
      );
    });
  }
}

class NoChangeInfos extends StatelessWidget {
  const NoChangeInfos({super.key, this.width});
  final width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          CupertinoIcons.info_circle_fill,
          color: AppColors.blue,
        ),
        6.w,
        SizedBox(
          width: (width ?? Get.width) - 100,
          child: EText(
            "Cette information ne peut pas être modifiée après publication.",
            maxLines: 4,
            color: AppColors.blue,
          ),
        )
      ],
    );
  }
}

class _ChooseType extends StatelessWidget {
  const _ChooseType(
      {required this.groupeValue, required this.image, required this.label});
  final image;
  final label;
  final groupeValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        groupeValue.value = label;
        Publication.realState.categorie = label;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Obx(
          () => Stack(
            alignment: Alignment.topRight,
            children: [
              AnimatedContainer(
                duration: 666.milliseconds,
                height: 130,
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: groupeValue.value == label
                        ? AppColors.blue.withOpacity(.1)
                        : Colors.white,
                    border: Border.all(
                        width: groupeValue.value == label ? .8 : .8,
                        color: groupeValue.value == label
                            ? AppColors.blue
                            : Colors.black26),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage(Assets.icons("$image.png")),
                      height: 35,
                    ),
                    12.h,
                    EText(
                      label,
                      weight: FontWeight.bold,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: groupeValue.value == label
                    ? Icon(Icons.check_circle, color: AppColors.blue)
                    : const Icon(Icons.radio_button_unchecked,
                        color: Colors.black26),
              )
            ],
          ),
        ),
      ),
    );
  }
}
