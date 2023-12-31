
import 'package:amir_chhat_app/core/extension/size_extension.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../model/message_model.dart';
import '../../../../providers/chat_provider.dart';


class VoiceMessageWidget extends StatelessWidget {
  const VoiceMessageWidget({
    Key? key,
    required this.messageModel,
  }) : super(key: key);
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return messageModel.unReadCount == 0
        ? MyMessageWidget(
            messageModel: messageModel,
          )
        : OtherMessageWidget(
            messageModel: messageModel,
          );
  }
}

class MyMessageWidget extends StatefulWidget {
  const MyMessageWidget({
    Key? key,
    required this.messageModel,
  }) : super(key: key);
  final MessageModel messageModel;

  @override
  State<MyMessageWidget> createState() => _MyMessageWidgetState();
}

class _MyMessageWidgetState extends State<MyMessageWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }
  @override
  void initState() {
    super.initState();

    audioPlayer.setSourceDeviceFile(
      widget.messageModel.message,
    );
    setState(() {});
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
      setState(() {});
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        position = Duration.zero;
        isPlaying = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(n) => n.toString().padLeft(2, '0');
    String twoDigitsMin = twoDigits(isPlaying?position.inMinutes.remainder(60):duration.inMinutes.remainder(60));
    String twoDigitsSec = twoDigits(isPlaying?position.inSeconds.remainder(60):duration.inSeconds.remainder(60));
    return Consumer<ChatProvider>(builder: (context, provider, _) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width:100.appWidth(context)/2,
                height: 8.appHeight(context),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.yellowColor1,
                      AppColors.yellowColor2,
                    ],
                  ),
                ),
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              if (isPlaying) {
                                await audioPlayer.pause();
                              } else {
                                await audioPlayer.play(
                                  DeviceFileSource(
                                    widget.messageModel.message,
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: AppColors.whiteColor,
                              size: 30,

                            ),
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderThemeData(

                                overlayShape: SliderComponentShape.noThumb,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                              ),
                              child: Slider(
                                value: position.inSeconds.toDouble(),
                                min: 0.0,
                                max: duration.inSeconds.toDouble(),
                                onChanged: (value) async {
                                  final p = Duration(seconds: value.toInt());
                                  await audioPlayer.seek(p);
                                },
                                activeColor: AppColors.yellowColor1,
                                inactiveColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$twoDigitsMin:$twoDigitsSec',
                            style: const TextStyle(
                              color: AppColors.greyColor1,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(
              //   widget.messageModel.date.split("-")[0]+"-"+ widget.messageModel.date.split("-")[1]+ "-"+widget.messageModel.date.split("-")[2][0]+
              //       widget.messageModel.date.split("-")[2][1]
              //   ,
              //   style: const TextStyle(
              //     color: AppColors.blackColor,
              //     fontSize: 12,
              //   ),
              // ),
            ],
          ),
        ],
      );
    });
  }
}

class OtherMessageWidget extends StatefulWidget {
  const OtherMessageWidget({
    Key? key,
    required this.messageModel,
  }) : super(key: key);
  final MessageModel messageModel;

  @override
  State<OtherMessageWidget> createState() => _OtherMessageWidgetState();
}

class _OtherMessageWidgetState extends State<OtherMessageWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.setSourceDeviceFile(
      widget.messageModel.message,
    );
    setState(() {});
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
      setState(() {});
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        position = Duration.zero;
        isPlaying = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(n) => n.toString().padLeft(2, '0');
    String twoDigitsMin = twoDigits(isPlaying?position.inMinutes.remainder(60):duration.inMinutes.remainder(60));
    String twoDigitsSec = twoDigits(isPlaying?position.inSeconds.remainder(60):duration.inSeconds.remainder(60));
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100.appWidth(context) - 80,
              height: 70,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                ),
                color: AppColors.greyColor1,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            overlayShape: SliderComponentShape.noThumb,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ),
                          ),
                          child: Slider(
                            value: position.inSeconds.toDouble(),
                            min: 0.0,
                            max: duration.inSeconds.toDouble(),
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              await audioPlayer.seek(position);
                            },
                            activeColor: AppColors.yellowColor1,
                            inactiveColor: Colors.white70,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (isPlaying) {
                            await audioPlayer.pause();
                          } else {
                            await audioPlayer.play(
                              DeviceFileSource(
                                widget.messageModel.message,
                              ),
                            );
                          }
                        },
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: AppColors.yellowColor1,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$twoDigitsMin:$twoDigitsSec',
                        style: TextStyle(
                          color: AppColors.baseColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.messageModel.date,
              style: const TextStyle(
                color: AppColors.greyColor1,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
// import 'package:amir_chhat_app/model/message_model.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:record/record.dart';
//
// class VoiceMessageWidget extends StatefulWidget {
//    VoiceMessageWidget({Key? key, required this.messageModel, required this.audioPlayer, required this.record}) : super(key: key);
//
//   final MessageModel messageModel  ;
//   final AudioPlayer audioPlayer ;
//   final Record record;
//
//   @override
//   State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
// }
//
// class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
//
//   Future<void> playRecording( ) async {
//     try{
//       Source urlSource= UrlSource(widget.messageModel.message);
//       await widget.audioPlayer.play(urlSource);
//
//     } catch(e) {
//       debugPrint("error  when record playing $e");
//     }
//   }
//
// Duration duration  =    Duration();
//
//   Future<Duration?> getDuration( ) async {
//   duration =   (await widget.audioPlayer.getDuration())!;
//   }
//   @override
//   initState( ) {
//     super.initState();
//     widget.onDurationChanged.listen((event) {
//       setState(() {
//         duration = event;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     getDuration();
//     debugPrint(widget.messageModel.message);
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(duration.inMicroseconds.toString()),
//           ],
//         ),
//         GestureDetector(
//           onTap: (  ) {
//             playRecording() ;
//             },
//           child: Container(
//             child: Text("Record"),
//           ),
//         ),
//       ],
//     );
//   }
// }
