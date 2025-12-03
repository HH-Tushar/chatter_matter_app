import 'package:flutter/material.dart';
import '/common/colors.dart';

enum ToastType { success, failed, warning }

showToast({
  required BuildContext context,
  required String title,
  required ToastType toastType,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: toastType == ToastType.success
          ? customGreen
          : toastType == ToastType.warning
          ? customWarning
          : customRed,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    ),
  );
}

// void showGlobalOverlayToast({
//   required BuildContext context,
//   required String message,
//   required ToastType type,
//   Duration duration = const Duration(seconds: 3),
// }) {
//   final overlay = Overlay.of(context, rootOverlay: true);

//   final overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: 60,
//       left: 10,
//       right: 10,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: type == ToastType.success
//                 ? customGray
//                 : type == ToastType.failed
//                 ? customRed
//                 : Colors.amber,
//             borderRadius: BorderRadius.circular(8),
//             // boxShadow: [
//             //   BoxShadow(
//             //     color: Colors.black26,
//             //     blurRadius: 10,
//             //     offset: Offset(0, 4),
//             //   ),
//             // ],
//           ),
//           child: Text(
//             message,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontFamily: 'Outfit',
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.start,
//           ),
//         ),
//       ),
//     ),
//   );

//   overlay.insert(overlayEntry);

//   Future.delayed(duration, () {
//     overlayEntry.remove();
//   });
// }
