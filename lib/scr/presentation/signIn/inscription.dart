// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/signIn/connexion.dart';

class Inscription extends StatelessWidget {
  Inscription({
    super.key,
  });

  bool? deconnected;
  Utilisateur utilisateur = Utilisateur.empty;

  var currentRegion = Rx<String?>(null);

  var passvisible_1 = true.obs;

  var passvisible_2 = true.obs;

  String repeatPass = "";

  var isLoading = false.obs;

  var country = "TG";

  @override
  Widget build(BuildContext context) {
    final returnUrl = Get.parameters["return-url"] ?? "";

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return EScaffold(
        appBar: appBar(width),
        body: Row(
          mainAxisAlignment:
              width < 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            width < 600
                ? 0.h
                : SizedBox(
                    width: width / 3,
                    height: height,
                    child: const Image(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/moger-pro.appspot.com/o/images%2FScreenshot%20from%202024-06-16%2023-01-03.png?alt=media&token=2c2e6b49-3251-4eb0-96d2-a422c0dd0b6a"),
                        fit: BoxFit.cover),
                  ),
            SizedBox(
              width: width * 2 / 3 < 400 ? width * 2 / 3 : 400,
              child: Obx(
                () => IgnorePointer(
                  ignoring: isLoading.value,
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: EColumn(children: [
                        const EText('Créer un compte',
                            size: 36, weight: FontWeight.bold),
                        18.h,
                        const EText("Nom"),
                        ETextField(
                          initialValue: utilisateur.nom,
                          phoneScallerFactor: phoneScallerFactor,
                          onChanged: (value) {
                            utilisateur.nom = value;
                          },
                        ),
                        10.h,
                        const EText("Prénom"),
                        ETextField(
                          initialValue: utilisateur.prenom,
                          phoneScallerFactor: phoneScallerFactor,
                          onChanged: (value) {
                            utilisateur.prenom = value;
                          },
                        ),
                        10.h,
                        const EText("Téléphone"),
                        ETextField(
                          initialValue: utilisateur.telephone.numero,
                          prefix: ChooseCountryCode(
                            onChanged: (value) {
                              utilisateur.telephone.indicatif = value.dialCode!;
                            },
                          ),
                          phoneScallerFactor: phoneScallerFactor,
                          number: true,
                          onChanged: (value) {
                            utilisateur.telephone.numero = value;
                          },
                        ),
                        10.h,
                        const EText("Mot de passe"),
                        Obx(
                          () => ETextField(
                            phoneScallerFactor: phoneScallerFactor,
                            pass: passvisible_1.value,
                            initialValue: utilisateur.password,
                            onChanged: (value) {
                              utilisateur.password = value;
                            },
                            suffix: InkWell(
                              onTap: () {
                                passvisible_1.value = !passvisible_1.value;
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                    !passvisible_1.value
                                        ? CupertinoIcons.eye_slash_fill
                                        : CupertinoIcons.eye_fill,
                                    color: AppColors.textColor),
                              ),
                            ),
                          ),
                        ),
                        10.h,
                        const EText("Répeter le mot de passe"),
                        Obx(
                          () => ETextField(
                            phoneScallerFactor: phoneScallerFactor,
                            pass: passvisible_2.value,
                            initialValue: repeatPass,
                            onChanged: (value) {
                              repeatPass = value;
                            },
                            suffix: InkWell(
                              onTap: () {
                                passvisible_2.value = !passvisible_2.value;
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                    !passvisible_2.value
                                        ? CupertinoIcons.eye_slash_fill
                                        : CupertinoIcons.eye_fill,
                                    color: AppColors.textColor),
                              ),
                            ),
                          ),
                        ),
                        25.h,
                        SimpleButton(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (IsNullString(utilisateur.nom) ||
                                  IsNullString(utilisateur.prenom) ||
                                  !GFunctions.isPhoneNumber(
                                      country: utilisateur.telephone.indicatif,
                                      numero: utilisateur.telephone.numero) ||
                                  utilisateur.password.length < 6 ||
                                  utilisateur.password != repeatPass) {
                                inscriptionProblemesDialog(width);
                              } else {
                                try {
                                  isLoading.value = true;

                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email:
                                          "${utilisateur.telephone.numero}@gmail.com",
                                      password: utilisateur.password,
                                    );
                                    utilisateur.country = country;
                                    await Utilisateur.setUser(utilisateur);

                                    isLoading.value = false;

                                 
                                    Toasts.success(context,
                                        description:
                                            "Vous vous êtes connecté avec succès");
                                    Utilisateur.refreshToken();
                                    waitAfter(999, () {
                                      if (returnUrl.contains("/")) {
                                        Get.toNamed(returnUrl);
                                      }
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'email-already-in-use') {
                                      Custom.showDialog(
                                        EWarningWidget(width:width,
                                          message:
                                              "Numero déjà utilisé. Veuillez vous connecter !",
                                        ),
                                      );
                                      isLoading.value = false;
                                    }
                                  }
                                } on Exception {
                                  Custom.showDialog(EWarningWidget(width:width,
                                    message:
                                        "Une erreur s'est produite. veuillez verifier votre connexion internet",
                                  ));
                                  isLoading.value = false;
                                }
                              }
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
                                      "M'inscrire",
                                      weight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                            ))
                      ])),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  inscriptionProblemesDialog(width) {
    return Custom.showDialog(EDialog(width: width,
      child: Padding(
        padding: const EdgeInsets.all(21.0),
        child: EColumn(
          children: [
            Center(
              child: EText(
                'Problèmes',
                size: 25,
                color: AppColors.color500,
                weight: FontWeight.bold,
              ),
            ),
            12.h,
            12.h,
            IsNullString(utilisateur.nom)
                ? const WarningElement(
                    label: 'Veuillez saisir votre nom',
                  )
                : 0.h,
            IsNullString(utilisateur.prenom)
                ? const WarningElement(
                    label: 'Veuillez saisir votre prénom',
                  )
                : 0.h,
            !GFunctions.isPhoneNumber(
                    country: utilisateur.telephone.indicatif,
                    numero: utilisateur.telephone.numero)
                ? const WarningElement(
                    label: 'Veuillez saisir un numero valide',
                  )
                : 0.h,
            utilisateur.password.length < 6
                ? const WarningElement(
                    label:
                        'Le mot de passe doit etre superieur ou égale à 6 caractères',
                  )
                : 0.h,
            utilisateur.password != repeatPass
                ? const WarningElement(
                    label: 'Les mots de passe doivent être identiques',
                  )
                : 0.h,
            6.h,
            SimpleButton(
              onTap: () {
                Get.back();
              },
              text: 'OK',
              smallHeight: true,
            )
          ],
        ),
      ),
    ));
  }
}
