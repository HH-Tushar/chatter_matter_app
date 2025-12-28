import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../firebase_options.dart';

// const FirebaseOptions firebaseOptions = FirebaseOptions(
//   apiKey: "fake-api-key", // anything
//   appId: "1:1234567890:android:abc", // anything
//   messagingSenderId: "1234567890", // anything
//   projectId: "my-emulator-app", // MUST match emulator projectId
//   storageBucket: "demo-no-project.appspot.com",//must match the actual data
// );

class FirebaseInitializer {
  /// Call this before runApp()
  static Future<void> initialize({required bool useLocal}) async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    if (useLocal) {
      _connectToLocalEmulators();
    }
  }

  /// Connect to local Firebase emulators
  static void _connectToLocalEmulators() {
    const host = 'localhost';

    FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    FirebaseStorage.instance.useStorageEmulator(host, 9199);

    // Optional: Firebase Storage (if using)
    // FirebaseStorage.instance.useStorageEmulator(host, 9199);

    print("🔥 Connected to Firebase Local Emulators");
  }
}
