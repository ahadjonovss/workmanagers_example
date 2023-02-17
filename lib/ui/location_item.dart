import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      height: 60,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
          color: Colors.blue
      ),
      child: Text("Some"),
    );
  }
}
