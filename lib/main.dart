
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moger_web/firebase_options.dart';
import 'package:moger_web/scr/configs/routes/names.dart';
import 'package:moger_web/scr/configs/routes/pages.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/bindings/inital_binging.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/controllers/favoris_controller.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/controllers/search_controller.dart';
import 'package:moger_web/scr/presentation/views/home/home.dart';
import 'package:moger_web/scr/presentation/views/home/search/real_state_elements.dart/real_states_body_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:my_widgets/real_state/models/utilisateur.dart';
import 'package:my_widgets/widgets/custom_show_dialog.dart';
import 'package:my_widgets/widgets/warning.dart';

import 'scr/configs/app/export.dart';

const phoneScallerFactor = 1.0;
void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    if (user.email != null) {
      await Utilisateur.getUser(user.email!);
    } else {
      await Utilisateur.getUser(user.phoneNumber!.substring(4));
    }
  }
  initialControllers();
  await getLocations();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyBehavior(),
      home: Home(),
      initialBinding: InitialBinding(),
      initialRoute: RoutesNames.home,
      getPages: Routes.pages));
}

void initialControllers() {
  Get.lazyPut(() => FavorisController());
  Get.lazyPut(() => RechercheController());
}

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/'); // Navigate to home page
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
 
}

   getLocations() async {
    try {
      var q = await DB
          .firestore(Collections.utils)
          .doc(Collections.localites)
          .get(GetOptions(source: Source.server));
      Constants.localites = convertData(q.data()!);


 
    } on Exception {
      Custom.showDialog(WarningWidget(
          confirm: () async {
            Get.back();
            getLocations();
          },
          message:
              "Une erreur s'est produite. Vérifiez votre connexion internet et réessayez svp !"));
      return;
      // TODO
    }
  }
  
Map<String, Map<String, List<String>>> convertData(Map<String, dynamic> data) {
  try {
    return data.map((key, value) {
      if (value is Map<String, dynamic>) {
        return MapEntry(key, value.map((innerKey, innerValue) {
          if (innerValue is List<dynamic>) {
            return MapEntry(innerKey, List<String>.from(innerValue));
          } else {
            throw Exception("Invalid innerValue type");
          }
        }));
      } else {
        throw Exception("Invalid value type");
      }
    });
  } catch (e) {
    print("Error converting data: $e");
    return {};
  }
}

