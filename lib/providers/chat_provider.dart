import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/constants/app_constants.dart';
import '../core/helper/app_helper.dart';
import '../model/message_model.dart';
import '../model/send_message_model.dart';
import '../model/user_model.dart';


class ChatProvider extends ChangeNotifier {
  List<MessageModel> chatsList = [];
  Map<String, List<MessageModel>> messagesMap = {};

  void chatsListener() {
    try {
      FirebaseFirestore.instance
          .collection(
            AppConstants.chatsCollection,
          )
          .doc(AppHelper.getUserId())
          .snapshots()
          .listen((event) {
        if (event.data() != null) {
          if (event.data()![AppConstants.chatsCollection] != null) {
            chatsList = [];
            final chatsMap = event.data()![AppConstants.chatsCollection] as Map;

            chatsMap.forEach((key, value) {
              chatsList.add(MessageModel.fromJson(value));
            });
            chatsList.sort(
              (a, b) => a.date.compareTo(
                b.date,
              ),
            );
            notifyListeners();
          }
        }
      });
    } on SocketException {
      chatsListener();
    } catch (e) {
      chatsListener();
    }
  }

  bool getMessagesLoading = false;

  void singleChatListener(String id) {
    getMessagesLoading = true;
    notifyListeners();
    try {
      String doc = '';

      if (id.compareTo(AppHelper.getUserId()) == -1) {
        doc = '$id+${AppHelper.getUserId()}';
      } else {
        doc = '${AppHelper.getUserId()}+$id';
      }
      FirebaseFirestore.instance
          .collection(
            AppConstants.messagesCollection,
          )
          .doc(doc)
          .snapshots()
          .listen((event) {
        if (event.data() != null) {
          if (event.data()![AppConstants.messagesCollection] != null) {
            messagesMap[id] = [];
            final messagesList =
                event.data()![AppConstants.messagesCollection] as List;

            for (var value in messagesList) {
              messagesMap[id]!.add(
                MessageModel.fromJson(value),
              );
            }
          }
        }
      });
    } on SocketException {
      singleChatListener(id);
    } catch (e) {
      singleChatListener(id);
    }
    getMessagesLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(MessageModel model) async {
    try {
      final UserModel userModel = UserModel.fromJson(AppHelper.getUserModel());

      String doc = '';

      if (model.id.compareTo(userModel.id) == -1) {
        doc = '${model.id}+${userModel.id}';
      } else {
        doc = '${userModel.id}+${model.id}';
      }
      List messages = ((await FirebaseFirestore.instance
                      .collection(
                        AppConstants.messagesCollection,
                      )
                      .doc(doc)
                      .get())
                  .data() ??
              {})[AppConstants.messagesCollection] ??
          [];

      messages.add(
        SendMessageModel(
          message: model.message,
          date: DateTime.now().toIso8601String(),
          type:model.type== MessageType.image?  MessageType.image:
          model.type ==MessageType.audio ? MessageType.audio :
          MessageType.text,
          id: userModel.id,
        ).toJson(),
      );
      await FirebaseFirestore.instance
          .collection(
            AppConstants.messagesCollection,
          )
          .doc(doc)
          .set({
        AppConstants.messagesCollection: messages,
      });
      final data = (await FirebaseFirestore.instance
              .collection(
                AppConstants.chatsCollection,
              )
              .doc(AppHelper.getUserId())
              .get())
          .data();

      Map<String, dynamic> chats = {};
      if (data != null && data[AppConstants.chatsCollection] != null) {
        chats = data[AppConstants.chatsCollection] as Map<String, dynamic>;
      }
      chats.addAll(
        {
          model.id: model.toJson(),
        },
      );
      await FirebaseFirestore.instance
          .collection(
            AppConstants.chatsCollection,
          )
          .doc(AppHelper.getUserId())
          .set(
        {
          AppConstants.chatsCollection: chats,
        },
      );
      final receiverData = (await FirebaseFirestore.instance
              .collection(
                AppConstants.chatsCollection,
              )
              .doc(model.id)
              .get())
          .data();

      Map<String, dynamic> receiverChats = {};

      int receiverUnreadCount = 0;
      if (receiverData != null &&
          receiverData[AppConstants.chatsCollection] != null) {
        receiverChats =
            receiverData[AppConstants.chatsCollection] as Map<String, dynamic>;

        if (receiverChats[AppHelper.getUserId()] != null) {
          receiverUnreadCount =
              receiverChats[AppHelper.getUserId()]['unReadCount'] ?? 0;
        }
      }
      receiverUnreadCount++;
      receiverChats.addAll(
        {
          userModel.id: MessageModel(
            unReadCount: receiverUnreadCount,
            name: userModel.name,
            message: model.message,
            id: userModel.id,
            type: MessageType.text,
            image: userModel.photo,
            date: DateTime.now().toIso8601String(),
          ).toJson(),
        },
      );
      await FirebaseFirestore.instance
          .collection(
            AppConstants.chatsCollection,
          )
          .doc(model.id)
          .set(
        {
          AppConstants.chatsCollection: receiverChats,
        },
      );
    } on SocketException {
    } catch (e) {}
    notifyListeners();
  }

  Future<void> resetUnReadCount(String id) async {
    try {
      final data = ((await FirebaseFirestore.instance
                      .collection(
                        AppConstants.chatsCollection,
                      )
                      .doc(AppHelper.getUserId())
                      .get())
                  .data() ??
              {})[AppConstants.chatsCollection] ??
          {};

      if (data.isNotEmpty && data[id] != null) {
        data[id]['unReadCount'] = 0;

        await FirebaseFirestore.instance
            .collection(
              AppConstants.chatsCollection,
            )
            .doc(AppHelper.getUserId())
            .set({
          AppConstants.chatsCollection: data,
        });
      }
    } on SocketException {
    } catch (e) {}
    notifyListeners();
  }


  bool chatEmoji = false;
  changeChatEmojiPicker(bool b)  {
    chatEmoji= b ;
    notifyListeners();
  }
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }
}
