
import 'package:moger_web/scr/configs/app/export.dart';

class RealStatesEmpty extends StatelessWidget {
  const RealStatesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RechercheController>();

    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
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
           const EText(
              "Modifiez vos critère pour élargir votre recherche",
              size: 20,
              maxLines: 4,
            ),
            12.h,
            SimpleOutlineButton(
              color: Colors.black,
              width: 210,
              height: 45,
              onTap: () {
                // Get.to(
                //     Search(
                //       currentSearchIndex: controller.currentSearchIndex.value,
                //     ),
                //     fullscreenDialog: true);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                      image: AssetImage(Assets.icons("edit.png")),
                      height: 25,
                      color: Colors.black),
                  6.w,
                  const EText("Modifier mes critères",
                      color: Colors.black, weight: FontWeight.w700)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void addAlerte(
    {required BuildContext context,
    required Recherche recherche,
    required RechercheController controller, width}) {
  String? name;
  var isLoading = false.obs;
  return Custom.showDialog(EDialog(width: width,
    child: Obx(
      () => IgnorePointer(
        ignoring: isLoading.value,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child:
              EColumn(crossAxisAlignment: CrossAxisAlignment.center, children: [
            12.h,
            const TitleText(
              "Quel nom voulez-vous donner à votre projet ?",
              align: TextAlign.center,
            ),
            12.h,
            Image(
              image: AssetImage(Assets.icons("notifications.png")),
              height: 60,
            ),
            UnderLineTextField(
              label: "Nom de l'alerte",
              onChanged: (value) {
                name = value;
              },
              phoneScallerFactor: phoneScallerFactor,
            ),
            24.h,
            SimpleButton(
              width: 130,
              onTap: () async {
                if (name.isNul) {
                  Toasts.error(context,
                      description: "Veuillez saisir le nom de l'alerte");
                  return;
                }
                isLoading.value = true;

                recherche.name = name;
                recherche.uid = Utilisateur.currentUser.value!.telephone.numero;

                await Recherche.setAlerte(recherche);
                isLoading.value = false;
                Get.back();

                Toasts.success(context,
                    description: "Votre alerte est activée avec succès");
                var sharedPreferences = await SharedPreferences.getInstance();
                var alertesIds =
                    sharedPreferences.getStringList("alertesIds") ?? [];
                alertesIds.add(recherche.id);
                sharedPreferences.setStringList("alertesIds", alertesIds);
                controller.alertesIds.update((val) {
                  val?.add(recherche.id);
                });
              },
              child: Obx(
                () => isLoading.value
                    ? const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.3,
                        ))
                    : const EText(
                        'Activer',
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
              ),
            ),
            12.h,
          ]),
        ),
      ),
    ),
  ));
}
