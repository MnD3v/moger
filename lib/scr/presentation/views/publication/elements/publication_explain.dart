import 'package:moger_web/scr/configs/app/export.dart';

class PublicationExplain extends StatelessWidget {
  const PublicationExplain({super.key});

  @override
  Widget build(BuildContext context) {
    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed("${RoutesNames.connexion}?return-url=${RoutesNames.publicationExplain}");
      });
      return const Center();
    }
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;
      return EScaffold(
        appBar: appBar(width),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: EColumn(
            children: [
              SizedBox(
                width: width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      12.h,
                      const BigTitleText(
                        "Vendez ou louez votre bien immobilier de particulier à particulier",
                      ),
                      12.h,
                      InformationElement(
                          width: width,
                          icon: "home.png",
                          title: "Présentez votre bien et ses caractéristiques",
                          body:
                              "Comme sa localisation, sa surface et son nombre de pièces"),
                      InformationElement(
                          width: width,
                          icon: "star.png",
                          title: "Mettez en avant ce qui le rend unique",
                          body:
                              "Une description précise et quelques photos aident les clients à se projeter"),
                      InformationElement(
                          width: width,
                          icon: "budget_style.png",
                          title: "Fixez le prix de votre bien",
                          body:
                              "Une fois le prix renseigné, votre annonce est prête à être publiée"),
                    ]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          margin: const EdgeInsets.all(9),
          alignment: Alignment.center,
          child: SimpleButton(
              width: width,
              onTap: () {
                Get.dialog(
                  const VendreOuLouer(),
                );
              },
              text: "C'est parti !"),
        ),
      );
    });
  }
}

class VendreOuLouer extends StatelessWidget {
  const VendreOuLouer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;
      return EScaffold(
        appBar: appBar(width),
        body: EColumn(children: [
          12.h,
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios, size: 15),
                  TitleText("Retour"),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EText(
                    "Vous avez un bien...",
                    size: 30,
                    weight: FontWeight.bold,
                  ),
                  Wrap(
                    children: [
                      _ChooseSellOrRent(
                          width: 240,
                          image: "vendre",
                          onTap: () {
                            Get.back();
                            Get.back();

                            Get.toNamed("${RoutesNames.publication}?sell=true");
                          },
                          label: "À Vendre"),
                      12.w,
                      _ChooseSellOrRent(
                          width: 240,
                          image: "location",
                          onTap: () {
                            Get.back();
                            Get.back();

                            Get.toNamed(
                                "${RoutesNames.publication}?sell=false");
                          },
                          label: "À Louer"),
                    ],
                  ),
                  12.h,
                ],
              ),
            ),
          ),
          12.h,
          bottomAppBar(width: constraints.maxWidth)
        ]),
      );
    });
  }
}

class _ChooseSellOrRent extends StatelessWidget {
  const _ChooseSellOrRent(
      {required this.image,
      required this.onTap,
      required this.label,
      required this.width});
  final width;
  final image;
  final label;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12)),
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
    );
  }
}

class InformationElement extends StatelessWidget {
  const InformationElement(
      {super.key,
      required this.icon,
      required this.title,
      required this.width,
      required this.body});
  final icon;
  final title;
  final body;
  final width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(.2),
                borderRadius: BorderRadius.circular(12)),
            child: Image(image: AssetImage(Assets.icons(icon))),
          ),
          9.w,
          SizedBox(
            width: width - 100,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleText(
                title,
              ),
              EText(
                body,
                maxLines: 9,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
