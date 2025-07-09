import 'package:flutter/material.dart';
import 'package:moger_web/scr/configs/app/export.dart';




class ProtectionDeDonnees extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;
     return EScaffold(
         appBar: appBar(width),
          body:  EColumn(
             children: [
               Center(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: SizedBox(
                     width: width,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                     24.h,
                          EText('Politique de Protection des Données',
                                        size: 40, weight: FontWeight.w600,
                     
                          ),
                     
                          24.h,
                       EText(
                           '1. Introduction',
                                         size: 26, weight: FontWeight.w600,
                     
                         ),
                         SizedBox(height: 8),
                       EText(
                           'Bienvenue sur [Nom de l\'Application]. Nous nous engageons à protéger vos données personnelles et à respecter votre vie privée. La présente Politique de Protection des Données décrit comment nous collectons, utilisons, et protégeons vos informations personnelles lorsque vous utilisez notre application.',
                         ),
                         SizedBox(height: 16),
                       EText(
                           '2. Collecte des Données',
                                         size: 26, weight: FontWeight.w600,
                     
                         ),
                         SizedBox(height: 8),
                       EText(
                           '2.1. Données Personnelles Collectées\n'
                           'Nous pouvons collecter les informations suivantes lorsque vous utilisez notre application :\n'
                           '- Informations personnelles (nom, adresse e-mail, numéro de téléphone)\n'
                           '- Informations de connexion et d’utilisation (identifiants de compte, préférences)\n'
                           '- Contenu que vous publiez (annonces immobilières, commentaires)\n\n'
                           '2.2. Données Collectées Automatiquement\n'
                           'Nous collectons également des informations automatiquement lorsque vous utilisez l\'application, telles que des données de localisation, des informations sur votre appareil, et des données de navigation.',
                         ),
                         SizedBox(height: 16),
                       EText(
                           '3. Utilisation des Données',
                                         size: 26, weight: FontWeight.w600,
                     
                         ),
                         SizedBox(height: 8),
                       EText(
                           'Nous utilisons vos données personnelles pour :\n'
                           '- Vous fournir et améliorer nos services\n'
                           '- Gérer votre compte utilisateur\n'
                           '- Vous contacter pour des mises à jour ou des informations pertinentes\n'
                           '- Analyser l’utilisation de l\'application pour améliorer notre offre\n\n'
                           'Nous ne partagerons vos informations personnelles avec des tiers que dans les conditions décrites dans cette politique.',
                         ),
                         SizedBox(height: 16),
                       EText(
                           '4. Protection des Données',
                                         size: 26, weight: FontWeight.w600,
                     
                         ),
                         SizedBox(height: 8),
                       EText(
                           'Nous mettons en œuvre des mesures de sécurité techniques et organisationnelles appropriées pour protéger vos données personnelles contre la perte, l\'accès non autorisé, la divulgation, la modification, ou la destruction. Cependant, aucune méthode de transmission sur Internet ou de stockage électronique n\'est totalement sécurisée, et nous ne pouvons garantir une sécurité absolue.\n\n'
                           '4.1. Responsabilité des Utilisateurs\n'
                           'Vous êtes responsable de la protection de vos informations de connexion et de toute activité effectuée sous votre compte. Veuillez nous informer immédiatement de toute utilisation non autorisée de votre compte ou de toute autre violation de la sécurité.',
                         ),
                         SizedBox(height: 16),
                       EText(
                           '5. Partage des Données',
                                         size: 26, weight: FontWeight.w600,
                     
                         ),
                         SizedBox(height: 8),
                       EText(
                           'Nous pouvons partager vos données personnelles avec des tiers dans les cas suivants :\n'
                           '- Avec des prestataires de services qui nous aident à fournir nos services\n'
                           '- En réponse à des demandes légales ou pour se conformer aux exigences légales\n'
                           '- En cas de fusion, acquisition ou autre changement de contrôle de notre entreprise\n\n'
                           'Nous ne vendons pas vos informations personnelles à des tiers.',
                         ),
                         SizedBox(height: 16),
                       EText(
                           '6. Vos Droits',
                                         size: 26, weight: FontWeight.w600,
                     
                         ),
                         SizedBox(height: 8),
                       EText(
                           'Vous avez les droits suivants concernant vos données personnelles :\n'
                           '- Accéder à vos données personnelles et obtenir une copie\n'
                           '- Rectifier toute information inexacte ou incomplète\n'
                           '- Demander la suppression de vos données personnelles, sous certaines conditions\n'
                           '- Limiter ou s\'opposer au traitement de vos données\n\n'
                           'Pour exercer vos droits, veuillez nous contacter à [adresse e-mail de contact].',
                         ),
                         SizedBox(height: 16),
                       EText(
                           '7. Modifications de la Politique',
                                         size: 26, weight: FontWeight.w600,
                     
                         ),
                         SizedBox(height: 8),
                       EText(
                           'Nous pouvons mettre à jour cette Politique de Protection des Données de temps à autre. Les modifications entreront en vigueur dès leur publication sur l\'application. Nous vous encourageons à consulter régulièrement cette politique pour rester informé des éventuelles modifications.',
                         ),
                         SizedBox(height: 16),
                       EText(
                           '8. Contact',
                                         size: 26, weight: FontWeight.w600,
                     
                         ),
                         SizedBox(height: 8),
                       EText(
                           'Pour toute question concernant cette Politique de Protection des Données ou pour exercer vos droits, veuillez nous contacter à [adresse e-mail de contact] ou via notre site web à [URL du site].',
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
               bottomAppBar(width: constraints.maxWidth)
             ],
           ),
        );
      }
    );
  }
}
