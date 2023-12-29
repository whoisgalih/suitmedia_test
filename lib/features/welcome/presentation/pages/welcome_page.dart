import 'package:flutter/material.dart';
import 'package:suitmedia_test/features/welcome/presentation/widgets/welcome_widget.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = "/welcome";

  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: const Center(
        child: WelcomeWidget(),
      ),
    );
  }
}
