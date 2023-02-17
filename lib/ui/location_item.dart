import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..scrollTo(0, 900)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://www.latlong.net/c/?lat=41.299496&long=69.240074"));
    return Container(
      margin: EdgeInsets.all(12),
      height: 60,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.blue
      ),
      child: WebViewWidget(controller: controller),
    );
  }
}
