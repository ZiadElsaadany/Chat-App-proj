import 'package:amir_chhat_app/providers/chat/chat_provider.dart';
import 'package:amir_chhat_app/ui/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  runApp(MultiProvider(

      providers: [

        ChangeNotifierProvider.value(
          value: ChatProvider(),
        ),

      ],
      child:  AmirChatApp()));
}
