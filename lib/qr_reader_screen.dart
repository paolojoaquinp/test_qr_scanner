import 'package:flutter/material.dart';
import 'package:flutter_test_app/webview_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRReaderScreen extends StatefulWidget {
  const QRReaderScreen({super.key});

  @override
  State<QRReaderScreen> createState() => _QRReaderScreenState();
}

class _QRReaderScreenState extends State<QRReaderScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR'),
      ),
      body: QRView(
        onQRViewCreated: _onQRViewCreated,
        key: qrKey,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (Barcode scanData) {
        if (scanData.code != null) {
          String code = scanData.code!;
          
          // Detener el escaneo
          controller.pauseCamera();
          
          // Navegar a la pantalla WebView
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WebViewScreen(
                code: code,
              ),
            ),
          ).then((_) => controller.resumeCamera());
        }
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}