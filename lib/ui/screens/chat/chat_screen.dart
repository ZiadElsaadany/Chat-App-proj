import 'dart:io';

import 'package:amir_chhat_app/core/extension/context_extention.dart';
import 'package:amir_chhat_app/core/extension/size_extension.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/shared/empty_widget.dart';
import '../../../core/shared/loading_widget.dart';
import '../../../model/message_model.dart';
import '../../../providers/chat_provider.dart';
import 'widgets/text_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.model, required this.id,
  }) : super(key: key);
  final MessageModel model;
  final String id  ;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>  {


late AudioPlayer audioPlayer ;
late Record record  ;



  @override
  void initState() {
    audioPlayer = AudioPlayer();
    record = Record();
    super.initState();

    Future.delayed(Duration.zero, () async {
      Provider.of<ChatProvider>(context, listen: false).singleChatListener(
        widget.model.id,
      );
      await Provider.of<ChatProvider>(context, listen: false).resetUnReadCount(
        widget.model.id,
      );
    });
  }
  @override
  void dispose() {
audioPlayer.stop();
record.stop();
    super.dispose();
  }


  bool isRecording  = false;

  Future<void> startRecording( ) async {
    try{
      if(await record.hasPermission()) {
        await record.start();
        setState(() {
           isRecording  = true;
        });
      }

    } catch(e) {
      debugPrint("error  when record starting $e");
    }
  }



  String audioPath= "";
  Future<void> stopRecording( ) async {
    try{
      String? path = await record.stop();
      if(await record.hasPermission()) {
        setState(() {
           isRecording  = false;
           audioPath = path!;
           debugPrint("path is ${audioPath}");

           if(audioPath.isNotEmpty) {
             uploadRecord();
           }
        });
      }

    } catch(e) {
      debugPrint("error  when record Stop $e");
    }
  }





  final TextEditingController messageController = TextEditingController();

  File? imageFile;

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = const Uuid().v1();

    var re =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var upload = await re.putFile(imageFile!).catchError((error) {});


    String imageUrl = await upload.ref.getDownloadURL();

   if(context.mounted
    ){
     Provider.of<ChatProvider>(context,listen: false).sendMessage(
         MessageModel(message: imageUrl,
           date: DateTime.now().toIso8601String(),
           image: widget.model.image,
           name: widget.model.name,
           unReadCount: 0,
           type: MessageType.image,
           id: widget.model.id,
         ));
   }
    debugPrint(imageUrl);
  }

  Future uploadRecord() async {
    String fileName = const Uuid().v4();

    var re =
        FirebaseStorage.instance.ref().child('audios').child("$fileName.mpeg");

    var upload = await re.putFile(File(audioPath)).catchError((error) {});


    String audio = await upload.ref.getDownloadURL();

   if(context.mounted){
     Provider.of<ChatProvider>(context,listen: false).sendMessage(
         MessageModel(message: audio,
           date: DateTime.now().toIso8601String(),
           image: widget.model.image,
           name: widget.model.name,
           unReadCount: 0,
           type: MessageType.audio,
           id: widget.model.id,
         ));
   }
  }





  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          await provider.resetUnReadCount(
            widget.model.id,
          );
          if (provider.chatEmoji == true) {
            provider.changeChatEmojiPicker(false);
          }
          return true;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            provider.changeChatEmojiPicker(false);
          },
          child: Scaffold(
            backgroundColor:AppColors.whiteColor,
            appBar: AppBar(
              backgroundColor:Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () async {
                  context.pop();

                  await provider.resetUnReadCount(
                    widget.model.id,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackColor,
                ),
              ),
              centerTitle: true,
              titleSpacing: 0,
              title: Text(
                widget.model.name,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: provider.messagesMap[widget.model.id]== null ||
                          provider.messagesMap[widget.model.id]!.isEmpty
                      ?
                      Center(
                          child: provider.getMessagesLoading
                              ? const LoadingWidget()
                              : const EmptyWidget(),
                        ): Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: ListView.separated(
                      reverse: true,
                      itemBuilder: (ctx, index) =>

                          TextMessageWidget(
                            record: record,
                            audioPlayer: audioPlayer,
                            model: provider.messagesMap[widget.model.id]![
                            provider.messagesMap[widget.model.id]!
                                .length -
                                1 -
                                index],
                          ),
                      separatorBuilder: (ctx, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount:
                      provider.messagesMap[widget.model.id]!.length,
                    ),
                  ),
                ),
                Container(
                  height: 9.appHeight(context),
                  color: AppColors.whiteColor,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),


                      Expanded(
                        child: Container(

                          height: 6.appHeight(context),
                          alignment: Alignment.center,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.only(
                            left: 6,
                            right: 6,
                          ),
                          child: TextField(
                            onChanged: ( v ) {
                              setState(() {});
                            } ,
                            maxLines: 5,
                            minLines: 1,
                            onTap: () {
                              provider.changeChatEmojiPicker(false);
                            },
                            controller: messageController,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            scrollPadding: const EdgeInsets.all(0),
                            decoration: InputDecoration(
                              fillColor: AppColors.greyColor1,
                              filled: true,

                              suffixIcon: IconButton(
                                onPressed: () {
                                  getImage();
                                },
                                icon: const Icon(Icons.photo,
                                color: AppColors.blackColor,
                                ),
                              ),
                              hintStyle: const TextStyle(
                                fontSize: 12,
                              ),
                              prefixIcon:  GestureDetector(
                                  onTap: ( ){
                                    provider
                                        .changeChatEmojiPicker(!provider.chatEmoji);
                                    FocusScope.of(context).unfocus();
                                  }
                                  ,child: const Icon(Icons.emoji_emotions_outlined,
                                color: AppColors.blackColor,

                              )),
                              hintText: isRecording? "Recording...": "Write a message",
                              contentPadding: const EdgeInsets.all(10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      messageController.text.isEmpty? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0),
                        child: GestureDetector(
      onLongPress:startRecording,
      onLongPressEnd: (details) {
      stopRecording();
      },
      child:  Icon(Icons.mic,

      color: isRecording ? AppColors.yellowColor1: Colors.black ,
      size: isRecording ? 40: 30,
      )),
                      )  :

                      TextButton(
                        style:


                        ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        onPressed: ()  {
                            if (messageController.text.isNotEmpty) {
                              provider
                                  .sendMessage(
                                MessageModel(
                                  message: messageController.text,
                                  date: DateTime.now().toIso8601String(),
                                  image: widget.model.image,
                                  name: widget.model.name,
                                  unReadCount: 0,
                                  type: MessageType.text,
                                  id: widget.model.id,
                                ),
                              )
                                  .then((value) {
                                messageController.clear();
                                FocusScope.of(context).unfocus();
                                provider.changeChatEmojiPicker(false);
                              });
                          if(provider.sendMessageLoading)  {
                          provider.messagesMap.addAll({
                       //
                       // widget.id:
                       //    provider.MessageModel(
                       //    message: messageController.text,
                       //    date: DateTime.now().toIso8601String(),
                       //    image: widget.model.image,
                       //    name: widget.model.name,
                       //    unReadCount: 0,
                       //    type: MessageType.text,
                       //    id: widget.model.id,
                       //    ),

                          });
                          }
                            }
                          },child: const Icon(
                          Icons.send,
                          color: AppColors.yellowColor1,
                        ),
                      ),
                    ],
                  ),
                ),
                if (provider.chatEmoji)
                  SizedBox(
                    height: 35.appHeight(context),
                    child: EmojiPicker(
                      textEditingController: messageController,
                      config: Config(
                        bgColor: const Color.fromARGB(255, 234, 248, 255),
                        columns: 7,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}



// class VoiceChatRecorder extends StatefulWidget {
//   @override
//   _VoiceChatRecorderState createState() => _VoiceChatRecorderState();
// }
//
// class _VoiceChatRecorderState extends State<VoiceChatRecorder> {
//   late AudioPlayer audioPlayer;
//   late String filePath;
//
//   @override
//   void initState() {
//     super.initState();
//     audioPlayer = AudioPlayer();
//   }
//
//   Future<void> startRecording() async {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appDocPath = appDocDir.path;
//     filePath = '$appDocPath/voice_message.wav';
//
//     await audioPlayer.startRecorder(toFile: filePath, codec: Codec.pcm16WAV);
//   }
//
//   Future<void> stopRecording() async {
//     await audioPlayer.stopRecorder();
//   }
//
//   Future<void> playRecordedAudio() async {
//     await audioPlayer.play(filePath, isLocal: true);
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Voice Chat Recorder'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: startRecording,
//               child: Text('Start Recording'),
//             ),
//             ElevatedButton(
//               onPressed: stopRecording,
//               child: Text('Stop Recording'),
//             ),
//             ElevatedButton(
//               onPressed: playRecordedAudio,
//               child: Text('Play Recorded Audio'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
