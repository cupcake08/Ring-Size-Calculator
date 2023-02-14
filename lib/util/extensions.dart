import 'dart:developer' as dev show log;

import 'package:flutter/widgets.dart';

extension Log on Object {
  void log([String? name]) {
    dev.log(toString(), name: name ?? toString());
  }
}

extension Sizer on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
