import 'package:amir_chhat_app/model/message_model.dart';
import 'package:amir_chhat_app/ui/screens/chat/widgets/notification_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/empty_widget.dart';
import '../../../providers/chat_provider.dart';
import 'widgets/chat_item_widget.dart';

class ChatOverviewScreen extends StatefulWidget {
  const ChatOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ChatOverviewScreen> createState() => _ChatOverviewScreenState();
}

class _ChatOverviewScreenState extends State<ChatOverviewScreen> {
  @override
  void initState() {
    requestPermission();
    showDialogWhenNotificationSend();
    super.initState();
  }

  void showDialogWhenNotificationSend() {
    FirebaseMessaging.onMessage.listen((event) {
      showDialog(
          context: context,
          builder: (cxt) {
            return NotificationAlert(
                notificationBody: "${event.notification!.body}");
          });
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ChatProvider>(builder: (context, provider, _) {
        // provider.chatsList.add(MessageModel(
        //     message: "ziad",
        //     date: "11111",
        //     image:
        //         "https://firebasestorage.googleapis.com/v0/b/amir-chat-16dd2.appspot.com/o/images%2F05e94ec0-400e-11ee-b6ae-233fd0051ce7.jpg?alt=media&token=f11de607-a534-4c78-8d7b-90e1c8d76f49",
        //     name: "ahmed",
        //     unReadCount: 3,
        //     type: MessageType.text,
        //     id: "6F5WmtO2Ryb00n9xWOXT"));
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              provider.chatsList.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        itemBuilder: (ctx, index) => ChatItemWidget(
                          model: provider.chatsList[index],
                        ),
                        separatorBuilder: (ctx, index) => const Divider(),
                        itemCount: provider.chatsList.length,
                      ),
                    )
                  : const SizedBox(height: 100, child: EmptyWidget())
            ],
          ),
        );
      }),
    );
  }
}
