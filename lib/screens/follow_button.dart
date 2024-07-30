import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FollowButton extends StatefulWidget {
  final String userIdToFollow;

  const FollowButton({required this.userIdToFollow, Key? key}) : super(key: key);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _checkIfFollowing();
  }

  Future<void> _checkIfFollowing() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('followers')
          .doc('${currentUser.uid}_${widget.userIdToFollow}')
          .get();
      setState(() {
        _isFollowing = doc.exists;
      });
    }
  }

  Future<void> _toggleFollow() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final docRef = FirebaseFirestore.instance
          .collection('followers')
          .doc('${currentUser.uid}_${widget.userIdToFollow}');
      if (_isFollowing) {
        await docRef.delete();
      } else {
        await docRef.set({
          'user_id': widget.userIdToFollow,
          'follower_user_id': currentUser.uid,
          'created_at': Timestamp.now(),
        });
      }
      setState(() {
        _isFollowing = !_isFollowing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleFollow,
      child: Text(_isFollowing ? 'Unfollow' : 'Follow'),
    );
  }
}
