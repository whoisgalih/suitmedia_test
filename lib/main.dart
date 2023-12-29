import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/features/palindrome/presentation/pages/palindrome_page.dart';
import 'package:suitmedia_test/features/users_list/presentation/pages/user_list_page.dart';
import 'package:suitmedia_test/features/users_list/presentation/providers/user_list_provider.dart';
import 'package:suitmedia_test/features/welcome/presentation/providers/name_provider.dart';
import 'package:suitmedia_test/features/palindrome/presentation/providers/palindrome_provider.dart';
import 'package:suitmedia_test/features/welcome/presentation/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PalindromeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NameProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserListProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Suitmedia Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        initialRoute: PalindromePage.routeName,
        routes: {
          PalindromePage.routeName: (context) => const PalindromePage(),
          WelcomePage.routeName: (context) => const WelcomePage(),
          UserListPage.routeName: (context) => const UserListPage(),
        },
      ),
    );
  }
}
