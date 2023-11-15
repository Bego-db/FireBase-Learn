import 'package:flutter/material.dart';

extension MyPadding on BuildContext {
  EdgeInsets get horizontal20 => const EdgeInsets.symmetric(horizontal: 20);
  EdgeInsets get vertical => const EdgeInsets.symmetric(vertical: 5);
   EdgeInsets get highvertical => const EdgeInsets.symmetric(vertical: 15);
}

extension ThemeExtentions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get mytextTheme => theme.textTheme;
}

// extension MyDuration2 on BuildContext {
//   Duration get milliseconds => const Duration(milliseconds: 2000);
//   Duration get days => const Duration(days: 1);
//   Duration get hours => const Duration(hours: 2);
//   Duration get min => const Duration(minutes: 1);
//   Duration get microseconds => const Duration(microseconds: 10000);
// }

// extension MyDuration on int {
//   Duration get milliseconds => Duration(milliseconds: this);
//   Duration get days => Duration(days: this);
//   Duration get hours => Duration(hours: this);
//   Duration get min => Duration(minutes: this);
//   Duration get microseconds => Duration(microseconds: this);
// }
