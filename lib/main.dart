import 'package:flutter/material.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/optikick_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  
  runApp(const OptikickApp());
}

// Player:
// luisdiaz@gmail.com
// luis6640
// _______________________________
// doctor:
// jonathan@gmail.com
// jonathan6640
// __________________________
// ______
// coach:
// arneslot@gmail.com
// arne6640
