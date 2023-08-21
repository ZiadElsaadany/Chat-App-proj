import 'package:flutter/material.dart';

import '../../../../core/helper/app_helper.dart';
import '../../../../model/message_model.dart';
import 'my_message_item_widget.dart';
import 'other_message_item_widget.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return model.id == AppHelper.getUserId()
        ? MyMessageItemWidget(
            model: model,
          )
        : OtherMessageItemWidget(
            model: model,
          );
  }
}

// class MyMessageWidget extends StatelessWidget {
//   const MyMessageWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               constraints: BoxConstraints(maxWidth: 60.appWidth(context)),
//               //alignment:context.locale.languageCode=='ar'? Alignment.centerRight:Alignment.centerLeft,
//               padding: const EdgeInsets.all(12),
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(10),
//                   topLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(0),
//                   bottomLeft: Radius.circular(10),
//                 ),
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.blueColor1,
//                     AppColors.blueColor2,
//                   ],
//                 ),
//               ),
//               child: Text(
//                 'Message',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               'messageModel.time',
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
//
// class OtherMessageWidget extends StatelessWidget {
//   const OtherMessageWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               // width: (messageModel.message.length * 8) <=
//               //     (100.appWidth(context) - 139)
//               //     ? 24 + (messageModel.message.length * 8)
//               //     : 100.appWidth(context) - 115,
//               constraints: BoxConstraints(maxWidth: 60.appWidth(context)),
//               // alignment:context.locale.languageCode=='en'? Alignment.centerRight:Alignment.centerLeft,
//               padding: const EdgeInsets.all(12),
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(10),
//                     topLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                     bottomLeft: Radius.circular(0),
//                   ),
//                   color: AppColors.greyColor1),
//               child: Text(
//                 'Message',
//                 style: const TextStyle(
//                   color: AppColors.blackColor,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               'messageModel.time',
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
