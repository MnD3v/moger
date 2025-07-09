import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/signIn/verification.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart'
    show FirebaseAuthPlatform;

// ignore: must_be_immutable
class Connexion extends StatelessWidget {
  Connexion({
    super.key,
  });
  String telephone = '';

  String pass = '';

  var passvisible = false.obs;

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
                            "https://firebasestorage.googleapis.com/v0/b/moger-pro.appspot.com/o/Screenshot%20from%202024-06-16%2023-01-03.png?alt=media&token=3ba12064-7ade-4976-8d82-12fc048dbec1"),
                        fit: BoxFit.cover),
                  ),
            SizedBox(
              width: width * 2 / 3 < 400 ? width * 2 / 3 : 400,
              child: Obx(
                () => IgnorePointer(
                  ignoring: isLoading.value,
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: EColumn(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const EText('Se connecter',
                                size: 36, weight: FontWeight.bold),
                            12.h,
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const EText("Vous n'avez pas de compte?"),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.toNamed("${RoutesNames.inscription}?return-url=$returnUrl");
                                  },
                                  child: const EText(
                                    "Créer un compte",
                                    size: 22,
                                    underline: true,
                                    weight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            18.h,
                            const EText("Téléphone"),
                            ETextField(
                              initialValue: telephone,
                              phoneScallerFactor: phoneScallerFactor,
                              prefix: ChooseCountryCode(
                                onChanged: (value) {
                                  country = value.code!;
                                },
                              ),
                              onChanged: (value) {
                                telephone = value;
                              },
                              number: true,
                            ),
                            12.h,
                            const EText("Mot de passe"),
                            Obx(
                              () => ETextField(
                                phoneScallerFactor: phoneScallerFactor,
                                initialValue: pass,
                                onChanged: (value) {
                                  pass = value;
                                },
                                pass: passvisible.value ? false : true,
                                // label: "Mot de passe",
                                suffix: InkWell(
                                  onTap: () {
                                    passvisible.value = !passvisible.value;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9.0),
                                    child: Icon(
                                        passvisible.value
                                            ? CupertinoIcons.eye_slash_fill
                                            : CupertinoIcons.eye_fill,
                                        color: AppColors.textColor),
                                  ),
                                ),
                              ),
                            ),
                            24.h,
                            SimpleButton(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (!GFunctions.isPhoneNumber(
                                      country: country, numero: telephone)) {
                                    Toasts.error(context,
                                        description: "Entrez un numero valide");
                                    return;
                                  }
                                  if (pass.length < 6) {
                                    Toasts.error(context,
                                        description:
                                            "Le mot de passe doit contenir aumoins 6 caracteres");
                                    return;
                                  }

                                  isLoading.value = true;
                                  try {
                                    var q = await DB
                                        .firestore(Collections.utilistateurs)
                                        .doc(telephone)
                                        .get();
                                    if (q.exists) {
                                      var utilisateur =
                                          Utilisateur.fromMap(q.data()!);
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: "$telephone@gmail.com",
                                                password: pass);
                                        Utilisateur.currentUser.value =
                                            utilisateur;

                                        isLoading.value = false;

                                        Utilisateur.refreshToken();
                                        waitAfter(999, () {
                                          if (returnUrl.contains("/")) {
                                            Get.offAllNamed("/");
                                            Get.toNamed(
                                              returnUrl,
                                            );
                                            Toasts.success(context,
                                                description:
                                                    "Vous vous êtes connecté avec succès");
                                          }
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code ==
                                            "network-request-failed") {
                                          isLoading.value = false;

                                          Custom.showDialog(EWarningWidget(
                                            width: width,
                                            message:
                                                'Echec de connexion.\nVeuillez verifier votre connexion internet',
                                          ));
                                        } else if (e.code ==
                                            'invalid-credential') {
                                          isLoading.value = false;

                                          Custom.showDialog(EWarningWidget(
                                            width: width,
                                            message: 'Mot de passe incorrect',
                                          ));
                                        }
                                      }
                                    } else {
                                      isLoading.value = false;
                                      Custom.showDialog(
                                        EWarningWidget(
                                          width: width,
                                          message:
                                              'Pas de compte associé à ce numero. Veuillez creer un compte',
                                        ),
                                      );
                                    }
                                  } on Exception {
                                    isLoading.value = false;
                                    Custom.showDialog(EWarningWidget(
                                      width: width,
                                      message:
                                          "Une erreur s'est produite. veuillez verifier votre connexion internet",
                                    ));
                                  }
                                },
                                // width: 160,
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
                                          'Me connecter',
                                          weight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                )),
                            24.h,
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  forgotPassword(context, width);
                                },
                                child: EText('Mot de passe oublié ?',
                                    color: AppColors.color500,
                                    underline: true,
                                    weight: FontWeight.bold,
                                    size: 22),
                              ),
                            ),
                          ])),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void forgotPassword(context, width) async {
    if (GFunctions.isPhoneNumber(country: country, numero: telephone)) {
      try {
        var q =
            await DB.firestore(Collections.utilistateurs).doc(telephone).get();
        if (q.exists) {
          isLoading.value = true;

          var utilisateur = Utilisateur.fromMap(q.data()!);

          var auth = FirebaseAuth.instance;
          ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
              '${utilisateur.telephone.indicatif}${utilisateur.telephone.numero}',
              RecaptchaVerifier(
                auth: FirebaseAuthPlatform.instance,
                container: 'recaptcha-container',
                size: RecaptchaVerifierSize.compact,
                theme: RecaptchaVerifierTheme.dark,
              ));
          Custom.showDialog(Verification(
            utilisateur: utilisateur,
            confirmationResult: confirmationResult,
          ));
          print(confirmationResult);

          /*       await auth.verifyPhoneNumber(
            phoneNumber: '+228${utilisateur.telephone}',
            verificationCompleted: (PhoneAuthCredential credential) async {
            },
            verificationFailed: (FirebaseAuthException e) {
              isLoading.value = false;

              Custom.showDialog(EWarningWidget(
                width: width,
                message:
                    'Erreur lors de la verification du numero, veuillez réessayer plus tard',
              ));
            },
            codeSent: (String verificationId, int? resendToken) async {
              isLoading.value = false;

              // Get.to(Verification(
              //     verificationId: verificationId, utilisateur: utilisateur));
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
     */
        } else {
          isLoading.value = false;

          Custom.showDialog(EWarningWidget(
            width: width,
            message:
                'Pas de compte associé à ce numero. veuillez creer un compte',
          ));
        }
      } on Exception catch (e) {
        print(e);
        isLoading.value = false;

        Custom.showDialog(EWarningWidget(
          width: width,
          message:
              "Une erreur s'est produite. veuillez verifier votre connexion internet",
        ));
      }
    } else {
      Toasts.error(
        context,
        description: "Entrez un numero valide",
      );
    }
  }
}

class ChooseCountryCode extends StatelessWidget {
  const ChooseCountryCode({
    super.key,
    required this.onChanged,
  });
  final onChanged;
  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      dialogSize: Size(150, Get.height / 1.2),
      flagWidth: 25,
      onChanged: onChanged,
      initialSelection: 'TG',
      favorite: const ['+228', 'TG'],
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      textStyle: const TextStyle(
        fontSize: 20 * .7 / phoneScallerFactor,
        color: Colors.black,
      ),
      padding: const EdgeInsets.only(right: 6),
    );
  }
}
