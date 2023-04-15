import 'dart:async';

import 'package:dynamic_link_example/pages/home.dart';
import 'package:dynamic_link_example/servises/firebase_Dynamik_link.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FireBaseDynamicLinkProvider().initDynamicLink();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   @override
     void initState() {
    super.initState();
    _uniLinks();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }

    StreamSubscription? initLinks;

  // @override
  // void dispose() {
  //   _initLinks?.cancel();
  //   super.dispose();
  // }

  void _uniLinks() {
    initLinks = FirebaseDynamicLinks.instance.onLink.listen(
      (event) {
        Uri deeplink = event.link;
        print('BU TOKEN ${deeplink.queryParameters['user_id'] ?? ''}');
        print('BU QUERY PARAM ${deeplink.queryParameters}');
        if (deeplink.queryParameters.containsKey('user_id')) {
          print('BU TOKEN ${deeplink.queryParameters['user_id'] ?? ''}');
        }
      },
    );
  }
}



