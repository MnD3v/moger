
import 'package:moger_web/scr/configs/app/export.dart';

class ChooseCategorie extends StatelessWidget {
  ChooseCategorie({super.key,required this.typeSelected,required this.buy});
  var typeSelected;
  bool buy;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RechercheController>();

    return EScaffold(
      appBar: AppBar(
        title: const TitleText(
          "Types de biens",
        
        ),
      ),
      body: EColumn(
        children: [
    buy?0.h:          _ChooseType(
          image: "chambre",
          label: Categories.chambres,
          groupeValue: typeSelected,
        ),
            _ChooseType(
          image: "maison",
          label: Categories.maisons,
          groupeValue: typeSelected,
        ),
        _ChooseType(
          image: "terrain",
          label: Categories.terrains,
          groupeValue: typeSelected,
        ),
        _ChooseType(
            image: "boutique",
            label: Categories.boutiques,
            groupeValue: typeSelected),
        _ChooseType(
          image: "bureau",
          label: Categories.bureau,
          groupeValue: typeSelected,
        ),

        
        ],
      ),
     
    );
  }
}


class _ChooseType extends StatelessWidget {
  const _ChooseType(
      {required this.groupeValue,
      required this.image,
      required this.label});
  final image;
  final label;
  final groupeValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        groupeValue.value = label;
        waitAfter(333, () {Get.back(); });
        
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
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
                  color:groupeValue.value == label ? AppColors.color100:Colors.white,
                    border: Border.all(
                        width: groupeValue.value == label ? .8 : .8,
                        color: groupeValue.value == label
                            ? Colors.transparent
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
                    ? Icon(Icons.check_circle, color: AppColors.color500)
                    : const Icon(Icons.radio_button_unchecked, color: Colors.black26),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class TypeElement extends StatelessWidget {
//   const TypeElement({super.key, required this.value, required this.groupValue});
//   final value;
//   final groupValue;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         groupValue.value = value;
//       },
//       child: Obx(
//         () => AnimatedContainer(
//           duration: 666.milliseconds,
//           height: 100,
//           width: Get.width - 20,
//           margin: const EdgeInsets.all(9),
//           padding: const EdgeInsets.all(9),
//         //   decoration: BoxDecoration(
//         //  color:   groupValue.value == value
//         //               ? AppColors.color100: Colors.white,
//         //       border: Border.all(
//         //           color: groupValue.value == value
//         //               ? Colors.transparent
//         //               : Colors.black12,
//         //           width: groupValue.value == value ? 1 : 1),
//         //       borderRadius: BorderRadius.circular(12)),
//           alignment: Alignment.center,
//           child: Row(
//             children: [
//               groupValue.value == value
//                   ? Icon(
//                       Icons.check_circle_rounded,
//                       color: AppColors.color500,
//                     )
//                   : const Icon(
//                       Icons.radio_button_unchecked,
//                       color: Colors.black45,
//                     ),
//               6.w,
//               SizedBox(
//                   width: Get.width - 85.0,
//                   child: EText(
//                     value,
//                     maxLines: 3,
//                     weight: FontWeight.w700,
//                     size: 20,
//                     color:  groupValue.value == value
//                   ? AppColors.color500:null,
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
