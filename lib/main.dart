import 'package:amir_chhat_app/providers/chat_provider.dart';
import 'package:amir_chhat_app/ui/screens/chat/chat_overview_screen.dart';
import 'package:amir_chhat_app/ui/screens/chat/chat_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'firebase_options.dart';
import 'model/message_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox(
    AppConstants.myBox,
  );
  runApp(MultiProvider(

      providers: [

        ChangeNotifierProvider.value(
          value: ChatProvider(),
        ),

      ],
      child:   MaterialApp(
           home: ChatOverviewScreen()
           // ChatScreen(model: MessageModel(
           //   date: '',
           //   image: '',
           //   type: MessageType.text,
           //   id:"B8X2jzkOjOzbIKuW7ACu",
           //   message: '',
           //   unReadCount: 0,
           //   name: "ziad",
           // ),),
      )));
}
