

import 'dart:async';

import 'package:betna/services/base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseServices implements BaseService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Map<String,dynamic>?> getUser({String? id}) async {
    try{
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('app_user').doc(id).get();
      return documentSnapshot.data() as FutureOr<Map<String, dynamic>?>;
    }catch(error){
      print(error.toString());
      rethrow;
    }
  }

  @override
  Future<User?> signInWithEmail({String? email, String? password}) async {
    try{
      User? firebase =(await _auth.signInWithEmailAndPassword(email: email!, password: password!)).user;
      return firebase;
    }catch(error){
      rethrow;
    }
  }

}