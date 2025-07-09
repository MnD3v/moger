

import 'package:moger_web/scr/configs/app/export.dart';

class Buy_Locate extends StatelessWidget {
  Buy_Locate({super.key, required this.buy_locate});
  Rx<String?> buy_locate;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RechercheController>();

    return EScaffold(
        appBar: AppBar(
          title: const TitleText(
            "Transaction",
         
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              EColumn(crossAxisAlignment: CrossAxisAlignment.center, children: [
            24.h,
            const TitleText(
              "Que recherchez-vous ?",
            
            ),
            32.h,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Component(
                  icon: "acheter",
                  groupeValue: buy_locate,
                  value: RealState.acheter,
                  onTap: () {
                    buy_locate.value = RealState.acheter;
                    waitAfter(333, () {
                      Get.back();
                    });
                  },
                ),
                24.w,
                _Component(
                  icon: "louer",
                  groupeValue: buy_locate,
                  value: RealState.louer,
                  onTap: () {
                    buy_locate.value = RealState.louer;
                    waitAfter(333, () {
                      Get.back();
                    });
                  },
                ),
              ],
            ),
            48.h,
            const Divider(),
            48.h,
            const TitleText(
              "Vous êtes propriétaire ?",
             
            ),
            48.h,
      /*       Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Component(
                  icon: "vendre",
                  groupeValue: buy_locate,
                  value: "Vendre mon bien",
                  onTap: () {

                     if (Utilisateur.currentUser.value == null) {
                                Get.bottomSheet(NoAccount(
                                  function: () {
                                      Get.back();
                    Get.back();
                    HomePage.pageController.jumpToPage(
                      3,
                    );

                    Get.to(const PublicationExplain(), fullscreenDialog: true);
                                  },
                                  title:
                                      "Créez un compte pour publier vos annonces",
                                  desc1:
                                      "Publiez simplement et rapidement vos annonces.",
                                  desc2:
                                      "Suivez l'etat de vos annonces, modifiez, supprimez...",
                                ));
                                return;
                              }
                    Get.back();
                    Get.back();
                    HomePage.pageController.jumpToPage(
                      3,
                    );

                    Get.to(const PublicationExplain(), fullscreenDialog: true);
                  },
                ),
                24.w,
                _Component(
                  icon: "location",
                  groupeValue: buy_locate,
                  value: "Mettre en location",
                  onTap: () {
                    if (Utilisateur.currentUser.value == null) {
                                Get.bottomSheet(NoAccount(
                                  function: () {
                                      Get.back();
                    Get.back();
                    HomePage.pageController.jumpToPage(
                      3,
                    );

                    Get.to(const PublicationExplain(), fullscreenDialog: true);
                                  },
                                  title:
                                      "Créez un compte pour publier vos annonces",
                                  desc1:
                                      "Publiez simplement et rapidement vos annonces.",
                                  desc2:
                                      "Suivez l'etat de vos annonces, modifiez, supprimez...",
                                ));
                                return;
                              }
                    Get.back();
                    Get.back();
                    HomePage.pageController.jumpToPage(
                      3,
                    );

                    Get.to(const PublicationExplain(), fullscreenDialog: true);
                   },
                ),
                24.w,
                _Component(
                  icon: "estimer",
                  groupeValue: buy_locate,
                  value: "Estimer mon bien",
                  onTap: () {
                      Get.back();
                    Get.back();
                    HomePage.pageController.jumpToPage(
                      3,
                    );

                    Get.to(const EstimationExplain(), fullscreenDialog: true);
                  },
                ),
              ],
            ),
       */    ]),
        ));
  }
}

class _Component extends StatelessWidget {
  const _Component(
      {required this.icon,
      required this.onTap,
      required this.value,
      required this.groupeValue});
  final icon;
  final String value;
  final onTap;

  final groupeValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Obx(
        () => Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(Assets.icons(icon + ".png")),
                height: 35,
                color: groupeValue == value
                    ? AppColors.color500
                    : AppColors.textColor,
              ),
              SizedBox(
                width: 80,
                child: EText(
                  value,
                  weight: FontWeight.bold,
                
                  color: groupeValue == value
                      ? AppColors.color500
                      : AppColors.textColor,
                  align: TextAlign.center,
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
