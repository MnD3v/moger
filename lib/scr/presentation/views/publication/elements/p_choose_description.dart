import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/p_choose_type.dart';
import 'package:moger_web/scr/presentation/views/publication/publication.dart';

class PChooseDescription extends StatelessWidget {
  PChooseDescription(
      {super.key, required this.isMeuble, required this.nombrePieces});
  var isMeuble;

  var length = 0.obs;

  var groupeValue = "".obs;
  var nombrePieces;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EColumn(
        children: [
          12.h,
          const EText(
            "Passons à la description de votre bien",
            size: 26,
            weight: FontWeight.bold,
          ),
          12.h,
          const EText("* Information obligatoire"),
          12.h,
          Publication.realState.categorie != Categories.chambres &&
                  Publication.realState.categorie != Categories.maisons
              ? 0.h
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EText(
                      "Etat*",
                      weight: FontWeight.bold,
                    ),
                    _MeubleOrNot(
                      width: width,
                        isMeuble: isMeuble,
                        groupeValue: groupeValue,
                        label: "Meublé"),
                    _MeubleOrNot(
                      width: width,
                        isMeuble: isMeuble,
                        groupeValue: groupeValue,
                        label: "Non meublé"),
                    NoChangeInfos(width: width,),
                    24.h,
                  ],
                ),
          Publication.realState.categorie != Categories.chambres
              ? 0.h
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EText(
                      "Nombre de pièces*",
                      weight: FontWeight.bold,
                    ),
                    12.h,
                    Container(
                      height: 50,
                      width: 190,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(12)),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity: nombrePieces.value == 1 ? .0 : 1,
                              child: PlusMinus(
                                  iconData: CupertinoIcons.minus,
                                  onTap: () {
                                    nombrePieces.value == 1
                                        ? null
                                        : nombrePieces--;
                                  }),
                            ),
                            EText(
                              nombrePieces.value.toString(),
                              weight: FontWeight.bold,
                              size: 26,
                            ),
                            PlusMinus(
                                iconData: CupertinoIcons.add,
                                onTap: () {
                                  nombrePieces++;
                                }),
                          ],
                        ),
                      ),
                    ),
                    3.h,
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(55, 255, 193, 7),
                          borderRadius: BorderRadius.circular(6)),
                      child: const EText(
                        "Veuillez noter que seules les chambres et le salon sont considérés comme des pièces. La cuisine et les toilettes ne le sont pas.",
                      ),
                    ),
                    6.h,
                     NoChangeInfos(width: width,),
                    24.h,
                  ],
                ),
          const EText("Description du bien"),
          6.h,
          OutlineTextField(
              maxLines: 8,
              minLines: 8,
              label: "Description *",
              onChanged: (value) {
                length.value = value.length;
                Publication.realState.description = value;
              },
              phoneScallerFactor: phoneScallerFactor),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width - 100,
                child: const EText(
                  "Mettez en avant ses atouts en utilisant au moins 15 caractères.",
                  maxLines: 4,
                ),
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

class PlusMinus extends StatelessWidget {
  const PlusMinus({super.key, required this.iconData, required this.onTap});
  final onTap;
  final iconData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(9)),
        child: Icon(iconData),
      ),
    );
  }
}

class _MeubleOrNot extends StatelessWidget {
  _MeubleOrNot(
      {required this.width,required this.groupeValue, required this.label, required this.isMeuble});
  var isMeuble;
  final width;
  final label;
  final groupeValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        groupeValue.value = label;
        isMeuble.value = groupeValue == "Meublé" ? true : false;
      },
      child: Obx(
        () => AnimatedContainer(
          duration: 666.milliseconds,
          height: 60,
          width: width,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 9),
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
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: groupeValue.value == label
                    ? Icon(Icons.check_circle, color: AppColors.blue)
                    : const Icon(Icons.radio_button_unchecked,
                        color: Colors.black26),
              ),
              EText(
                label,
                weight: FontWeight.bold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
