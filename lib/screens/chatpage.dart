import 'package:chat_messenger/services/chat/chat_service.dart';
import 'package:chat_messenger/widgets/chat_bubble.dart';
import 'package:chat_messenger/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatPage extends StatefulWidget {
  final String recieverName;
  final String recieverUserID;
  final String senderName;
  const ChatPage(
      {super.key,
      required this.recieverName,
      required this.recieverUserID,
      required this.senderName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        elevation: 5,
        shadowColor: Colors.black,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text(
          widget.recieverName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //messages
          Expanded(
            child: _buildMessageList(),
          ),

          Material(
            elevation: 10,
            child: Column(
              children: [
                _buildMessageInput(),
                const Gap(5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.recieverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // print(snapshot.data!.docs);
        return ListView(
          shrinkWrap: true,
          reverse: true,
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align message to the right if the sender is current user , otherwise left

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: data['senderId'] != _firebaseAuth.currentUser!.uid
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Text(
            data['senderId'] == _firebaseAuth.currentUser!.uid
                ? widget.senderName
                : widget.recieverName,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
          const Gap(2),
          ChatBubble(
            message: data['message'],
            leftOrRight: data['senderId'] != _firebaseAuth.currentUser!.uid,
          ),
        ],
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.18,
              // width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: CustomTextfield(
                  controller: _messageController,
                  hintext: "Enter your message",
                  obscureText: false,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              color: Colors.green,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
