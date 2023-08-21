import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_images.dart';

class NotificationAlert extends StatefulWidget {
  const NotificationAlert({super.key, required this.notificationBody});
  final String notificationBody;
  @override
  State<NotificationAlert> createState() => _State();
}

class _State extends State<NotificationAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Image.asset(
                  AppImages.appLogo,
                  scale: 2.5,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              AppConstants.appName,
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(10),
      content: Text(widget.notificationBody),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              AppConstants.ok,
              style: TextStyle(color: Colors.purple),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              AppConstants.cancel,
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
