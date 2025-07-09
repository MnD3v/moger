import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class AlerteCard extends StatelessWidget {
  const AlerteCard(
      {super.key,
      required this.alerte,
      required this.controller,
      required this.width});
  final width;
  final Recherche alerte;
  final controller;
  @override
  Widget build(BuildContext context) {
    final _width = width > 400 ? 280 : width;
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.only(right: 12, bottom: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black26),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: _width - 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EText(
                      alerte.name,
                      weight: FontWeight.w600,
                    ),
                    EText("${alerte.ville} - ${alerte.region}"),
                    ETextRich(textSpans: [
                      ETextSpan(
                        text: alerte.categorie!,
                      ),
                      ETextSpan(text: " - "),
                      ETextSpan(
                        text:
                            alerte.sell! ? RealState.acheter : RealState.louer,
                      ),
                      ETextSpan(text: " - "),
                      // ETextSpan(
                      //     text: budgetLabel(
                      //             achat: alerte.sell!,
                      //             budgetMax: alerte.budgetMax,
                      //             budgetMin: alerte.budgetMin) ??
                      //         "prix non precisé")
                    ]),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Custom.showDialog(ETwoOptionsDialog(
                    width: _width,
                      confirmationText: "Supprimer",
                      confirmFunction: () {
                        controller.delete(alerte: alerte);
                        Get.back();
                      },
                      body: "Voulez vous vraiment supprimer cette alerte ?",
                      title: "Suppression"));
                },
                child: Container(
                    height: 30,
                    width: 30,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: const Icon(CupertinoIcons.trash)),
              )
            ],
          ),
        ));
  }

  // Future<dynamic> editAndRemoveBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       // showDragHandle: true,
  //       builder: (context) {
  //         return ClipRRect(
  //           borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
  //           child: Container(
  //             color: Colors.white,
  //             child: EColumn(
  //               children: [
  //                 Container(
  //                   height: 50,
  //                   width: Get.width,
  //                   decoration: BoxDecoration(
  //                     color: AppColors.color500,
  //                   ),
  //                   alignment: Alignment.center,
  //                   child: Container(
  //                       height: 6,
  //                       width: 66,
  //                       decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(21))),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(9.0),
  //                   child: EColumn(
  //                     children: [
  //                       InkWell(
  //                         onTap: () {
  //                           Get.back();

  //                            Custom.showDialog(SetAlerte(
  //                             index: controller.alertes.value.indexOf(alerte),
  //                             alerte: alerte,
  //                             controller: controller,
  //                           ));
  //                         },
  //                         child: Container(
  //                           height: 50,
  //                           color: Colors.transparent,
  //                           child: Row(
  //                             children: [
  //                               Icon(Icons.edit,
  //                                   color: AppColors.color500, size: 18),
  //                               9.w,
  //                               const EText('Modifier')
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       12.h,
  //                       InkWell(
  //                         onTap: () {
  //                           Get.back();
  //                           Custom.showDialog(ETwoOptionsDialog(
  //                             title: 'Supprimer',
  //                             body: 'Voulez-vous vraiment supprimer ce bien ?',
  //                             confirmFunction: () async {
  //                               Get.back();

  //                               eLoading(width: width);
  //                               await controller.delete(alerte: alerte);

  //                               Get.back();
  //                             },
  //                           ));
  //                         },
  //                         child: Container(
  //                           height: 50,
  //                           color: Colors.transparent,
  //                           child: Row(
  //                             children: [
  //                               Icon(CupertinoIcons.trash,
  //                                   color: AppColors.color500, size: 18),
  //                               9.w,
  //                               const EText('Supprimer')
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       12.h,
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //       backgroundColor: Colors.transparent);
  // }
}
