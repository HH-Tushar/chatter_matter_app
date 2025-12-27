import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../core/api_handler.dart';
import '../../env.dart';
import '../model/user_model.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Register user with email + password + displayName
  Future<Attempt<User>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create Auth account
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user == null) {
        return failed(Failure(title: "Unable to create profile"));
      }

      return success(user);
    } on FirebaseAuthException catch (e) {
      return failed(Failure(title: e.message));
    } catch (e) {
      return failed(Failure(title: "Unable to register"));
    }
  }

  ///
  ///

  /// Register user with email + password + displayName
  Future<Attempt<User>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create Auth account
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return failed(Failure(title: "Unable to find user"));
      }

      return success(user);
    } on FirebaseAuthException catch (e) {
      return failed(Failure(title: e.message));
    } catch (e) {
      return failed(Failure(title: "Something went wrong"));
    }
  }

  /// Register user with email + password + displayName
  Future<void> logout() async {
    await _auth.signOut();
    return;
  }

  Future<Attempt<AppUser>> getProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return failed(SessionExpired());

      final token = await user.getIdToken(true);

      final url = Uri.parse("$baseUrl/getMyProfile");

      final response = await http
          .get(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          )
          .timeout(const Duration(seconds: 10)); // Prevents infinite waiting

      if (response.statusCode == 200 || response.statusCode == 201) {
        return success(AppUser.fromJson(jsonDecode(response.body)["data"]));
      } else if (response.statusCode == 401) {
        return failed(SessionExpired());
      } else if (response.statusCode == 403) {
        return failed(UnauthorizeAccess());
      }
      return failed(Failure(title: "Something went wrong"));
    } on http.ClientException catch (e) {
      return failed(Failure(title: e.message));
    } on FormatException catch (e) {
      return failed(Failure(title: e.message));
    } on Exception catch (e) {
      return failed(Failure(title: e.toString()));
    }
  }

  Future<Attempt<AppUser>> updateProfile({File? image, String? name}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return failed(SessionExpired());

      final token = await user.getIdToken(true);

      final url = Uri.parse("$baseUrl/updateMyProfile");
      late Map<String, String> body = {};

      if (image != null) {
        final (imageUrl, error) = await uploadImage(image);
        if (imageUrl != null) {
          body["imageUrl"] = imageUrl;
        } else {
          return failed(error!);
        }
      }
      if (name != null) {
        body["name"] = name;
      }

      final response = await http
          .post(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10)); // Prevents infinite waiting

      if (response.statusCode == 200 || response.statusCode == 201) {
        return success(AppUser.fromJson(jsonDecode(response.body)["data"]));
      } else if (response.statusCode == 401) {
        return failed(SessionExpired());
      } else if (response.statusCode == 403) {
        return failed(UnauthorizeAccess());
      }
      return failed(Failure(title: "Something went wrong"));
    } on http.ClientException catch (e) {
      return failed(Failure(title: e.message));
    } on FormatException catch (e) {
      return failed(Failure(title: e.message));
    } on Exception catch (e) {
      return failed(Failure(title: e.toString()));
    }
  }

  Future<Attempt<String>> changePassword({
    required String oldPass,
    required String newPass,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return failed(SessionExpired());

      final token = await user.getIdToken(true);

      final url = Uri.parse("$baseUrl/changePassword");

      final response = await http
          .post(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({"oldPassword": oldPass, "newPassword": newPass}),
          )
          .timeout(const Duration(seconds: 10)); // Prevents infinite waiting

      if (response.statusCode == 200 || response.statusCode == 201) {
        return success(jsonDecode(response.body)["message"]);
      } else if (response.statusCode == 401) {
        return failed(SessionExpired());
      } else if (response.statusCode == 403) {
        return failed(UnauthorizeAccess());
      }
      return failed(Failure(title: jsonDecode(response.body)["message"]));
    } on http.ClientException catch (e) {
      return failed(Failure(title: e.message));
    } on FormatException catch (e) {
      return failed(Failure(title: e.message));
    } on Exception catch (e) {
      return failed(Failure(title: e.toString()));
    }
  }

  Future<void> updateLastQuestion({required String questionId}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final token = await user.getIdToken(true);

      final url = Uri.parse("$baseUrl/updateMyLastSeen?id=$questionId");

      final response = await http
          .post(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          )
          .timeout(const Duration(seconds: 10)); // Prevents infinite waiting

      if (response.statusCode == 200 || response.statusCode == 201) {
        // return success(jsonDecode(response.body)["message"]);
        return;
      }
      return;
    } on Exception catch (e) {
      return;
    }
  }


  Future<void> updateLastVisit() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final token = await user.getIdToken(true);

      final url = Uri.parse("$baseUrl/updateLastVisitedAt");

      final response = await http
          .post(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          )
          .timeout(const Duration(seconds: 10)); // Prevents infinite waiting

      if (response.statusCode == 200 || response.statusCode == 201) {
        // return success(jsonDecode(response.body)["message"]);
        return;
      }
      return;
    } on Exception catch (e) {
      return;
    }
  }




  Future<Attempt<String>> uploadImage(File imageFile) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return failed(SessionExpired());

    final token = await user.getIdToken(true);

    final uri = Uri.parse('$baseUrl/uploadImage');
    final file = File(imageFile.path);
    if (!file.existsSync()) {
      return failed(Failure(title: "File not found"));
    }
    try {
      final request = http.MultipartRequest('post', uri);
      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // key must match backend
          imageFile.path,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        return success(data['imageUrl']);
      } else {
        final respStr = await response.stream.bytesToString();
        return failed(
          Failure(title: "Unable to upload image", description: respStr),
        );
      }
    } catch (e) {
      return failed(
        Failure(title: "Unable to upload image", description: e.toString()),
      );
    }
  }
}
