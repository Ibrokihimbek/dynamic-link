import 'package:dynamic_link_example/servises/firebase_Dynamik_link.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
            FireBaseDynamicLinkProvider().createLink('davronbekov4713').then((value){
              Share.share(value);
            });
          },
          child: const Text('Share Link'),
        ),
      ),
    );
  }
}
