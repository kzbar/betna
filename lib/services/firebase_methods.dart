import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class FirebaseMethod<T> {
  static Future<void> update(
      {@required String? co, @required String? doc, dynamic value}) {
    try {
      return FirebaseFirestore.instance.collection(co!).doc(doc!).update(value);
    } catch (error) {
      print('FirebaseMethod update:${error.toString()}');
      rethrow;
    }
  }

  static Future add(
      {@required String? co, @required String? doc, dynamic value}) {
    try {
      return FirebaseFirestore.instance.collection(co!).doc(doc!).set(value);
    } catch (error) {
      print('FirebaseMethod add:${error.toString()}');
      rethrow;
    }
  }

  static Future delete({@required String? co, @required String? doc}) {
    try {
      return FirebaseFirestore.instance.collection(co!).doc(doc!).delete();
    } catch (error) {
      print('FirebaseMethod delete:${error.toString()}');
      rethrow;
    }
  }

  static Future get({@required String? co, @required String? doc}) {
    try {
      return FirebaseFirestore.instance.collection(co!).doc(doc!).get();
    } catch (error) {
      print('FirebaseMethod get:${error.toString()}');
      rethrow;
    }
  }

  static Future gets({@required String? co}) {
    try {
      return FirebaseFirestore.instance.collection(co!).get();
    } catch (error) {
      print('FirebaseMethod gets:${error.toString()}');
      rethrow;
    }
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> streams({@required String? co}) {
    try {
      return FirebaseFirestore.instance.collection(co!).snapshots();
    } catch (error) {
      print('FirebaseMethod streams:${error.toString()}');
      rethrow;
    }
  }

  static Stream stream({@required String? co, @required String? doc}) {
    try {
      return FirebaseFirestore.instance.collection(co!).doc(doc!).snapshots();
    } catch (error) {
      print('FirebaseMethod stream:${error.toString()}');
      rethrow;
    }
  }
}
