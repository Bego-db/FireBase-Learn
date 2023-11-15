import 'package:fb_learn/core/const/string_constant.dart';
import 'package:fb_learn/core/extension/project_extension.dart';
import 'package:fb_learn/future/register.dart';
import 'package:fb_learn/product/firebase/auth_services.dart';
import 'package:flutter/material.dart';



class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String emails, passwords;
  final formkey = GlobalKey<FormState>();
  final controller = PageController();
  AuthService auth = AuthService();
  bool isLoad = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Center(
            child: Padding(
              padding: context.horizontal20,
              child: Form(
                key: formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 150),
                      TextFormField(
                          validator: (value) => _textFormFieldValidate(value),
                          onSaved: (newValue) => _textFormFieldOnSavedMail(
                                newValue,
                              )),
                      Padding(
                        padding: context.vertical,
                        child: TextFormField(
                            validator: (value) => _textFormFieldValidate(value),
                            onSaved: (newValue) =>
                                _textFormFieldOnSavedPassword(newValue)),
                      ),
                      Padding(
                        padding: context.vertical,
                        child: ElevatedButton(
                            onPressed: isLoad ? null : _loginIn,
                            child: isLoad
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive())
                                : const Text(StringConstant.login)),
                      ),
                      TextButton(
                          onPressed: createUserPageonPress,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(StringConstant.createUser),
                              Icon(Icons.chevron_right),
                            ],
                          ))
                    ]),
              ),
            ),
          ),
          RegisterView(
            pageController: controller,
          )
        ],
      ),
    );
  }

  void _loginIn() async {
    isLoadFun();
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final naviContext = Navigator.of(context);
      final snackBarContext = ScaffoldMessenger.of(context);

      final res = await auth.signInWithEmailPassword(emails, passwords);
      if (res != null) {
        naviContext.pushNamed("/home", arguments: res.email);
      } else {
        snackBarContext.showSnackBar(SnackBar(content: Text(res.toString())));
      }
      isLoadFun();
    }
  }

  void isLoadFun() {
    setState(() {
      isLoad = !isLoad;
    });
  }

  String? _textFormFieldValidate(String? value) {
    if (value!.isEmpty) {
      setState(() {
        isLoad = false;
      });
      return StringConstant.validate;
    } else {
      return null;
    }
  }

  String? _textFormFieldOnSavedMail(String? newvalue) {
    emails = newvalue!;
    return null;
  }

  String? _textFormFieldOnSavedPassword(
    String? newvalue,
  ) {
    passwords = newvalue!;
    return null;
  }

  void Function()? createUserPageonPress() {
    controller.animateToPage(1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInSine);

    return null;
  }
}
