import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'follow_button.dart';

class FollowerScreen extends StatelessWidget {
  final String userId;

  const FollowerScreen({required this.userId, Key? key}) : super(key: key);

  Future<List<DocumentSnapshot>> _getFollowers() async {
    return (await FirebaseFirestore.instance
        .collection('followers')
        .where('follower_user_id', isEqualTo: userId)
        .get())
        .docs;
  }

  Future<List<DocumentSnapshot>> _getFollowing() async {
    return (await FirebaseFirestore.instance
        .collection('followers')
        .where('user_id', isEqualTo: userId)
        .get())
        .docs;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          if (currentUser != null && currentUser.uid != userId)
            FollowButton(userIdToFollow: userId),
          Text('Followers:'),
          FutureBuilder<List<DocumentSnapshot>>(
            future: _getFollowers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final followerData = snapshot.data?[index];
                  return ListTile(
                    title: Text(followerData?['user_id'] ?? 'Unknown'),
                  );
                },
              );
            },
          ),
          Text('Following:'),
          FutureBuilder<List<DocumentSnapshot>>(
            future: _getFollowing(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final followingData = snapshot.data?[index];
                  return ListTile(
                    title: Text(followingData?['follower_user_id'] ?? 'Unknown'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
