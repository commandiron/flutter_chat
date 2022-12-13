import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      String email,
      String username,
      String password,
      File image,
      bool isLogin
  ) async {

    try{

      setState((){
        _isLoading = true;
      });

      UserCredential userCredential;

      if(isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password
        );
      } else {
        userCredential = await  _auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );

        final ref = FirebaseStorage
            .instance
            .ref()
            .child("user_image")
            .child(_auth.currentUser.uid + ".jpg");
        
        await ref.putFile(image).whenComplete(() {});

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user.uid)
            .set(
            {
              "username" : username,
              "email" : email,
              "image_url" : url
            }
        );
      }
      
    }on FirebaseAuthException catch(error){
      var message = "An error occurred, please check your credentials!";

      if(error.message != null) {
        message = error.message;
      }

      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(message))
      );

      setState((){
        _isLoading = false;
      });
    } catch(error) {
      print(error);
      setState((){
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(
        _submitAuthForm,
        _isLoading
      )
    );
  }
}
