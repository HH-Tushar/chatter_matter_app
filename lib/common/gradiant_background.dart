import 'package:flutter/cupertino.dart';

customGradientBackground({required Widget child}) {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          "assets/image/customGradiantBg.png",
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(child: SafeArea(child: child)),
    ],
  );
}

customGradientBackgroundWithSvg({required Widget child}) {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset("assets/image/primary_bg.png", fit: BoxFit.cover),
      ),
      Positioned.fill(child: SafeArea(child: child)),
    ],
  );
}
