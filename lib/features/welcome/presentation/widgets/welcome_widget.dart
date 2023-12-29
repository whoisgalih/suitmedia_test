import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/features/palindrome/presentation/widgets/custom_button.dart';
import 'package:suitmedia_test/features/users_list/business/entities/user_entity.dart';
import 'package:suitmedia_test/features/welcome/presentation/providers/name_provider.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final NameProvider nameProvider = Provider.of<NameProvider>(context);
    return Container(
      margin: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            nameProvider.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: Center(
              child: Text(
                nameProvider.userName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, "/user-list");
            },
            text: "Choose a User",
          )
        ],
      ),
    );
  }
}
