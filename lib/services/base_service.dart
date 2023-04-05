



import 'package:betna/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseService{
  Future<Map<String,dynamic>?> getUser({String? id});
  Future<User?> signInWithEmail({String? email,String? password});

}
class Services implements BaseService {
  late BaseService serviceApi;

  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();

  void setAppConfig() {
    serviceApi = FireBaseServices();
  }

  @override
  Future<Map<String,dynamic>?> getUser({String? id}) {
    return serviceApi.getUser(id: id);
  }

  @override
  Future<User?> signInWithEmail({String? email, String? password}) {
    return serviceApi.signInWithEmail(email: email,password: password);
  }
}