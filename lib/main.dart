import 'package:flutter/widgets.dart';

import 'app.dart';
import 'injection_container.dart' as injection;

void main() {
  injection.init();
  runApp(const App());
}