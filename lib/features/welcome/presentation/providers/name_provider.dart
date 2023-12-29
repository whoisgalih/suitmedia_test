import 'package:flutter/material.dart';
import 'package:suitmedia_test/features/users_list/business/entities/user_entity.dart';

class NameProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();

  String _name = "";

  String get name => _name;
  set name(String name) {
    _name = name;
    notifyListeners();
  }

  UserEntity? _user;

  set user(UserEntity? user) {
    _user = user;
    notifyListeners();
  }

  String get userName {
    if (_user != null) {
      return _user!.firstName + " " + _user!.lastName;
    } else {
      return "Please select user";
    }
  }
}
