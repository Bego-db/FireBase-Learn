import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// FireBase giriş yapma ve kullanıcı oluşturma sınıfı
class AuthService extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
// Kullanıcı Giriş Yapma Fonksiyonu
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userResult.user;
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

// Kullanıcı Giriş Yapma Fonksiyonu (servisten gelen hata koduna göre işlem yapılır)
  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "succes";
    } on FirebaseAuthException catch (e) {
      res = e.code.toString();
    }
    return res;
  }

  // Kullanıcı Oluşturma Fonkisyonu
  Future<String?> createUserWithEmailPassword(
      String email, String password) async {
    String? resCode;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      resCode = "succes";
    } on FirebaseAuthException catch (e) {
      resCode = e.code;
      log(e.toString());
    }
    return resCode;
  }
}
