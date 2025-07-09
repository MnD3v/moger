

import 'package:moger_web/scr/configs/app/export.dart';

void signalerDialog(context, id) {
  String message = "";
  var isLoading = false.obs;
  return Custom.showDialog(Obx(
    () => IgnorePointer(
      ignoring: isLoading.value,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: EColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              12.h,
              const EText("Un problème avec ce service ?",
                  weight: FontWeight.bold,
                  size: 28,
                  maxLines: 4,
                  align: TextAlign.center),
              24.h,
              ETextField(
                phoneScallerFactor: phoneScallerFactor,
                placeholder: "Votre message*",
                onChanged: (value) {
                  message = value;
                },
                maxLines: 6,
              ),
              24.h,
              SimpleButton(
                  width: 150,
                  onTap: () async {
                    if (message.isEmpty) {
                      Toasts.error(context,
                          description: "Veuillez saisir votre message");
                      return;
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                    isLoading.value = true;
                    await DB.firestore(Collections.signalisations).add(
                        {"type": "partenaire", "message": message, "id": id});
                    isLoading.value = false;

                    // Send function
                    Get.back();
                  },
                  child: Obx(
                    () => isLoading.value
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.3,
                            ))
                        : const EText(
                            'Envoyer',
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                  )),
              9.h,
            ],
          ),
        ),
      ),
    ),
  ));
}
