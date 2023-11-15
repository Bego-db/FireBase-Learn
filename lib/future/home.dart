import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_learn/core/extension/project_extension.dart';
import 'package:fb_learn/product/firebase/get_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}
class _HomePageState extends ConsumerState<HomePage> {
  final GetPost getpos = GetPost();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String user = ModalRoute.of(context)!.settings.arguments as String;
    TextEditingController noteController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showBottomSheet(context, noteController, user);
          },
          child: const Icon(Icons.add),
        ),
        appBar: _newMethod(user, context),
        body: homePageBody());
  }

  AppBar _newMethod(String user, BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: const SizedBox(),
      title: Text(
        user,
        style: context.mytextTheme.bodyLarge,
      ),
      actions: [
        IconButton(
            onPressed: signOut,
            icon: const Icon(
              Icons.exit_to_app_rounded,
            ))
      ],
    );
  }

  void Function()? signOut() {
    _auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
    return null;
  }

  Future<dynamic> _showBottomSheet(
      BuildContext context, TextEditingController noteController, String user) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: context.horizontal20 +
              context.highvertical +
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            runSpacing: 12,
            children: [
              Center(
                  child: Text(
                "Lütfen Notunuzu Giriniz",
                style: context.mytextTheme.bodyLarge,
              )),
              TextFormField(
                controller: noteController,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (noteController.text.isEmpty) {
                      } else {
                        getpos.addPost(noteController.text, user);
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: context.horizontal20,
                      child: const Text("Notlara ekle"),
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _waitingWidget() => const Center(child: CircularProgressIndicator());

  Widget _taskCardBuilder(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data?.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot mySnap = snapshot.data!.docs[index];
        return Padding(
          padding: context.horizontal20 / 2,
          child: Card(
            color: mySnap['isActive']
                ? context.theme.colorScheme.onPrimary
                : Colors.green[800],
            child: GestureDetector(
              onTap: () {
                log(index.toString());
              },
              child: ListTile(
                title: Text("${mySnap['message']}"),
                trailing: Text("${mySnap['userName']}"),
                subtitle: Text("${mySnap['time']}"),
              ),
            ),
          ),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> homePageBody() {
    return StreamBuilder(
      stream: getpos.getUserPost(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _waitingWidget();
        } else if (snapshot.hasError) {
          return const Text("Hata");
        } else {
          return _taskCardBuilder(snapshot);
        }
      },
    );
  }
}
