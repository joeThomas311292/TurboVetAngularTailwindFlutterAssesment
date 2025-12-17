import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.testMode = false});

  final bool testMode;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final WebViewController _controller;
  static const _url = 'http://localhost:4200';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(_url));
  }

  @override
  Widget build(BuildContext context) {

    if (widget.testMode) {
    return const Center(child: Text('Dashboard (test stub)', key: Key('dashboard_stub')));
    }

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Angular Dashboard',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  tooltip: 'Reload',
                  onPressed: () => _controller.reload(),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
        Expanded(child: WebViewWidget(controller: _controller)),
      ],
    );
  }
}
