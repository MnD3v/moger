import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/search/real_state_elements.dart/real_states_body_page.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var controller = Get.find<RechercheController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // controller.realStates.value != null
      //     ? null
      //     : controller.getRealStates(restart: true);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var recherche0 = Get.parameters['q'];

    recherche0 = EncryptionHelper().decryptText(recherche0!);

    final recherche = Recherche.fromJson(recherche0!);
    controller.recherche = recherche;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        print(width);
        return FutureBuilder(
            future: controller.realStates.value != null
                ? null
                : controller.getRealStates(
                    restart: true,
                  ),
            builder: (context, snapshot) {
              return EScaffold(
                appBar: appBar(width),
                body: AnimatedSwitcher(
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  duration: 333.milliseconds,
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? const ECircularProgressIndicator(
                          label: "Chargement",
                        )
                      : Obx(
                          () => controller.realStates.value!.isEmpty
                              ? SingleChildScrollView(
                                  key: UniqueKey(),
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  child: Vide(
                                    key: UniqueKey(),
                                    message: "Vide",
                                  ),
                                )
                              : Obx(
                                  () => RealStatePageBody(
                                    key: UniqueKey(),
                                    width: width,
                                    controller: controller,
                                    realStates: controller.realStates.value!,
                                  ),
                                ),
                        ),
                ),
              );
            });
      },
    );
  }
}
