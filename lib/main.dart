import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Completer<WebViewController>();

  Widget navigationButton(
      IconData icon, Function(WebViewController) onPressed) {
    return FutureBuilder(
      future: controller.future,
      builder: (context, AsyncSnapshot<WebViewController> snapShot) {
        if (snapShot.hasData) {
          return IconButton(
              icon: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () => onPressed(snapShot.data));
        } else {
          return Container(
            child: Text(''),
          );
        }
      },
    );
  }

  void _goBack(WebViewController controller) async {
    final canGoBack = await controller.canGoBack();

    if (canGoBack) {
      controller.goBack();
    }
  }

  void _goForward(WebViewController controller) async {
    final canGoForward = await controller.canGoForward();

    if (canGoForward) {
      controller.goForward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kyaw Moe Han\'s website'),
        ),
        body: WebView(
          initialUrl: 'https://kyawmoehan.github.io/',
          onWebViewCreated: (controlelr) => controller.complete(controlelr),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0, right: 20),
            child: ButtonBar(
              children: [
                navigationButton(
                    Icons.chevron_left, (controller) => _goBack(controller)),
                navigationButton(Icons.chevron_right,
                    (controller) => _goForward(controller)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
