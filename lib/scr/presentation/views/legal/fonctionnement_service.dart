import 'package:moger_web/scr/configs/app/export.dart';

class FonctionnementService extends StatelessWidget {
  const FonctionnementService({super.key});

  static final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;
      return EScaffold(
        appBar: appBar(width),
          body: EColumn(
        children: [
          Center(
            child: SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.h,
                        const EText(
                          "Fonctionnement du service",
                          size: 40,
                          weight: FontWeight.w600,
                        ),
                        12.h,
                        const EText(
                          "Vous voulez comprendre exactement comment fonctionne le service Moger ?",
                          maxLines: 12,
                          weight: FontWeight.bold,
                        ),
                        6.h,
                        const EText(
                          "Retrouvez ci-dessous toutes les informations à connaitre.",
                          maxLines: 12,
                        ),
                        12.h,
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        24.h,
                        EText(
                            "1. RÉFÉRENCEMENT ET DERÉFÉRENCEMENT DES ANNONCEURS :",
                            weight: FontWeight.bold,
                            color: AppColors.blue),
                        6.h,
                        const EText(
                          "(i) Référencement des Annonceurs :",
                          weight: FontWeight.w600,
                        ),
                        const EText(
                            "La diffusion d’annonces sur l'application est réservée aux Annonceurs définis ci-dessous :"),
                        6.h,
                        const EText(
                          "(i-i) Annonceurs professionnels ayant souscrit à titre payant un contrat de diffusion d’annonces de vente de biens immobiliers avec la société Moger: ",
                          weight: FontWeight.w500,
                        ),
                        _Element(width:width,
                            label:
                                "les professionnels de l’immobilier détenant une carte de transaction ou de gestion"),
                        _Element(width:width,label: "les notaires,"),
                        _Element(width:width,
                            label:
                                "les avocats exerçant à titre accessoire l’activité de mandataire en transactions immobilières,"),
                        _Element(width:width,label: "les huissiers,"),
                        _Element(width:width,label: "les constructeurs."),
                        6.h,
                        const EText(
                            "(i-ii) Annonceurs particuliers ayant préalablement accepté les Conditions Générales de Souscription d’annonces sur l'application Moger (ci-après « l’Annonceur Particulier »). La diffusion d’annonces est gratuite pour les Annonceurs Particuliers.",
                            weight: FontWeight.w500),
                        24.h,
                        const EText(
                          "(ii) Référencement des Annonces :",
                          weight: FontWeight.w600,
                        ),
                        9.h,
                        const EText(
                          "Contenu de l’Annonce",
                          weight: FontWeight.bold,
                          underline: true,
                        ),
                        const EText(
                          "Le bien doit être diffusé dans sa catégorie et être conforme aux produits de diffusion souscrits par l’Annonceur. Sur l'application, l’Annonce ne peut porter que sur :",
                          maxLines: 90,
                        ),
                        _Element(width:width,
                            label:
                                "la vente et la location de biens anciens, ayant déjà fait l’objet d’un transfert de propriété;"),
                        _Element(width:width,
                            label:
                                "la vente de lots associés à des programmes immobiliers neufs, n’ayant pas encore fait l’objet d’un transfert de propriété."),
                        12.h,
                        const EText(
                          "Contenu interdit au sein d’une Annonce",
                          weight: FontWeight.bold,
                          underline: true,
                        ),
                        const EText(
                          "Toute Annonce contenant des éléments qui sembleraient contraires aux dispositions légales ou réglementaires, aux bonnes mœurs, aux règles de diffusion de notre Site ou susceptible de heurter les Utilisateurs sera immédiatement refusée par la société Moger, donc non référencée sur l'application.",
                          maxLines: 90,
                        ),
                        const EText("Est notamment strictement interdit :"),
                        _Element(width:width,
                            label:
                                "Tout contenu rédigé en langue étrangère comportant des termes ou des descriptions sans lien avec le contenu proposé ;"),
                        _Element(width:width,
                            label:
                                "Tout contenu comportant des termes ou des descriptions sans lien avec le contenu proposé ;"),
                        _Element(width:width,
                            label:
                                "Tout contenu portant sur un bien immobilier ou programme de construction fictif ;"),
                        _Element(width:width,
                            label:
                                "Tout contenu frauduleux, ou visant à tromper l’Utilisateur ;"),
                        _Element(width:width,
                            label:
                                "Tout contenu à caractère politique, religieux ou haineux ;"),
                        _Element(width:width,
                            label:
                                "Tout contenu à caractère promotionnel et/ou publicitaire ;"),
                        _Element(width:width,
                            label:
                                "Toute image ou photographie sans lien avec l’offre proposée, non autorisée, contrefaisante, ou encore à caractère pornographique."),
                        24.h,
                        const EText(
                          "(iii) Déréférencement des Annonces et Annonceurs :",
                          weight: FontWeight.w600,
                        ),
                        const EText(
                            "En cas de non-respect par l’Annonceur de ses engagements contractuels et / ou de la réglementation en vigueur et en particulier celle applicable aux Annonceurs professionnels de l’immobilier et/ou des règles de référencement décrites ci-dessus et de la Charte de diffusion accessible ici, la société Moger se réserve le droit, de refuser ou de bloquer la publication d’Annonces et / ou de suspendre le compte ou de résilier le contrat de l’Annonceur, sans notification préalable le cas échéant."),
                        24.h,
                        const EText(
                          "(iv) Signalement de contenu illégal :",
                          weight: FontWeight.w600,
                        ),
                        const EText(
                            "Moger permet aux Utilisateurs de son Site de signaler tout contenu illégal, telle qu’une arnaque, une tentative de fraude, un comportement suspect, une contrefaçon ou encore toute infraction aux dispositions légales et réglementaires. Ces signalements peuvent être envoyés directement à la société Moger depuis la page de l’Annonce ou de l’Annonceur."),
                        24.h,
                        EText("2. CLASSEMENT DES ANNONCES :",
                            weight: FontWeight.bold, color: AppColors.blue),
                        9.h,
                        const EText(
                          "(i) L’Utilisateur ne dispose pas de la possibilité de personnaliser son tri",
                          weight: FontWeight.w600,
                        ),
                        const EText(
                            "Le tri par défaut des Annonces (intitulé « Tri par Sélection ») sur la page de résultats du Site est l’ordre d’affichage des Annonces qui s’applique automatiquement"),
                        12.h,
                        const EText(
                          "1. Typologie de l’Annonceur",
                          weight: FontWeight.bold,
                        ),
                        const EText(
                            "Si l’Annonce est publiée par un Annonceur professionnel ou un Annonceur particulier, l'application étant avant tout une plateforme pour les Annonceurs professionnels, les Annonces publiées par des Annonceurs professionnels auront une plus grande visibilité en liste de résultats du Site."),
                        12.h,
                        const EText(
                          "2. Option payante",
                          weight: FontWeight.bold,
                        ),
                        const EText(
                            "Selon l’option payante éventuellement activée par l’Annonceur professionnel sur une ou plusieurs de ses Annonces, celles-ci pourront bénéficier, dans le tri initial par défaut du Site Moger, d’une priorité d’affichage en liste de résultats du Site. L’ordre d’affichage prioritaire s’effectue en fonction de l’option activée par l’Annonceur professionnel sur l’Annonce et du degré de mise en avant octroyée par chaque option."),
                        24.h,
                        const EText(
                          "(ii) Suggestion :",
                          weight: FontWeight.bold,
                        ),
                        const EText(
                          "L’Utilisateur pourra se voir également suggérer des Annonces susceptibles de l’intéresser (intitulées « Suggestion » ou « Sponsorisée » ). Ces suggestions sont sélectionnées en fonction (i) des critères de recherche de l’Utilisateur (types de biens recherchés, localité, prix, surface) et (ii) de la formule d’abonnement et des options payantes éventuellement activées par l’Annonceur.",
                          maxLines: 90,
                        ),
                        24.h,
                        EText(
                            "3. CLASSEMENT DE L’ANNUAIRE DES ANNONCEURS PROFESSIONNELS :",
                            weight: FontWeight.bold,
                            color: AppColors.blue),
                        const EText(
                            "Le classement par défaut de l’annuaire est réalisé en fonction de la date de mise en ligne de la page de l’Annonceur (de la plus ancien à la moins ancien)."),
                        24.h,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
           bottomAppBar(width: constraints.maxWidth)
      
        ],
      ));
    });
  }
}

class _Element extends StatelessWidget {
  _Element({required this.label, required this.width});
  final label;
  final width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.w,
          const Padding(
            padding: EdgeInsets.all(6.0),
            child: Icon(Icons.radio_button_unchecked, size: 9),
          ),
          SizedBox(
            width: width - 100,
            child: EText(
              label,
              maxLines: 15,
            ),
          )
        ],
      ),
    );
  }
}
