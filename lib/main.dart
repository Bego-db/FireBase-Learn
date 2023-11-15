import 'package:fb_learn/future/login_view.dart';
import 'package:fb_learn/main_mixin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget with Routers {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: pageRouters,
      debugShowCheckedModeBanner: false,
      title: 'FireBase Learn',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const LoginView(),
    );
  }
}
