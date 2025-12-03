import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget child) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => child));

animatedNavigateTo(BuildContext context, Widget child) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: Duration(milliseconds: 200), // Customize duration
    ),
  );
}

navigateReplaceAll(BuildContext context, Widget child) {
  return Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => child),
    (Route<dynamic> route) => false, // Removes all previous routes
  );
}

animatedNavigateReplaceAll(BuildContext context, Widget child) {
  return Navigator.of(context).pushAndRemoveUntil(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: Duration(milliseconds: 300),
    ),
    (Route<dynamic> route) => false,
  );
}

animatedNavigateReplace(BuildContext context, Widget child) {
  return Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: Duration(milliseconds: 300),
    ),
  );
}
