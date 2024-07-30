import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'follow_button.dart';
class SearchUserScreen extends StatefulWidget {
  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  String _searchQuery = '';
  List<DocumentSnapshot> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchUsers() async {
    setState(() {
      _isLoading = true;
      _searchResults = [];
    });

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _searchQuery)
        .get();

    setState(() {
      _searchResults = querySnapshot.docs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search by email',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchUsers,
                ),
              ),
              onChanged: (value) {
                _searchQuery = value;
              },
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                  ? Center(child: Text('No results found'))
                  : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final user = _searchResults[index];
                  return ListTile(
                    title: Text(user['email'] ?? 'No Email'),
                    trailing: FollowButton(userIdToFollow: user.id),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}