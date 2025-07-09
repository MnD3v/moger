import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class EditProfil extends StatelessWidget {
  EditProfil({super.key});

  var isLoading = false.obs;

  var oldPassVisible = true.obs;
  var passvisible_1 = true.obs;

  var passvisible_2 = true.obs;
  String? passChange;
  @override
  Widget build(BuildContext context) {
    if (Utilisateur.currentUser.value.isNul) {
      waitAfter(666, () {
        Get.toNamed(
            "${RoutesNames.connexion}?return-url=${RoutesNames.editProfil}");
      });
      return const Center();
    }
    var user = Rx<Utilisateur>(Utilisateur.currentUser.value!);

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return EScaffold(
        appBar: appBar(width),
        body: Obx(
          () => IgnorePointer(
            ignoring: isLoading.value,
            child: EColumn(
              children: [
                Center(
                  child: SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        24.h,
                        const EText("Gérer mon compte", size: 36, weight: FontWeight.w800),
                        12.h,
                        Obx(
                          () => Element(
                              onTap: () {
                                String name = user.value.nom;
                    
                                Custom.showDialog(EDialog(width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: EColumn(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const EText("Nom",
                                            size: 28, weight: FontWeight.bold),
                                        12.h,
                                        UnderLineTextField(
                                            initialValue: user.value.nom,
                                            label: "Entrez un nom",
                                            onChanged: (value) {
                                              name = value;
                                            },
                                            phoneScallerFactor: phoneScallerFactor),
                                        12.h,
                                        SimpleButton(
                                            onTap: () {
                                              if (name.length < 2) {
                                                Toasts.error(context,
                                                    description:
                                                        "Veuillez saisir un nom valide");
                                                return;
                                              }
                                              user.update((val) {
                                                val?.nom = name;
                                              });
                    
                                              Get.back();
                                            },
                                            text: "OK")
                                      ],
                                    ),
                                  ),
                                ));
                              },
                              title: "Nom",
                              description: user.value.nom),
                        ),
                        Element(
                            onTap: () {
                              String prenom = user.value.prenom;
                    
                              Custom.showDialog(EDialog(width: width,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: EColumn(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const EText("Prenom",
                                          size: 28, weight: FontWeight.bold),
                                      12.h,
                                      UnderLineTextField(
                                          initialValue: user.value.prenom,
                                          label: "Entrez un prenom",
                                          onChanged: (value) {
                                            prenom = value;
                                          },
                                          phoneScallerFactor: phoneScallerFactor),
                                      12.h,
                                      SimpleButton(
                                          onTap: () {
                                            if (prenom.length < 2) {
                                              Toasts.error(context,
                                                  description:
                                                      "Veuillez saisir un prénom valide");
                                              return;
                                            }
                                            user.update((val) {
                                              val?.prenom = prenom;
                                            });
                                            Get.back();
                                          },
                                          text: "OK")
                                    ],
                                  ),
                                ),
                              ));
                            },
                            title: "Prenom",
                            description: user.value.prenom),
                        // Element(
                        //     onTap: () {
                        //       String telephone = user.value.telephone;
                        //       Custom.showDialog(EDialog(width: width,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(12.0),
                        //           child: EColumn(
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               const EText("Téléphone",
                        //                   size: 28, weight: FontWeight.bold),
                        //               12.h,
                        //               UnderLineTextField(
                        //                   initialValue: GFunctions.separate(
                        //                       2, user.value.telephone),
                        //                   prefix: EText(
                        //                     "+228 ",
                        //                     weight: FontWeight.w500,
                        //                   ),
                        //                   label: "Entrez un numero de téléphone",
                        //
                        //                   onChanged: (value) {
                        //                     telephone = value;
                        //                   },
                        //                   phoneScallerFactor: phoneScallerFactor),
                        //               12.h,
                        //               SimpleButton(
                        //                   onTap: () {
                        //                     if (!GFunctions.isPhoneNumber(telephone)) {
                        //                       Toasts.error(context,
                        //                           description:
                        //                               "Veuillez saisir un numéro valide");
                        //                       return;
                        //                     }
                        //                     user.update((val) {
                        //                       val?.telephone = telephone;
                        //                     });
                        //                     Get.back();
                        //                   },
                        //                   text: "OK")
                        //             ],
                        //           ),
                        //         ),
                        //       ));
                        //     },
                        //     title: "Téléphone",
                        //     description:
                        //         "+228 ${GFunctions.separate(2, user.value.telephone)}"),
                        Element(
                            onTap: () {
                              String oldPass = "";
                              String pass = "";
                              String repeatPass = "";
                              Custom.showDialog(EDialog(width: width,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: EColumn(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const EText("Mot de passe",
                                          size: 28, weight: FontWeight.bold),
                                      12.h,
                                      Obx(
                                        () => UnderLineTextField(
                                          label: "Ancien mot de passe",
                                          phoneScallerFactor: phoneScallerFactor,
                                          pass: oldPassVisible.value,
                                          onChanged: (value) {
                                            oldPass = value;
                                          },
                                          suffix: InkWell(
                                            onTap: () {
                                              oldPassVisible.value =
                                                  !oldPassVisible.value;
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Icon(
                                                  oldPassVisible.value
                                                      ? CupertinoIcons.eye_slash_fill
                                                      : CupertinoIcons.eye_fill,
                                                  color: AppColors.textColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      12.h,
                                      Obx(
                                        () => UnderLineTextField(
                                          label: "Nouveau mot de passe",
                                          phoneScallerFactor: phoneScallerFactor,
                                          pass: passvisible_1.value,
                                          onChanged: (value) {
                                            pass = value;
                                          },
                                          suffix: InkWell(
                                            onTap: () {
                                              passvisible_1.value =
                                                  !passvisible_1.value;
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Icon(
                                                  passvisible_1.value
                                                      ? CupertinoIcons.eye_slash_fill
                                                      : CupertinoIcons.eye_fill,
                                                  color: AppColors.textColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      10.h,
                                      Obx(
                                        () => UnderLineTextField(
                                          label: "Répeter le nouveau mot de passe",
                                          phoneScallerFactor: phoneScallerFactor,
                                          pass: passvisible_2.value,
                                          onChanged: (value) {
                                            repeatPass = value;
                                          },
                                          suffix: InkWell(
                                            onTap: () {
                                              passvisible_2.value =
                                                  !passvisible_2.value;
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Icon(
                                                  passvisible_2.value
                                                      ? CupertinoIcons.eye_slash_fill
                                                      : CupertinoIcons.eye_fill,
                                                  color: AppColors.textColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      12.h,
                                      SimpleButton(
                                          onTap: () {
                                            if (oldPass != user.value.password) {
                                              Toasts.error(context,
                                                  description:
                                                      "Ancien mot de passe incorrect.");
                                              return;
                                            }
                                            if (pass.length < 6) {
                                              Toasts.error(context,
                                                  description:
                                                      "Le mot de passe doit contenir au moins 6 caractères");
                                              return;
                                            }
                                            if (pass != repeatPass) {
                                              Toasts.error(context,
                                                  description:
                                                      "Mot de passes différents. Les deux entrés doivente être identiques");
                                              return;
                                            }
                                            if (pass == user.value.password) {
                                              Toasts.error(context,
                                                  description:
                                                      "Veuillez entrer un mot de passe différent de l'ancien");
                                              return;
                                            }
                    
                                            passChange = pass;
                    
                                            Get.back();
                                          },
                                          text: "OK")
                                    ],
                                  ),
                                ),
                              ));
                            },
                            title: "Mot de passe",
                            description: "•" * user.value.password.length),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: SimpleButton(
                height: 50,
                width: width,
                onTap: () async {
                  isLoading.value = true;
                  if (passChange != null) {
                    var currentUser = FirebaseAuth.instance.currentUser;
              
                    AuthCredential credential = EmailAuthProvider.credential(
                        email: "${user.value.telephone.numero}@gmail.com",
                        password: user.value.password);
              
                    currentUser?.reauthenticateWithCredential(credential);
              
                    try {
                      await currentUser?.updatePassword(passChange!);
                      user.update((val) {
                        val?.password = passChange!;
                      });
                    } on Exception {
                      Custom.showDialog(EWarningWidget(width:width,
                          message:
                              "Veuillez vous reconnecter pour effectuer le changement de mot de passe"));
                    }
                  }
                  Utilisateur.currentUser.update((val) {
                    val = user.value;
                  });
                  await Utilisateur.setUser(user.value);
              
                  isLoading.value = false;
                  Get.back();
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
                      : const EText("Enregistrer",
                          weight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )),
      );
    });
  }
}

class Element extends StatelessWidget {
  const Element(
      {super.key,
      required this.onTap,
      required this.title,
      required this.description});
  final onTap;
  final title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        width: Get.width,
        padding: const EdgeInsets.all(9),
        margin: const EdgeInsets.all(9),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                EText(
                  title,
                  weight: FontWeight.w700,
                  size: 22,
                ),
                EText(description)
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }
}
