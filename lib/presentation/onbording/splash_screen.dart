import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/user/auth_bloc.dart';
import '../../common/gradiant_background.dart';
import '../../common/navigator.dart';

import '../landing/landing_view.dart';
import 'start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUserState() async {
    Future.delayed(Duration(seconds: 1)).then((e) async {
      final check = await Provider.of<UserBloc>(
        context,
        listen: false,
      ).retrieveUser();
      if (check && context.mounted) {
        animatedNavigateReplaceAll(context, LandingView());
      } else if (check == false && context.mounted) {
        animatedNavigateReplaceAll(context, StartScreen());
      }
    });
  }

  @override
  void initState() {
    checkUserState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: customGradientBackground(
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(child: Image.asset("assets/image/brand_logo.png")),
            ),

            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
