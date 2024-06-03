import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_buddy/state/cart.dart';
import 'package:food_buddy/views/home_page.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FoodBuddy());}

class FoodBuddy extends StatelessWidget {
  const FoodBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CartStore()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
