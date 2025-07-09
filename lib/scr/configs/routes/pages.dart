import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/signIn/connexion.dart';
import 'package:moger_web/scr/presentation/signIn/inscription.dart';
import 'package:moger_web/scr/presentation/views/about/nous-contacter.dart';
import 'package:moger_web/scr/presentation/views/about/qui-sommes-nous.dart';
import 'package:moger_web/scr/presentation/views/home/compte/alertes/view/alertes.dart';
import 'package:moger_web/scr/presentation/views/home/compte/edit_profile.dart';
import 'package:moger_web/scr/presentation/views/home/compte/mon_compte.dart';
import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/agences/professionnel_explain_and_choose.dart';
// import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/agences/trouver_professionnel.dart';
import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/faq.dart';
import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/mes_anonnces/mes_annonces.dart';
import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/mes_anonnces/publisher_real_state_details_page.dart';
import 'package:moger_web/scr/presentation/views/home/compte/proprietaire/proprietaire.dart';
import 'package:moger_web/scr/presentation/views/home/favoris/favoris.dart';
import 'package:moger_web/scr/presentation/views/home/search/agence/view_agence.dart';
import 'package:moger_web/scr/presentation/views/home/search/real_state_elements.dart/real_states_details_page.dart';
import 'package:moger_web/scr/presentation/views/home/search/search_page.dart';
import 'package:moger_web/scr/presentation/views/legal/condition_generales.dart';
import 'package:moger_web/scr/presentation/views/legal/fonctionnement_service.dart';
import 'package:moger_web/scr/presentation/views/legal/protection_donnees.dart';
import 'package:moger_web/scr/presentation/views/publication/edit/edit_real_state.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/congratulation.dart';
import 'package:moger_web/scr/presentation/views/publication/elements/publication_explain.dart';
import 'package:moger_web/scr/presentation/views/publication/other/estimation_explain.dart';
import 'package:moger_web/scr/presentation/views/publication/publication.dart';

class Routes {
  static get pages => [
        GetPage(name: RoutesNames.home, page: () => Home()),
        GetPage(name: RoutesNames.search, page: () => const SearchPage()),
        GetPage(name: RoutesNames.quiSommesNous, page: () => const QuiSommesNous()),
        GetPage(name: RoutesNames.nousContacter, page: () => const NousContacter()),
        // GetPage(
        //     name: RoutesNames.trouverProfessionnel,
        //     page: () => TrouverProfessionnel()),
        GetPage(
            name: RoutesNames.fonctionnementService,
            page: () => const FonctionnementService()),
        GetPage(
            name: RoutesNames.protectionDeDonnes,
            page: () => ProtectionDeDonnees()),
        GetPage(
            name: RoutesNames.conditionGenerale,
            page: () =>  CondtionsGenerales()),
        GetPage(
            name: RoutesNames.searchAndExplainProfessionnels,
            page: () => const ProfessionnelExplainAndChoose()),
        GetPage(
            name: RoutesNames.publisherRealStateDetailsPage,
            page: () => PublisherRealSTateDetailsPage()),
        GetPage(name: RoutesNames.editRealState, page: () => Modifier()),
        GetPage(name: RoutesNames.proprietaire, page: () => const Proprietaire()),
        GetPage(name: RoutesNames.faq, page: () => const FAQ()),
        GetPage(
            name: RoutesNames.estimationExplain,
            page: () => const EstimationExplain()),
        GetPage(name: RoutesNames.mesAnnonces, page: () => const MesAnnonces()),
        GetPage(name: RoutesNames.alertes, page: () => const Alertes()),
        GetPage(name: RoutesNames.monCompte, page: () => const MonCompte()),
        GetPage(name: RoutesNames.biens, page: () => RealStateDetailsPage()),
        GetPage(name: RoutesNames.agences, page: () => ViewPartenaire()),
        GetPage(name: RoutesNames.connexion, page: () => Connexion()),
        GetPage(name: RoutesNames.inscription, page: () => Inscription()),
        GetPage(name: RoutesNames.editProfil, page: () => EditProfil()),
        GetPage(
            name: RoutesNames.publicationExplain,
            page: () => const PublicationExplain()),
        GetPage(name: RoutesNames.publication, page: () => const Publication()),
        GetPage(name: RoutesNames.congratulation, page: () => const Congratulation()),
        GetPage(name: RoutesNames.favoris, page: () => const Favoris()),
      ];
}
