import 'package:firebase_auth/firebase_auth.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class MonCompte extends StatelessWidget {
  const MonCompte({super.key});

  @override
  Widget build(BuildContext context) {
    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed(
            "${RoutesNames.connexion}?return-url=${RoutesNames.monCompte}");
      });
      return const Center();
    }
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 900.0 ? 900.0 : constraints.maxWidth;

      return EScaffold(
          appBar: appBar(constraints.maxWidth),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: EColumn(
                children: [
                  Center(
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          48.h,
                          const EText("Mon compte",
                              size: 36, weight: FontWeight.w800),
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  EText(
                                    "${Utilisateur.currentUser.value!.nom} ${Utilisateur.currentUser.value!.prenom}",
                                    weight: FontWeight.bold,
                                    size: 22,
                                  ),
                                  EText(
                                      "${Utilisateur.currentUser.value!.telephone.indicatif} ${Utilisateur.currentUser.value!.telephone.numero}")
                                ],
                              )),
                          24.h,
                          Wrap(
                            children: [
                              _Element(
                                  image: 'favoris.png',
                                  title: "Favoris",
                                  description: "Biens immobiliers enregistrés",
                                  onTap: () {
                                    Get.toNamed(
                                      RoutesNames.favoris,
                                    );
                                  }),
                              _Element(
                                  image: 'alerte.png',
                                  title: "Alertes",
                                  description: "Alertes enregistrés",
                                  onTap: () {
                                    Get.toNamed(
                                      RoutesNames.alertes,
                                    );
                                  }),
                              _Element(
                                  image: 'key.png',
                                  title: "Espace propriétaire",
                                  description: "Biens déposés, contacts",
                                  onTap: () {
                                    Get.toNamed(
                                      RoutesNames.proprietaire,
                                    );
                                  }),
                              _Element(
                                  image: 'account.png',
                                  title: "Gérer mon compte",
                                  description: "Nom, prénoms, mot de passe",
                                  onTap: () {
                                    Get.toNamed(RoutesNames.editProfil);
                                  }),
                            ],
                          ),
                          48.h,
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.offAndToNamed(RoutesNames.home);
                                FirebaseAuth.instance.signOut();
                                waitAfter(666, () {
                                  Utilisateur.currentUser.value = null;
                                });
                              },
                              child: const EText("Se deconnecter",
                                  underline: true,
                                  size: 24,
                                  weight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

class _Element extends StatelessWidget {
  const _Element(
      {required this.image,
      required this.title,
      required this.description,
      required this.onTap});
  final image;
  final title;
  final description;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 90,
        width: 280,
        padding: const EdgeInsets.all(9.0),
        margin: const EdgeInsets.only(right: 18.0, bottom: 18),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black26,
            ),
            borderRadius: BorderRadius.circular(6)),
        alignment: Alignment.center,
        child: Row(
          children: [
            Image(
              image: AssetImage(Assets.icons(image)),
              width: 45,
            ),
            6.w,
            SizedBox(
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(title),
                  EText(description),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
