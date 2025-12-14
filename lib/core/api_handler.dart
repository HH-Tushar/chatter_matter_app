import 'package:flutter/foundation.dart';

/// A wrapper to return a value or a [Failure]
typedef Attempt<T> = (T?, Failure?);

/// Return a [Attempt] with value set to null and the Failure set to `Failure`
Attempt<T> failed<T>(Failure failure) => (null, failure);

/// Return a [Attempt] with value set to `value` and the Failure set to null
Attempt<T> success<T>(T value) => (value, null);

/// An universal type to represent Failures. the [code] property can be used
///
/// to pass language agnostic Failure codes that can be then used
///
///  to map Failure messages on the presentation side
@immutable
class Failure<C extends Object> {
  const Failure({this.title, this.description, this.code});
  final String? title;
  final String? description;
  final C? code;
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure()
    : super(
        title: "Server Failure",
        description: "Please wait or try again latter.",
      );
}

class InternetFailure extends Failure {
  const InternetFailure()
    : super(
        title: "No internet connection",
        description: "Please reconnect to internet and try again.",
      );
}

// session Expired failures
class SessionExpired extends Failure {
  const SessionExpired()
    : super(
        title: 'Session Expired',
        description: "Please log in again !",
        code: 401,
      );
}

dPrint(String e) {
  if (kDebugMode) {
    debugPrint('A useful message');
  }
}



// session Expired failures
class UnauthorizeAccess extends Failure {
  const UnauthorizeAccess()
    : super(
        title: 'Unauthorize access',
        description: "Please log in again !",
        code: 403,
      );
}
