import 'package:flutter/material.dart';
import 'package:suitmedia_test/features/palindrome/presentation/widgets/palindrome_widget.dart';

class PalindromePage extends StatelessWidget {
  static const routeName = "/palindrome";

  const PalindromePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Image(
          image: AssetImage("assets/images/background@3x.png"),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: PalindromeWidget(),
          ),
        ),
      ],
    );
  }
}
