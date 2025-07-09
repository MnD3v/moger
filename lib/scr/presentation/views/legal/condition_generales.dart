import 'package:flutter/material.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class CondtionsGenerales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;
      return EScaffold(
        appBar: appBar(width),
        body: EColumn(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        24.h,
                        EText(
                          'Conditions Générales d\'Utilisation',
                          size: 38,
                          weight: FontWeight.w600,
                        ),
                        24.h,
                        EText(
                          '1. Introduction',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          'Bienvenue sur FlashImmo, une application immobilière développée par FlashImmo. Notre application a pour seul objectif de mettre en relation des professionnels de l\'immobilier avec des clients intéressés. En accédant ou en utilisant notre application, vous acceptez les présentes Conditions Générales d\'Utilisation (CGU). Veuillez les lire attentivement.',
                        ),
                        SizedBox(height: 16),
                        EText(
                          '2. Acceptation des Conditions',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          'En utilisant l\'application, vous acceptez d\'être lié par ces CGU. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser notre application.',
                        ),
                        SizedBox(height: 16),
                        EText(
                          '3. Modifications des Conditions',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          'Nous nous réservons le droit de modifier ces CGU à tout moment. Les modifications entreront en vigueur dès leur publication sur l\'application. Votre utilisation continue de l\'application après publication des modifications constitue votre acceptation des nouvelles conditions.',
                        ),
                        SizedBox(height: 16),
                        EText(
                          '4. Utilisation de l\'Application',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          '4.1. Inscription et Compte Utilisateur\n'
                          'Pour accéder à certaines fonctionnalités de l\'application, vous devrez créer un compte. Vous êtes responsable de la confidentialité de vos identifiants de connexion et de toutes les activités effectuées sous votre compte.\n\n'
                          '4.2. Responsabilité des Utilisateurs\n'
                          'Vous vous engagez à utiliser l\'application de manière légale et conformément aux lois en vigueur. Vous êtes responsable de la véracité et de l\'exactitude des informations que vous fournissez.\n\n'
                          '4.3. Contenu Généré par les Utilisateurs\n'
                          'En publiant du contenu sur l\'application (comme des annonces immobilières), vous accordez à FlashImmo une licence mondiale, non exclusive, gratuite, et transférable pour utiliser, reproduire, modifier, publier, et afficher ce contenu.\n\n'
                          '4.4. Rôle de l\'Application\n'
                          'L\'application se charge uniquement de mettre en relation des professionnels de l\'immobilier avec des clients. Nous ne sommes pas responsables des transactions, accords, ou relations entre les professionnels et les clients. Chaque utilisateur doit faire preuve de vigilance et s\'assurer de la fiabilité et de la conformité des parties avec lesquelles il interagit.',
                        ),
                        SizedBox(height: 16),
                        EText(
                          '5. Propriété Intellectuelle',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          'Tous les droits de propriété intellectuelle relatifs à l\'application, y compris les logos, marques, et le code source, sont la propriété exclusive de FlashImmo ou de ses concédants de licence. Vous vous engagez à ne pas copier, reproduire, ou distribuer ces éléments sans notre autorisation préalable.',
                        ),
                        SizedBox(height: 16),
                        EText(
                          '6. Limitation de Responsabilité',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          'L\'application est fournie "en l\'état" et FlashImmo ne garantit pas son bon fonctionnement, son absence d\'erreurs ou sa disponibilité continue. Nous ne serons pas responsables des dommages directs, indirects, spéciaux ou consécutifs résultant de l\'utilisation de l\'application. Nous ne sommes pas responsables des interactions entre les professionnels de l\'immobilier et les clients.',
                        ),
                        SizedBox(height: 16),
                        EText(
                          '7. Protection des Données',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          'Nous nous engageons à protéger vos données personnelles conformément à notre Politique de Confidentialité. En utilisant l\'application, vous consentez à la collecte et à l\'utilisation de vos données comme décrit dans cette politique.',
                        ),
                        SizedBox(height: 16),
                        EText(
                          '8. Résiliation',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          'Nous nous réservons le droit de suspendre ou de résilier votre accès à l\'application à tout moment et sans préavis en cas de violation des présentes CGU ou pour d\'autres raisons.',
                        ),
                        SizedBox(height: 16),
                        EText(
                          '9. Contact',
                          size: 26,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 8),
                        EText(
                          'Pour toute question, veuillez nous contacter à flash.immo@gmail.com ou au +228 98784589.',
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
    });
  }
}
