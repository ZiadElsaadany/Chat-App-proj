// import 'dart:io';
//
// import 'package:amir_chhat_app/core/extension/size_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../model/message_model.dart';
//
//
// class ImageMessageWidget extends StatelessWidget {
//   const ImageMessageWidget({
//     Key? key,
//     required this.messageModel,
//   }) : super(key: key);
//   final MessageModel messageModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return messageModel.unReadCount == 0
//         ? MyMessageWidget(
//             messageModel: messageModel,
//           )
//         : OtherMessageWidget(
//             messageModel: messageModel,
//           );
//   }
// }
//
// class MyMessageWidget extends StatelessWidget {
//   const MyMessageWidget({
//     Key? key,
//     required this.messageModel,
//   }) : super(key: key);
//   final MessageModel messageModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProfileProvider>(builder: (context, provider, _) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 constraints: BoxConstraints(maxWidth: 50.appWidth(context)),
//                 clipBehavior: Clip.antiAlias,
//                 child: Image.file(
//                   File(messageModel.message),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 messageModel.time,
//                 style: const TextStyle(
//                   color: AppColors.greyColor1,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }
//
// class OtherMessageWidget extends StatelessWidget {
//   const OtherMessageWidget({
//     Key? key,
//     required this.messageModel,
//   }) : super(key: key);
//   final MessageModel messageModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               constraints: BoxConstraints(maxWidth: 50.appWidth(context)),
//               clipBehavior: Clip.antiAlias,
//               child: Image.file(
//                 File(messageModel.message),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               messageModel.time,
//               style: const TextStyle(
//                 color: AppColors.greyColor1,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
