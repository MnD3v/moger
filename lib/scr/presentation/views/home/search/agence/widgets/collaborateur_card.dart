
import 'package:moger_web/scr/configs/app/export.dart';

class CollaborateurCard extends StatelessWidget {
  const CollaborateurCard(
      {super.key, required this.element, required this.width, this.inPopupDescriptionWidth});
  final width;
  final Collaborateur element;
  final inPopupDescriptionWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(6)),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
              height: 100,
              width: 100,
              child: EFadeInImage(
                radius: 3,
                image: NetworkImage(element.profile),
              )),
          12.w,
          SizedBox(
            width: inPopupDescriptionWidth ?? width - 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EText(element.nom,
                    maxLines: 1, size: 22, weight: FontWeight.bold),
                    12.h,
                EText(element.role, maxLines: 1, color: AppColors.color500)
              ],
            ),
          )
        ],
      ),
    );
  }
}
