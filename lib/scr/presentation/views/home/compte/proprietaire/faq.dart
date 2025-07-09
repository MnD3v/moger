
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/signIn/connexion.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  String nom = "";
  String telephone = "";
  String message = "";
  String country = "+228";
  var isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
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
                      children: [
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.image("aide_wallpaper.png")),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            children: [
                              12.h,
                              const EText(
                                "Aide & contact",
                                size: 40,
                                weight: FontWeight.w900,
                              ),
                              12.h,
                              const EText(
                                "Vous avez une question ou une demande concernant l'application Moger ?",
                                maxLines: 12,
                                weight: FontWeight.bold,
                              ),
                              6.h,
                              const EText(
                                "Retrouvez ci-dessous toutes les informations utiles ou contactez-nous si vous ne trouvez pas la réponse a votre question.",
                                maxLines: 12,
                              ),
                              12.h,
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              18.h,
                              const BigTitleText(
                                "Particuliers",
                              
                              ),
                              6.h,
                              ExpansionPanelList(
                                elevation: 0,
                                expandedHeaderPadding:
                                    const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                                expansionCallback: (panelIndex, isExpanded) {
                                  safeSetState(
                                    () {
                                      particuliersItems[panelIndex].isExpanded = isExpanded;
                                    },
                                  );
                                },
                                children: particuliersItems
                                    .map(
                                      (item) => ExpansionPanel(
                                        canTapOnHeader: true,
                                        backgroundColor: AppColors.blue.withOpacity(.1),
                                        headerBuilder: (context, isExpanded) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 9.0, vertical: 12),
                                            child: EText(
                                              item.headerValue,
                                              weight: FontWeight.bold,
                                              
                                            ),
                                          );
                                        },
                                        body: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: item.expandedValue,
                                        ),
                                        isExpanded: item.isExpanded,
                                      ),
                                    )
                                    .toList(),
                              ),
                              24.h,
                              const BigTitleText(
                                "Professionnels",
                              
                              ),
                              6.h,
                              ExpansionPanelList(
                                elevation: 0,
                                expandedHeaderPadding:
                                    const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                                expansionCallback: (panelIndex, isExpanded) {
                                  safeSetState(
                                    () {
                                      professionnelItems[panelIndex].isExpanded =
                                          isExpanded;
                                    },
                                  );
                                },
                                children: professionnelItems
                                    .map(
                                      (item) => ExpansionPanel(
                                          canTapOnHeader: true,
                                          headerBuilder: (context, isExpanded) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 9.0, vertical: 6),
                                              child: EText(
                                                item.headerValue,
                                                weight: FontWeight.bold,
                                             
                                                maxLines: 4,
                                              ),
                                            );
                                          },
                                          body: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: item.expandedValue,
                                          ),
                                          isExpanded: item.isExpanded,
                                          backgroundColor: AppColors.blue.withOpacity(.1)),
                                    )
                                    .toList(),
                              ),
                              24.h,
                              const BigTitleText(
                                "Vous n'avez pas trouvé de réponse à votre question ?",
                             
                              ),
                              12.h,
                              ETextField(
                                placeholder: "Nom complet*",
                                onChanged: (value) {
                                  nom = value;
                                },
                                phoneScallerFactor: phoneScallerFactor,
                              ),
                              9.h,
                              ETextField(
                                placeholder: "Numero de téléphone*",
                                prefix: ChooseCountryCode(onChanged: (value){
                                  country = value.dialCode!;
                                }),
                                
                                number: true,
                                onChanged: (value) {
                                  telephone = value.replaceAll(" ", "");
                                },
                                phoneScallerFactor: phoneScallerFactor,
                              ),
                              9.h,
                              ETextField(
                                placeholder: "Message*",
                                onChanged: (value) {
                                  message = value;
                                },
                                phoneScallerFactor: phoneScallerFactor,
                                maxLines: 6,
                              ),
                              12.h,
                              Center(
                                child: SimpleButton(
                                  width: 200,
                                  onTap: () async {
                                    if (nom.length < 4) {
                                      Toasts.error(context,
                                          description: "Entrez un nom valide");
                                      return;
                                    }
                                    if (!GFunctions.isPhoneNumber( country: country,numero:  telephone)) {
                                      Toasts.error(context,
                                          description: "Entrez un numero valide");
                                      return;
                                    }
                                    if (message.isEmpty) {
                                      Toasts.error(context,
                                          description: "Entrez votre message");
                                      return;
                                    }
                                    isLoading.value = true;
                                    await DB.firestore(Collections.questions).add({
                                      "nom": nom,
                                      "telephone": telephone,
                                      "message": message
                                    });
                                    isLoading.value = false;
                                    Get.back();
                                  },
                                  text: "Envoyer mon message",
                                ),
                              ),
                              24.h,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    );
  }

  List<Item> professionnelItems = [
    Item(
        headerValue: "Comment devenir un partenaire professionnel de Moger ?",
        isExpanded: false,
        expandedValue: Column(
          children: [
            const EText(
              "Nous avons un espace spécial pour les professionnels.",
              maxLines: 90,
              weight: FontWeight.w700,
            ),
            6.h,
            ETextRich(textSpans: [
              ETextSpan(text: "Télechargez l'application "),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("www.google.com"));
                  },
                  child: Container(
                    child: EText("Moger pro",
                        underline: true,
                        size: 28,
                        color: AppColors.blue,
                        weight: FontWeight.w700),
                  ),
                ),
              ),
              ETextSpan(text: " puis créez un nouveau compte."),
            ])
          ],
        )),
  ];

  List<Item> particuliersItems = [
    Item(
        headerValue: "Comment activer et gérer mes alertes ?",
        isExpanded: false,
        expandedValue: Column(
          children: [
            const EText(
                "Effectuez en premier lieu une recherche. Si vous ne trouvez pas le bien idéal pour vous dans les résultats de cette recherche, cliquez sur la cloche de notification juste en bas de la page, affectez un nom à votre alerte puis activez.",
                maxLines: 90),
            ETextRich(textSpans: [
              ETextSpan(text: "Vous pouvez retrouver vos alerte dans "),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                  
                  },
                  child: Container(
                    child: EText("Compte",
                        underline: true,
                        size: 28,
                        color: AppColors.blue,
                        weight: FontWeight.w700),
                  ),
                ),
              ),
              ETextSpan(
                  text: " > Gérer mes abonnements - ", color: AppColors.blue),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                  
                    Get.toNamed(RoutesNames.alertes);
                  },
                  child: Container(
                    child: EText("Alertes et Notifications",
                        underline: true,
                        size: 28,
                        color: AppColors.blue,
                        weight: FontWeight.w700),
                  ),
                ),
              ),
            ])
          ],
        )),
    Item(
        headerValue: "Comment publier modifier ou supprimer une annonce ?",
        isExpanded: false,
        expandedValue: Column(
          children: [
            const EText(
                "Particuliers, Moger vous permet de diffuser pour annonce immobilière gratuitement et très simplement.",
                maxLines: 90),
            ETextRich(textSpans: [
              ETextSpan(text: "Rendez-vous dans l'espace "),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    child: EText("propriétaire",
                        underline: true,
                        size: 28,
                        color: AppColors.blue,
                        weight: FontWeight.w700),
                  ),
                ),
              ),
              ETextSpan(text: " > Créer une annonce ", color: AppColors.blue),
              ETextSpan(
                text: "pour créer une annonce.",
              ),
            ]),
            ETextRich(textSpans: [
              ETextSpan(text: "Juste en bas, vous avez la partie,  "),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                    Get.back();

                    Get.toNamed(RoutesNames.mesAnnonces);
                  },
                  child: Container(
                    child: EText("Gérer mes annonces",
                        underline: true,
                        size: 28,
                        color: AppColors.blue,
                        weight: FontWeight.w700),
                  ),
                ),
              ),
              ETextSpan(
                  text:
                      " vous permettant de modifier et supprimer vos annonces")
            ])
          ],
        )),
    Item(
        headerValue:
            "Comment obtenir plus d'informations sur une annonce ou demander une visite ?",
        isExpanded: false,
        expandedValue: Column(
          children: [
            const EText(
              "Moger privilégie l'expertise d'un professionnel pour la réalisation de vos projets immobiliers.",
              maxLines: 90,
              weight: FontWeight.w700,
            ),
            6.h,
            ETextRich(textSpans: [
              ETextSpan(
                  text:
                      "Contactez l'agence ou le propriétaire via les coordonnées affichées sur les pages d'annonces."),
            ])
          ],
        )),
    Item(
        headerValue:
            "Où trouver un professionnel de l'immobilier pour mon bien ?",
        isExpanded: false,
        expandedValue: Column(
          children: [
            const EText(
              "Moger privilégie l'expertise d'un professionnel pour la réalisation de vos projets immobiliers.",
              maxLines: 90,
              weight: FontWeight.w700,
            ),
            6.h,
            ETextRich(textSpans: [
              ETextSpan(text: "Vous pouvez accéder à notre  "),
              WidgetSpan(
                child: InkWell(
                  onTap: () {
                    Get.back();

                    // Get.to(const ProfessionnelExplainAndChoose());
                  },
                  child: Container(
                    child: EText("annuaire de professionnels",
                        underline: true,
                        size: 28,
                        color: AppColors.blue,
                        weight: FontWeight.w700),
                  ),
                ),
              ),
              ETextSpan(
                  text:
                      " afin de trouver le meilleur agent pour vous accompagner dans votre projet.")
            ])
          ],
        )),
  ];
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}
