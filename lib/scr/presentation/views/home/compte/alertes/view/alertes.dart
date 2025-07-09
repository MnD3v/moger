import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/compte/alertes/controllers_bindings/controllers/alertes_controller.dart';
import 'package:moger_web/scr/presentation/views/home/compte/alertes/view/widgets/alerte_card.dart';

class Alertes extends StatelessWidget {
  const Alertes({super.key});

  @override
  Widget build(BuildContext context) {
    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed(
            "${RoutesNames.connexion}?return-url=${RoutesNames.alertes}");
      });
      return const Center();
    }
    Get.lazyPut(() => AlertesController());
    final controller = Get.find<AlertesController>();
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EScaffold(
        appBar: appBar(constraints.maxWidth),
        body: FutureBuilder(
            future: controller.alertes.value != null
                ? null
                : controller.getAlertes(),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: 333.milliseconds,
                child: DB.waiting(snapshot)
                    ? const ECircularProgressIndicator(
                        label: "Chargement des alertes",
                      )
                    : Obx(
                        () => controller.alertes.value.isNul &&
                                DB.hasError(snapshot)
                            ? EError(
                                error: snapshot.error.toString(),
                                retry: () async {
                                  eLoading(width: width);
                                  try {
                                    await controller.getAlertes();
                                  } catch (e) {
                                    print(e);
                                    Toasts.error(context,
                                        description:
                                            "Une erreur s'est produite");
                                  }
                                  Get.back();
                                },
                              )
                            : controller.alertes.value!.isEmpty
                                ? const AlerteEmpty()
                                : EColumn(
                                    children: [
                                      48.h,
                                      Center(
                                        child: SizedBox(
                                          width: width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const EText("Alertes",
                                                  size: 36,
                                                  weight: FontWeight.w800),
                                              9.h,
                                              Wrap(
                                                children:
                                                    controller.alertes.value!
                                                        .map(
                                                          (e) => AlerteCard(
                                                              width: width,
                                                              controller:
                                                                  controller,
                                                              alerte: e),
                                                        )
                                                        .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
              );
            }),
      );
    });
  }
}

class AlerteEmpty extends StatelessWidget {
  const AlerteEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: EColumn(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(Assets.icons("notifications.png")),
            height: 90,
          ),
          12.h,
          const EText(
            "Vous n'avez pas encore d'alertes",
            weight: FontWeight.bold,
            size: 22,
          ),
          12.h,
          const EText(
            "Lorque vous faites une recherche, cliquez sur la cloche de notifications pour activer l'alerte. ",
            maxLines: 6,
            align: TextAlign.center,
          ),
          12.h,
          const EText(
            "Soyez les premiers à être notifiés !!!",
            weight: FontWeight.w600,
          ),
          24.h,
        ],
      ),
    );
  }
}
