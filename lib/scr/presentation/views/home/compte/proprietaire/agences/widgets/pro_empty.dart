
import 'package:moger_web/scr/configs/app/export.dart';

class ProsEmpty extends StatelessWidget {
  const ProsEmpty({super.key, required this.changeRayon, required this.manuel,required this.chooseLocalisation});
  final bool manuel;
  final changeRayon;
  final chooseLocalisation;
  @override
  Widget build(BuildContext context) {
    return EColumn(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image(
        image: AssetImage(Assets.icons("empty_realStates.png")),
        height: 120,
      ),
      12.h,
      const EText(
        "Aucun resultat pour le moment",
        weight: FontWeight.bold,
      ),
      12.h,
      EText(
        manuel
            ? "Modifier la localité pour obtenir plus de resultats"
            : "Modifiez le rayon pour élargir votre recherche",
        size: 20,
        maxLines: 4,
      ),
      12.h,
      SimpleOutlineButton(
        color: Colors.black,
        width: 210,
        height: 45,
        onTap: () {
       manuel? chooseLocalisation():   changeRayon();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
                image: AssetImage(Assets.icons("edit.png")),
                height: 25,
                color: Colors.black),
            6.w,
            EText(manuel ? "Modifier" : "Modifier le rayon",
                color: Colors.black, weight: FontWeight.w700)
          ],
        ),
      )
    ]);
  }
}
