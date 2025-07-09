
import 'package:moger_web/scr/configs/app/export.dart';

class SearchOption extends StatelessWidget {
  const SearchOption(
      {super.key,
      this.result,
      this.width,
      required this.onTap,
      required this.icon,
      required this.label,
      this.optionel});
  final double? width;
  final onTap;
  final icon;
  final label;
  final result;
  final optionel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: width ?? 23,
                  child: Image(
                    image: AssetImage(Assets.icons(icon)),
                    width: 25,
                  ),
                ),
                12.w,
                Opacity(
                  opacity: optionel == true && result == null ? .4 : 1,
                  child: SizedBox(
                    width: Get.width - 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          label,
                        ),
                        result == null
                            ? 0.h
                            : EText(
                                result.toString(),
                                maxLines: 2,
                                color: AppColors.color500,
                                weight: FontWeight.w600,
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
