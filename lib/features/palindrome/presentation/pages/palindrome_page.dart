import 'package:flutter/material.dart';
import 'package:suitmedia_test/features/palindrome/presentation/widgets/palindrome_widget.dart';

class PalindromePage extends StatelessWidget {
  static const routeName = "/palindrome";

  const PalindromePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: PalindromeWidget(),
      ),
    );
  }
}
