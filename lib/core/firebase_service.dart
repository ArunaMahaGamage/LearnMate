import 'package:firebase_core/firebase_core.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp();
  // Ensure you added platform-specific configs (google-services.json, GoogleService-Info.plist).
}
