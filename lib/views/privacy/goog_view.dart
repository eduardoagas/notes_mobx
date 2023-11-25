import 'package:flutter/material.dart';
import 'package:notes_mobx/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleView extends StatelessWidget {
  const GoogleView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://google.com'));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Política de Privacidade',
          style: TextStyle(
            color: Colors.grey[200],
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (context.read<AppState>().lastScreen == AppScreen.notes) {
              context.read<AppState>().enter = false;
            }
            context.read<AppState>().currentScreen =
                context.read<AppState>().lastScreen;
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[200],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 37, 22),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
