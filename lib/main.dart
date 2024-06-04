import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/root.dart';

void main() async {
  await initServices();
  debugPrint('App started');
  runApp(const RootApp());
}

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
}
