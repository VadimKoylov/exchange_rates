import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_rates/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget {
  static Future<void> showErrorDialog(
    BuildContext context, {
    required Function() onRefresh,
  }) async {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.error,
          size: 50,
        ),
        const SizedBox(
          height: 15,
          width: 15,
        ),
        Text(
          "error".tr(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.black,
          ),
        )
      ],
    );
    if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            content: content,
            actions: [
              CupertinoButton(
                onPressed: () {
                  onRefresh();
                  Navigator.pop(context);
                },
                child: Text("refresh".tr()),
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 100),
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: content,
              actions: [
                TextButton(
                  onPressed: () {
                    onRefresh();
                    Navigator.pop(context);
                  },
                  child: Text("refresh".tr()),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
