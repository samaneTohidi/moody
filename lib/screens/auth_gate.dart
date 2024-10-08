import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> _createUserInFirestore(User user) async {
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      final userModel = UserModel(
        userId: user.uid,
        email: user.email ?? '',
        passwordHash: '',
        profilePictureUrl: user.photoURL ?? '',
        emotionalStatus: '🙂',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );
      await userDoc.set(userModel.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return SignInScreen(
              providers: [
                EmailAuthProvider(),
                GoogleProvider(
                    clientId:
                        "451529797130-iqn6nnm27boujo3hjh2fluq1dimbm2re.apps.googleusercontent.com"),
              ],
              headerBuilder: (context, constraints, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  // child: AspectRatio(
                  //   aspectRatio: 1,
                  //   child: Image.asset('flutterfire_300x.png'),
                  // ),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: action == AuthAction.signIn
                      ? const Text('Welcome to FlutterFire, please sign in!')
                      : const Text('Welcome to Flutterfire, please sign up!'),
                );
              },
              footerBuilder: (context, action) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'By signing in, you agree to our terms and conditions.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
              sideBuilder: (context, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  // child: AspectRatio(
                  //   aspectRatio: 1,
                  //   child: Image.asset('flutterfire_300x.png'),
                  // ),
                );
              },
            );
          } else {
            _createUserInFirestore(user);
            return HomeScreen(user: user);
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

typedef HeaderBuilder = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
  double shrinkOffset,
);
