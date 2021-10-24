import 'package:flutter/material.dart';

class MessageData {
  String? socketId = "";
  String? roomId = "";
  String? message = "";
  String? senderId = "";
  bool? isMe = true;

  MessageData(
      {@required this.socketId,
      @required this.roomId,
      @required this.message,
      @required this.senderId,
      @required this.isMe});

  factory MessageData.fromJson(Map<String, dynamic> jsonData) {
    return MessageData(
      socketId: jsonData['socketId'],
      roomId: jsonData['roomId'],
      message: jsonData['message'],
      senderId: jsonData['senderId'],
      isMe: jsonData['isMe'],
    );
  }

  toJSONEncodable() {
    Map<String, dynamic> m = Map();
    m['socketId'] = socketId;
    m['roomId'] = roomId;
    m['message'] = message;
    m['senderId'] = senderId;
    m['isMe'] = isMe;
    return m;
  }
}
