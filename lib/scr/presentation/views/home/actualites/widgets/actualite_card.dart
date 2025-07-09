import 'package:cached_network_image/cached_network_image.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class ActualiteCard extends StatelessWidget {
  const ActualiteCard({super.key, required this.actu, required this.width});
  final double width;
  final Actu actu;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(actu.link));
      },
      child: width > 400
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 300,
                height: 250,
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ]),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: 150,
                            width: 300,
                            child:
                                EFadeInImage(image: NetworkImage(actu.image))),
                        Container(
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2)),
                            child: EText(actu.sujet, color: AppColors.color500))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EText(
                        actu.title,
                        weight: FontWeight.w500,
                        size: 22,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width - 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                  color: AppColors.blue.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(3)),
                              child: EText(actu.sujet, color: AppColors.blue),
                            ),
                            6.h,
                            EText(
                              actu.title,
                              weight: FontWeight.bold,
                            ),
                            6.h,
                            EText(
                              actu.date.split(" ")[0],
                              color: Colors.black54,
                              // weight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                      9.w,
                      SizedBox(
                          height: 80,
                          width: 80,
                          child: EFadeInImage(
                              radius: 6,
                              image: CachedNetworkImageProvider(actu.image))),
                    ],
                  ),
                ),
                9.h,
                const Divider(),
                9.h,
              ],
            ),
    );
  }
}


