import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/home/search/agence/widgets/social_element.dart';
import 'package:moger_web/scr/presentation/views/home/search/real_state_elements.dart/real_states_details_page.dart';

class ReseauSociaux extends StatelessWidget {
  const ReseauSociaux({super.key, required this.partenaire});
  final Partenaire partenaire;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: Get.width,
      color: Colors.black,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BigTitleText(
            "Suivez-nous !",
            color: Colors.white,
          ),
          Wrap(
            children: [
              partenaire.reseauxSociaux!.facebook.isNul
                  ? 0.h
                  : SocialElement(
                      url: partenaire.reseauxSociaux!.facebook,
                      image: "facebook",
                    ),
              partenaire.reseauxSociaux!.instagram.isNul
                  ? 0.h
                  : SocialElement(
                      url: partenaire.reseauxSociaux!.instagram,
                      image: "instagram",
                    ),
              partenaire.reseauxSociaux!.linkedIn.isNul
                  ? 0.h
                  : SocialElement(
                      url: partenaire.reseauxSociaux!.linkedIn,
                      image: "linkedin",
                    ),
              partenaire.reseauxSociaux!.twitter.isNul
                  ? 0.h
                  : SocialElement(
                      url: partenaire.reseauxSociaux!.twitter,
                      image: "twitter",
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class Contacts extends StatelessWidget {
  const Contacts({super.key, required this.partenaire});
  final partenaire;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              final Uri whatsappUrl = Uri(
                scheme: 'https',
                host: 'wa.me',
                path: partenaire.telephone.indicatif + partenaire.telephone.numero, // Use the user's phone number here
                queryParameters: {'text': 'Bonjour !'},
              );
              launchUrl(whatsappUrl);
            },
            child: Image(
              image: AssetImage(Assets.icons("social/whatsapp.png")),
              height: 40,
            )),
        24.w,
        partenaire.email == null
            ? 0.h
            : InkWell(
                onTap: () {
                  var url = "mailto:${partenaire.email}";
                  launchUrl(Uri.parse(url));
                },
                child: Image(
                  image: AssetImage(Assets.icons("social/gmail.png")),
                  height: 26,
                ),
              )
      ],
    );
  }
}

class Map extends StatelessWidget {
  const Map({
    super.key,
    required this.partenaire,
  });

  final Partenaire partenaire;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(partenaire.localisation!.latitude,
            partenaire.localisation!.longitude),
        initialZoom: 12.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            marker(
              LatLng(partenaire.localisation!.latitude,
                  partenaire.localisation!.longitude),
            )
          ],
        )
      ],
    );
  }
}
