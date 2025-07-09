import 'dart:ui';

import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/search/widgets/real_state_card.dart';

class RealStatePageBody extends StatelessWidget {
  bool firstFetch = false;

  RealStatePageBody(
      {super.key,
      required this.controller,
      required this.realStates,
      required this.width});
  final width;
  final RechercheController controller;
  final List<RealState> realStates;
  var isHovered = "".obs;

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        NotificationListener<ScrollNotification>(
          // key: Key(controller.animatedKey),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              itemCount: listWidgets.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                return Center(
                    child: SizedBox(
                        width: width > 800 ? 800 : width,
                        child: listWidgets[index]));
              },
            ),
          ),
          onNotification: (notification) {
            if (notification.metrics.pixels >
                    notification.metrics.maxScrollExtent &&
                !firstFetch) {
              controller.getRealStates();
              firstFetch = true;
            }
            if (notification.metrics.pixels <=
                notification.metrics.maxScrollExtent) {
              firstFetch = false;
            }
            return false;
          },
        ),
      ],
    );
  }

  List<Widget> get listWidgets => [
        ...realStates
            .map((e) => MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) {
                    isHovered.value = e.id;
                  },
                  // Detects when the pointer leaves the area of the MouseRegion
                  onExit: (_) {
                    isHovered.value = "";
                  },
                  child: InkWell(
                    onTap: () async {
                  final id =     EncryptionHelper().encryptText(e.id);
                      Get.toNamed("${RoutesNames.biens}?id=$id");

                      //and save visites
                      saveVus(realState: e, controller: controller);
                    },
                    child: Obx(
                      () => RealStateCard(
                        isHovered: isHovered.value,
                        width: width,
                        realState: e,
                      ),
                    ),
                  ),
                ))
            ,
        6.h,
        realStates.isEmpty
            ? 45.h
            : Obx(() => controller.fetchEnd.value
                ? 45.h
                : const Center(child: EText('Chargement...', size: 20))),
        3.h,
        70.h,
      ];
}

Future<void> saveVus(
    {required RealState realState, required controller}) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  var vus = sharedPreferences.getStringList("vus") ?? [];
  if (!vus.contains(realState.id)) {
    controller.vus.update((val) {
      val?.add(realState.id);
    });
    vus.add(realState.id);
  }
  vus.length > 150 ? vus.removeAt(0) : null;
  sharedPreferences.setStringList("vus", vus);
  RealState.setRealState(
      realState: realState.copyWith(visite: (realState.visite ?? 0) + 1));
}

class MyBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}
