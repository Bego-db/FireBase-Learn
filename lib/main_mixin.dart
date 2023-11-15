import 'package:fb_learn/future/home.dart';
import 'package:fb_learn/future/login_view.dart';
import 'package:flutter/material.dart';

mixin Routers {
  final Map<String, Widget Function(BuildContext)> pageRouters = {
    "/home": (context) =>  const HomePage(),
    "/login": (context) => const LoginView()
  };

}
