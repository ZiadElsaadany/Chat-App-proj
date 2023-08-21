import 'package:amir_chhat_app/model/message_model.dart';
import 'package:amir_chhat_app/ui/screens/chat/widgets/chat_top_bar_widget.dart';
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
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     Future.wait([
  //       Provider.of<ChatProvider>(context, listen: false)
  //           .loadAllConversations(),
  //       Provider.of<ChatProvider>(context, listen: false)
  //           .getTotalUnReadMessages(),
  //     ]);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ChatProvider>(builder: (context, provider, _) {
        // provider.chatsList.add(MessageModel(
        //     message: "ziad",
        //     date: "11111",
        //     image: "http://dobyisfree-001-site1.htempurl.com/uploads/My dream  20230428_135921.jpg",
        //     name: "ahmed",
        //     unReadCount: 3,
        //     type: MessageType.text,
        //     id: "6F5WmtO2Ryb00n9xWOXT"
        // ));
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
