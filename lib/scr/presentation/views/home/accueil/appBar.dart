
import 'package:flutter/cupertino.dart';
import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/publication/me_or_pros.dart';

PreferredSize appBar(double width) {
  return PreferredSize(
      preferredSize: Size(width, 80),
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                12.w,
                InkWell(onTap: (){
                  Get.toNamed('/');
                },child: Image(image: AssetImage(Assets.icons('launch_icon.png')), height: 40,)),
                24.w,
                SimpleButton(
                    height: 40,
                    color: AppColors.color500,
                    width: width < 700 ? 50 : 210,
                    onTap: () {
                      Get.dialog(const MeOrPros());
                      // Get.toNamed(RoutesNames.publicationExplain);
                    },
                    child: width < 700
                        ? Icon(CupertinoIcons.add, color: AppColors.white)
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              6.w,
                              Icon(CupertinoIcons.add, color: AppColors.white),
                              9.w,
                              EText("Déposer une annonce",
                                  color: AppColors.white),
                              6.w,
                            ],
                          )),
              ],
            ),
            Row(
              children: [
                24.w,
                InkWell(
                    onTap: () {
                      Get.toNamed(RoutesNames.searchAndExplainProfessionnels);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
                        width < 700 ? 0.h : const EText("Professionnels")
                      ],
                    )),
                24.w,
                Container(height: 50, width: 1, color: Colors.black12),
                24.w,
                InkWell(
                    onTap: () {
                      if (Utilisateur.currentUser.value.isNul) {
                        Get.toNamed("${RoutesNames.connexion}?return-url=${RoutesNames.favoris}");
                        return;
                      }
                      Get.toNamed(RoutesNames.favoris);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(CupertinoIcons.heart),
                        width < 700 ? 0.h : const EText("Mes Favoris")
                      ],
                    )),
                24.w,
                Container(height: 50, width: 1, color: Colors.black12),
                24.w,
                InkWell(
                    onTap: () {
                      if (Utilisateur.currentUser.value.isNul) {
                        Get.toNamed("${RoutesNames.connexion}?return-url=${RoutesNames.monCompte}");
        
                        return;
                      }
                      Get.toNamed(RoutesNames.monCompte);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => Utilisateur.currentUser.value != null
                              ? SizedBox(
                                  height: 25,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.color100,
                                    child: EText(
                                        Utilisateur.currentUser.value!.nom[0],
                                        weight: FontWeight.bold,
                                        color: AppColors.color500),
                                  ),
                                )
                              : const Icon(Icons.account_circle_outlined),
                        ),
                        width < 700 ? 0.h : const EText("Mon compte")
                      ],
                    )),
                12.w,
              ],
            ),
          ],
        ),
      ));
}
