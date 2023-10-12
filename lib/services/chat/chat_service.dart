import 'package:chat_messenger/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //get instance of  auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String recieverUID, String messsage) async {
    //get user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      recieverId: recieverUID,
      message: messsage,
      timestamp: timestamp,
    );

    //construct a chatroom id from currentUser id and reciever id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, recieverUID];
    ids.sort(); //sort the ids( this ensure the chat room id is always same for any pair of people)

    String chatRoomId = ids.join("_"); //combine the ids

    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get message

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    //construct a chatroom id from currentUser id and reciever id (sorted to ensure uniqueness)
    List<String> ids = [userID, otherUserID];
    ids.sort(); //sort the ids( this ensure the chat room id is always same for any pair of people)
    String chatRoomId = ids.join("_");
    // print(
    //     "Data: ${_firestore.collection("chat_rooms").doc(chatRoomId).collection('messages').doc().snapshots()}");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .orderBy("timeStamp", descending: true)
        .snapshots();
  }
}
