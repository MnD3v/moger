import 'package:diacritic/diacritic.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class CategorieChoosed extends StatelessWidget {
  CategorieChoosed({
    super.key,
    required this.label,
    required this.categorieSelected,
  });
  final label;
  var categorieSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        categorieSelected.value = label;
      },
      child: Obx(
        () => AnimatedContainer(
          duration: 333.milliseconds,
          decoration: BoxDecoration(
              color: categorieSelected.value == label
                  ? AppColors.blue
                  : Colors.transparent,
              border: Border.all(color: AppColors.blue),
              borderRadius: BorderRadius.circular(3)),
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: EText(label,
              weight: FontWeight.w500,
              color: categorieSelected.value == label
                  ? Colors.white
                  : AppColors.blue),
        ),
      ),
    );
  }
}

class SellOrLocate extends StatelessWidget {
  const SellOrLocate({super.key, required this.label, required this.selected});
  final label;
  final selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.transparent),
      height: 50,
      width: searchContainerWidth / 2 - 1,
      child: TitleText(label, color: Colors.white),
    );
  }
}

search(String value, region, ville) {
  var qs = Constants.localites[region]![ville]!;
  return qs.where((element) {
    String normalizedItem = removeDiacritics(element.toLowerCase());
    String normalizedQuery = removeDiacritics(value.toLowerCase());
    return normalizedItem.toLowerCase().contains(normalizedQuery.toLowerCase());
  }).toList();
}

List<String> sortStrings(List<String> list) {
  list.sort();
  return list;
}

class QuartierChoosed extends StatelessWidget {
  const QuartierChoosed({super.key, required this.text, required this.onTap});
  final onTap;
  final text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        decoration: BoxDecoration(
            color: AppColors.blue.withOpacity(.2),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [EText(text), 3.w, const Icon(Icons.close, size: 12)],
        ),
      ),
    );
  }
}
