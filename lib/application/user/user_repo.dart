// import 'package:firebase_auth/firebase_auth.dart';

// class AuthRepo {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   /// Register user with email + password + displayName
//   Future<String?> registerWithEmail({
//     required String email,
//     required String password,
//     required String displayName,
//   }) async {
//     try {
//       // 1. Create Auth account
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       User? user = credential.user;
//       if (user == null) {
//         return "User creation failed";
//       }

//       // 2. Update profile (display name)
//       await user.updateDisplayName(displayName);

//       // 3. Reload to apply updates instantly
//       await user.reload();

//       return null; // success → return null
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } catch (e) {
//       return "Something went wrong: $e";
//     }
//   }
// }
