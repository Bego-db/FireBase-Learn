import 'package:fb_learn/core/const/string_constant.dart';
import 'package:fb_learn/core/extension/project_extension.dart';
import 'package:fb_learn/product/firebase/auth_services.dart';

import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  final PageController pageController;
  const RegisterView({super.key, required this.pageController});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usernameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  AuthService auth = AuthService();
  late String email, password;
  bool isload = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: context.horizontal20,
          child: Form(
            key: _formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.person_add,
                size: 150,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "E-mail", suffix: Icon(Icons.mail)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Bilgileri Eksiksiz Doldurun";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  email = newValue!;
                },
              ),
              Padding(
                padding: context.vertical,
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Şifre", suffix: Icon(Icons.password)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return StringConstant.validate;
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue!.length > 6) {
                      password = newValue;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Şifre en az 6 Karekter olmalı")));
                      setState(() {
                        isload = false;
                      });
                    }
                  },
                ),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    hintText: "Kullanıcı Adı", suffix: Icon(Icons.person)),
              ),
              Padding(
                padding: context.vertical,
                child: ElevatedButton(
                    onPressed: createUser,
                    child: isload
                        ? const CircularProgressIndicator()
                        : const Text(StringConstant.signIn)),
              ),
              TextButton(
                  onPressed: () {
                    widget.pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chevron_left),
                      Text(StringConstant.login),
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  void createUser() async {
    final snacbar = ScaffoldMessenger.of(context);
    setState(() {
      isload = true;
    });
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final res = await auth.createUserWithEmailPassword(email, password);
      if (res == "succes") {
        widget.pageController.animateToPage(0,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
        snacbar.showSnackBar(const SnackBar(
            content: Text("Kullanıcı Oluştu Lütfen Giriş Yapınız")));
      } else {
        snacbar.showSnackBar(
            const SnackBar(content: Text("Kullanıcı Oluşturulamadı")));
      }
    }
    setState(() {
      isload = false;
    });
  }
}
