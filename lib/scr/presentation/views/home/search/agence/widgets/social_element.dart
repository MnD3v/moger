
import 'package:moger_web/scr/configs/app/export.dart';

class SocialElement extends StatelessWidget {
  const SocialElement({super.key, required this.url, required this.image});
  final url;
  final image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0,bottom: 8, top: 8),
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse(url));
        },
        child: Image(
          image: AssetImage(Assets.icons("social/$image.png")),
          color: Colors.white,
          height: 30,
        ),
      ),
    );
  }
}
