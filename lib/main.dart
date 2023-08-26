import 'package:amir_chhat_app/providers/chat_provider.dart';
import 'package:amir_chhat_app/providers/completeAuth/complete_auth_providers.dart';
import 'package:amir_chhat_app/providers/notification_provider.dart';
import 'package:amir_chhat_app/ui/screens/chat/chat_overview_screen.dart';
import 'package:amir_chhat_app/ui/screens/complete_auth/basic_complete_auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/constants.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var fbm = FirebaseMessaging.instance;
  fbm.getToken().then((value) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('ChatAppTopic');
    } catch (e) {}
    print("=========================================");
    deviceToken = value;
    print(deviceToken);
    print("=========================================");
  });
  await Hive.initFlutter();
  await Hive.openBox(
    AppConstants.myBox,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(
      value: ChatProvider(),
    ),
    ChangeNotifierProvider.value(
      value: NotificationProvider(),
    ),
    ChangeNotifierProvider.value(
      value: CompleteAuthProvider(),
    ),
  ], child: const MaterialApp(home: BaseCompleteAuthScreen())));
}
