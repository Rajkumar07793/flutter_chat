import 'package:flutter/material.dart';

class MessageData {
  String? roomId = "";
  String? message = "";
  String? senderId = "";
  bool? isMe = true;

  MessageData(
      {@required this.roomId,
      @required this.message,
      @required this.senderId,
      @required this.isMe});
}
