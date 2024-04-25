import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/ui/bottom_bar_screens/help_chat/chat_screen_view_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatScreenViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 109, 230),
        foregroundColor: Colors.black,
        title: const _AppBarTitleWidget(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: const _MessagesWidget(),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 50,
            right: 10,
            child: model.floatingAB
                ? FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromARGB(255, 169, 192, 235),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () => model.scrollToBottom(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _AppBarTitleWidget extends StatelessWidget {
  const _AppBarTitleWidget();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          height: 45,
          width: 45,
          child: Image(image: AppImages.marcy),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Helper', style: TextStyle(fontSize: 20)),
            Text('Marcy', style: TextStyle(fontSize: 15)),
          ],
        ),
      ],
    );
  }
}

class _MessagesWidget extends StatelessWidget {
  const _MessagesWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChatScreenViewModel>();
    return Column(
      children: [
        Expanded(
          child: ColoredBox(
            color: const Color.fromARGB(255, 195, 203, 240),
            child: StreamBuilder<QuerySnapshot>(
                stream: model.messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Something went wrong, try again later'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Loading...", style: TextStyle(fontSize: 24)),
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()),
                        ],
                      ),
                    );
                  }

                  final data = snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return data;
                      })
                      .toList()
                      .reversed
                      .toList();

                  return ListView.builder(
                      reverse: true,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      controller: model.scrollController,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var me = data[index]['uID'] == 1;
                        const radius = Radius.circular(18);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: me
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: me
                                      ? const Color.fromARGB(255, 155, 167, 227)
                                      : const Color.fromARGB(
                                          255, 221, 225, 239),
                                  borderRadius: BorderRadius.only(
                                    topLeft: radius,
                                    topRight: radius,
                                    bottomLeft: me ? radius : Radius.zero,
                                    bottomRight: me ? Radius.zero : radius,
                                  )),
                              child: Stack(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth:
                                                  MediaQuery.sizeOf(context)
                                                          .width -
                                                      100),
                                          child: Text(
                                            data[index]['message'],
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 68, 68, 68)),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    bottom: 3,
                                    child: Text(
                                      data[index]['time'].toString(),
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ),
        const _TextFieldAndActionsWidget(),
      ],
    );
  }
}

class _TextFieldAndActionsWidget extends StatelessWidget {
  const _TextFieldAndActionsWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChatScreenViewModel>();
    return ColoredBox(
      color: const Color.fromARGB(255, 167, 180, 241),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.sentiment_satisfied_alt_outlined,
                color: Color.fromARGB(255, 68, 68, 68),
              )),
          Expanded(
            child: TextField(
              controller: model.messageController,
              minLines: 1,
              maxLines: 6,
              style: const TextStyle(
                  color: Colors.black, decorationColor: Colors.black),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Message',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 68, 68, 68),
                  )),
              onChanged: (value) => model.message = value,
            ),
          ),
          IconButton(
            onPressed: () => model.saveMyFriendsMessage(context),
            icon: const Icon(
              Icons.attach_file,
              color: Color.fromARGB(255, 68, 68, 68),
            ),
          ),
          const _MicOrSendIcon(),
        ],
      ),
    );
  }
}

class _MicOrSendIcon extends StatelessWidget {
  const _MicOrSendIcon();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatScreenViewModel>();
    return model.messageController.text.trim().isEmpty
        ? IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mic,
              color: Color.fromARGB(255, 68, 68, 68),
            ))
        : IconButton(
            onPressed: () => model.saveMessage(context),
            icon: const Icon(
              Icons.send,
              color: Color.fromARGB(255, 68, 68, 68),
            ));
  }
}
