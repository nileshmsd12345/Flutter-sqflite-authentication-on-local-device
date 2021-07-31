import 'package:flutter_sqflite_app/Util/network_util.dart';
import 'package:flutter_sqflite_app/Models/user.dart';

class RestData{

  NetworkUtil _netUtil = new NetworkUtil();
  // ignore: non_constant_identifier_names
  static final BASE_URL = "";
  // ignore: non_constant_identifier_names
  static final LOGIN_URL = BASE_URL +"/";


  Future<User?> login(String username, String password) async {
    return Future.value(User(username, password));
  }



}