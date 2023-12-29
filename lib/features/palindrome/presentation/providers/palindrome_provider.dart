import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PalindromeProvider extends ChangeNotifier {
  TextEditingController palindromTextController = TextEditingController();

  bool isPalindrome(String text) {
    final String reversedText = text.split('').reversed.join();
    return text == reversedText;
  }

  void checkPalindrome(BuildContext context) {
    final String palindrome = palindromTextController.text;
    final bool isPalindrome = this.isPalindrome(palindrome);

    final String title = isPalindrome ? "Palindrome" : "Not Palindrome";
    final String content =
        "'$palindrome' is ${isPalindrome ? "" : "not "}palindrome";

    showDialog(
      context: context,
      builder: (context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
      },
    );
  }
}
