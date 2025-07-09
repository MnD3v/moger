import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moger_web/scr/presentation/utils/widgets/dialog.dart';
import 'package:my_widgets/my_widgets.dart';

class ETwoOptionsDialog extends StatelessWidget {
  const ETwoOptionsDialog(
      {super.key,
      required this.confirmFunction,
      required this.body,
      required this.confirmationText,
      required this.width,
      required this.title});
  final width;
  final confirmationText;
  final confirmFunction;
  final title;
  final body;
  @override
  Widget build(BuildContext context) {
    return EDialog(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            12.h,
            BigTitleText(
              title,
            ),
            12.h,
            EText(
              body,
              align: TextAlign.center,
            ),
            18.h,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: confirmFunction,
                    child: EText(
                      confirmationText,
                      weight: FontWeight.bold,
                    )),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const EText("Annuler", color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
