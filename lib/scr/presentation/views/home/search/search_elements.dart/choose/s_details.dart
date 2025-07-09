import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class ChooseDetails extends StatelessWidget {
  ChooseDetails(
      {super.key,
      required this.isMeuble,
      required this.nombrePieces,
      required this.notChambre,
      required this.noDetails});
  bool notChambre;
  bool noDetails;
  var isMeuble;
  var nombrePieces;

  @override
  Widget build(BuildContext context) {
    var tempIsMeuble = Rx<bool?>(isMeuble.value);
    var tempNombrePieces = RxInt(nombrePieces.value ?? 1);
  var groupeValue = (tempIsMeuble.value == null?"": tempIsMeuble == true? "Meublé": "Non meublé").obs;

    return EScaffold(
        appBar: AppBar(
          title: const TitleText(
            "Plus de details",
            
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: noDetails
              ? const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [EText("Aucun detail à ajouter.")],
                  ),
                )
              : EColumn(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const EText(
                          "Etat*",
                          weight: FontWeight.bold,
                        ),
                        _MeubleOrNot(
                            isMeuble: tempIsMeuble,
                            groupeValue: groupeValue,
                            label: "Meublé"),
                        _MeubleOrNot(
                            isMeuble: tempIsMeuble,
                            groupeValue: groupeValue,
                            label: "Non meublé"),
                        24.h,
                      ],
                    ),
                    notChambre
                        ? 0.h
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const EText(
                                "Nombre de pièces*",
                                weight: FontWeight.bold,
                              ),
                              12.h,
                              // Container(
                              //   height: 50,
                              //   width: 190,
                              //   padding: const EdgeInsets.all(3),
                              //   decoration: BoxDecoration(
                              //       border: Border.all(color: Colors.black26),
                              //       borderRadius: BorderRadius.circular(12)),
                              //   child: Obx(
                              //     () => Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Opacity(
                              //           opacity: tempNombrePieces.value == 1
                              //               ? .0
                              //               : 1,
                              //           child: PlusMinus(
                              //               iconData: CupertinoIcons.minus,
                              //               onTap: () {
                              //                 tempNombrePieces.value == 1
                              //                     ? null
                              //                     : tempNombrePieces--;
                              //               }),
                              //         ),
                              //         EText(
                              //           tempNombrePieces.value.toString(),
                              //           weight: FontWeight.bold,
                              //           size: 26,
                              //         ),
                              //         PlusMinus(
                              //             iconData: CupertinoIcons.add,
                              //             onTap: () {
                              //               tempNombrePieces++;
                              //             }),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // 6.h,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(CupertinoIcons.info_circle_fill,
                                      color: AppColors.blue),
                                  6.w,
                                  SizedBox(
                                      width: Get.width - 60,
                                      child: ETextRich(
                                        textSpans: [
                                          ETextSpan(
                                            text:
                                                "Le salon est considéré comme une pièce, les autres chambres sont considérées comme des pièces, ",
                                            color: AppColors.blue,
                                          ),
                                          ETextSpan(
                                            text:
                                                "Ex: Si vous cherchez une chambre salon, entrez 2 pièces.",
                                            weight: FontWeight.w600,
                                            color: AppColors.blue,
                                          )
                                        ],
                                      ))
                                ],
                              ),
                              24.h,
                            ],
                          ),
                  ],
                ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(9.0),
          child: SimpleButton(
            width: 170,
            onTap: () {
              isMeuble.value = tempIsMeuble.value;
              notChambre ? null : nombrePieces.value = tempNombrePieces.value;
              Get.back();
            },
            child: const EText(
              "Continuer",
              color: Colors.white,
              weight: FontWeight.bold,
            ),
          ),
        ));
  }
}



class _MeubleOrNot extends StatelessWidget {
  _MeubleOrNot(
      {required this.groupeValue,
      required this.label,
      required this.isMeuble});
  var isMeuble;
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
          width: Get.width,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
          color:  groupeValue.value == label ? AppColors.color500.withOpacity(.1): Colors.white,
              border: Border.all(
                  width: groupeValue.value == label ? .8 : .8,
                  color: groupeValue.value == label
                      ? AppColors.color500
                      : Colors.black26),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: groupeValue.value == label
                    ? Icon(Icons.check_circle, color: AppColors.color500)
                    : const Icon(Icons.radio_button_unchecked, color: Colors.black26),
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
