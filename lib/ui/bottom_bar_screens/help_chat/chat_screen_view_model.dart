import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenViewModel extends ChangeNotifier {
  ChatScreenViewModel() {
    messageController.addListener(() {
      toggleFAB();
      toggleIcons();
    });
    scrollController.addListener(() => toggleFAB());
    initialBottomPosition();
  }

  var message = '';
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  final db = FirebaseFirestore.instance;
  var isTextEmpty = true;
  var floatingAB = false;

  void toggleFAB() {
    if (scrollController.position.atEdge && scrollController.offset == 0 ||
        messageController.text.length > 20) {
      floatingAB = false;
      notifyListeners();
    } else {
      floatingAB = true;
      notifyListeners();
    }
  }

  void toggleIcons() {
    if (messageController.text.trim().isNotEmpty) {
      isTextEmpty = false;
      notifyListeners();
    } else {
      isTextEmpty = true;
      notifyListeners();
    }
  }

  final Stream<QuerySnapshot> messagesStream = FirebaseFirestore.instance
      .collection('chatWithMyFriend')
      .orderBy('timestamp')
      .snapshots();

  final timeStamp = DateTime.now().toString().substring(10, 16);

  void saveMessage(BuildContext context) {
    if (message.trim().isEmpty) return;
    final chatMessage = <String, dynamic>{
      "message": message.trim(),
      "time": timeStamp,
      "timestamp": DateTime.now(),
      "uID": 1,
    };
    db.collection("chatWithMyFriend").add(chatMessage);
    messageController.clear();
    scrollToBottom();
  }

  void saveMyFriendsMessage(BuildContext context) {
    if (message.trim().isEmpty) return;
    final chatMessage = <String, dynamic>{
      "message": message.trim(),
      "time": timeStamp,
      "timestamp": DateTime.now(),
      "uID": 0,
    };
    db.collection("chatWithMyFriend").add(chatMessage);
    messageController.clear();
    scrollToBottom();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      notifyListeners();
    } else {
      Timer(const Duration(), () => scrollToBottom());
    }
  }

  void initialBottomPosition() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      notifyListeners();
    } else {
      Timer(const Duration(), () => initialBottomPosition());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
