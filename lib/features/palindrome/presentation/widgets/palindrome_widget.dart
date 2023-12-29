import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/features/palindrome/presentation/widgets/custom_button.dart';
import 'package:suitmedia_test/features/palindrome/presentation/widgets/custom_text_form_field.dart';
import 'package:suitmedia_test/features/welcome/presentation/providers/name_provider.dart';
import 'package:suitmedia_test/features/palindrome/presentation/providers/palindrome_provider.dart';

class PalindromeWidget extends StatelessWidget {
  const PalindromeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PalindromeProvider palindromeProvider =
        Provider.of<PalindromeProvider>(context, listen: false);
    NameProvider nameProvider = Provider.of<NameProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(58),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.person_add_alt_1_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            Form(
              key: nameProvider.formKey,
              child: CustomTextFormField(
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Name must not be empty";
                  }
                  return null;
                },
                controller: nameProvider.nameTextController,
                hintText: "Name",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              controller: palindromeProvider.palindromTextController,
              hintText: "Palindrome",
            ),
            const SizedBox(
              height: 48,
            ),
            CustomButton(
              text: "Check",
              onPressed: () {
                palindromeProvider.checkPalindrome(context);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
              text: "Next",
              onPressed: () {
                if (!nameProvider.formKey.currentState!.validate()) {
                  return;
                }
                nameProvider.name = nameProvider.nameTextController.text;
                nameProvider.nameTextController.clear();
                palindromeProvider.palindromTextController.clear();
                Navigator.pushNamed(context, '/welcome');
              },
            ),
          ],
        ),
      ),
    );
  }
}
