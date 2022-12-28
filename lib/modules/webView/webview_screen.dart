
import 'package:fl_webview/fl_webview.dart';
import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen(this.url);

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: FlWebView(
              initialUrl: url,
            ),
          );
  }
}
