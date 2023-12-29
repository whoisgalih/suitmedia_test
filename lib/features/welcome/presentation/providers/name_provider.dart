import 'package:flutter/material.dart';

class NameProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();

  String _name = "";

  String get name => _name;
  set name(String name) {
    _name = name;
    notifyListeners();
  }
}
