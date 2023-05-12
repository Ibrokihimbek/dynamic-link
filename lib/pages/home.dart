import 'package:dynamic_link_example/pages/scaner/scaner_page.dart';
import 'package:dynamic_link_example/servises/firebase_Dynamik_link.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Link Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            FireBaseDynamicLinkProvider().createLink().then((value){
              debugPrint(value);
            });
          },
          child: const Text('Share Link'),
        ),
      ),
    );
  }
}
