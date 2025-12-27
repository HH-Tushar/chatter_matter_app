import 'dart:io';

import 'package:chatter_matter_app/application/user/auth_bloc.dart';
import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_input.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:chatter_matter_app/common/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../common/gradiant_background.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  String name = "";

  final picker = ImagePicker();
  File? imageFile;
  Future<void> pickAndUploadImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;
    imageFile = File(picked.path);

    // print("Uploaded Image URL: $imageUrl");
  }

  void update() async {
    setState(() {
      isLoading = true;
    });

    final (data, error) = await Provider.of<UserBloc>(
      context,
      listen: false,
    ).updateProfile(name: name, image: imageFile);

    if (data != null && context.mounted) {
      showToast(context: context, title: data, toastType: ToastType.success);
      Navigator.pop(context);
    } else {
      showToast(
        context: context,
        title: error?.title ?? "",
        toastType: ToastType.failed,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = context.watch();
    final totalVisit = userBloc.profile?.totalVisited ?? 0;
    return Material(
      child: customGradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  primaryBackButton(context: context),
                  Text("Edit Profile", style: heading()),
                  hPad30,
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    vPad20,

                    InkWell(
                      onTap: () async => await pickAndUploadImage(),
                      child: CircleAvatar(radius: 50),
                    ),
                    vPad10,

                    Text("Full Name", style: titleSmall()),
                    customInput(
                      hintText: "Your Name",
                      initialValue: userBloc.profile?.name ?? "",
                      isEnable: !isLoading,
                      onChange: (e) {
                        name = e;
                      },
                    ),

                    Text("Email", style: titleSmall()),

                    customInput(
                      hintText: "Your Email",
                      initialValue: userBloc.profile!.email,
                      isEnable: false,
                      onChange: (e) {},
                    ),
                    vPad15,

                    vPad35,
                    customFilledButton(
                      title: "Save Update",
                      onTap: () => update(),
                      isLoading: isLoading,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
