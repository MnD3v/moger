

import 'package:moger_web/scr/configs/app/export.dart';
import 'package:moger_web/scr/presentation/views/publication/publication.dart';

class PChooseContacts extends StatelessWidget {
  const PChooseContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return EColumn(
      children: [
        const EText(
          "Complétez vos informations de contact",
          size: 26,
          weight: FontWeight.bold,
        ),
        12.h,
        const EText("* Inforamtions obligatoire"),
        12.h,
        OutlineTextField(
            
            initialValue: Publication.realState.contacts.numero,
            label: "Numero de telephone*",
            number: true,
            prefix: const EText(
              "+228 ",
              weight: FontWeight.w500,



            ),
            onChanged: (value) {
              Publication.realState.contacts.numero =
                  value.replaceAll(" ", "");
            },
            phoneScallerFactor: phoneScallerFactor),
        const EText("Facilitez vos échanges avec vos futurs candidats"),
      
      ],
    );
  }
}
