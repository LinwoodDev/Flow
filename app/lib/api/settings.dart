import 'dart:ui';

import 'package:flow/pages/settings/home.dart';
import 'package:flutter/material.dart';

Future<void> openSettings(BuildContext context) => showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          ScaffoldMessenger(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 800, maxWidth: 1000),
                  child: const SettingsPage(isDialog: true))),
        ),
      ),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Animate the dialog from bottom to center
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
          child: child,
        );
      },
    );
