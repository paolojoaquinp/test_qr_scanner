import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Nuevo import

class WebViewScreen extends StatefulWidget { // Cambio a StatefulWidget
  const WebViewScreen({
    super.key,
    required this.code,
  });

  final String code;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller; // Declaración del controller

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://tecnia.cni.bo/${widget.code}")); // Carga de la URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: WebViewWidget(controller: controller), // Uso del WebViewWidget
    );
  }
}
