import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class ViewDocuments extends StatelessWidget {
  const ViewDocuments({super.key, required this.legalite});
  final Legalite legalite;
  @override
  Widget build(BuildContext context) {
    return EScaffold(
        appBar: AppBar(
          title: const TitleText("Documents"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: EColumn(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: EText(legalite.nom,
                  size: 24, weight: FontWeight.bold, underline: true),
            ),
            12.h,
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: legalite.images
                  .map((e) => InkWell(
                    onTap: (){
                      showImageViewer(context,  NetworkImage(e));
                    },
                    child: Container(
                          padding: const EdgeInsets.all(6),
                          height: Get.width / 2 - 20,
                          width: Get.width / 2 - 20,
                          child: EFadeInImage(image: NetworkImage(e)),
                        ),
                  ))
                  .toList(),
            )
          ]),
        ));
  }
}
