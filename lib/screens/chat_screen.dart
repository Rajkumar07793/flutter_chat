import 'package:flutter/material.dart';
import 'package:flutter_chat/models/message_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const String liveSocketUrl = "http://40.119.162.62:3000";
  static const String mySocketUrl = "http://localhost:4000";
  static const String mySocketUrl1 = "http://localhost:3000";
  static const String mySocketUrl2 = "https://api.rybitt.com/";
  static const String demoSocketUrl =
      "https://socketio-chat-h9jt.herokuapp.com";
  IO.Socket socket = IO.io(mySocketUrl);
  List<MessageData> messages = [
    MessageData(roomId: "123", message: "Hi", senderId: "ck", isMe: false),
    MessageData(
        roomId: "123",
        message: "This is luke sky walker from US",
        senderId: "ck",
        isMe: false),
  ];
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    socketConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat by socket"),
        actions: [
          IconButton(
              onPressed: () {
                socket.connect();
              },
              icon: const Icon(Icons.power_settings_new_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: (messages[index].isMe!)
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: width * 0.7),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: (messages[index].isMe!)
                                ? Colors.green
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          messages[index].message!,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message..."),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.teal[800]),
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          final message = MessageData(
                              roomId: "123",
                              message: _messageController.text,
                              senderId: "rk",
                              isMe: true);
                          setState(() {
                            messages.add(message);
                            _messageController.clear();
                          });
                          socket.emit("newChatMessage", [message]);
                        }
                      },
                      icon: const Icon(Icons.send)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void socketConfig() {
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('joinRoom', [
        {
          {'roomId': '123'}
        }
      ]);
    });
    socket.on('newChatMessage', (data) {
      setState(() {
        messages.add(data);
      });
    });
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }
}
