import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class FireBaseDynamicLinkProvider {
  Future<String> createLink(String refCode) async {
    final String url = "https://com.example.dynamic_link_example?ref=$refCode";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      androidParameters: const AndroidParameters(
        packageName: "com.example.dynamic_link_example",
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.example.dynamic_link_example",
        minimumVersion: '0',
      ),
      link: Uri.parse(url),
      uriPrefix: "https://davronbekov.page.link",
    );
    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);
    return refLink.shortUrl.toString();
  }

  void initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if(instanceLink != null){
      final refLink = instanceLink.link;
      Share.share('THIS IS DYNAMIC LINK ${refLink.data}');
    }
  }
}
