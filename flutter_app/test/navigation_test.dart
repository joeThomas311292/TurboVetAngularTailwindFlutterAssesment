import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';

void main() {
  testWidgets('bottom tabs switch between Messages and Dashboard', (tester) async {
    await tester.pumpWidget(const SupportAppWrapperForTest());
    await tester.pump();

    // Start on Messages (Chat UI should have input)
    expect(find.byKey(const Key('chat_input')), findsOneWidget);

    // Tap dashboard tab
    await tester.tap(find.byKey(const Key('tab_dashboard')));
    await tester.pumpAndSettle();

    // Dashboard stub should be visible (no WebView in tests)
    expect(find.byKey(const Key('dashboard_stub')), findsOneWidget);
  });
}

class SupportAppWrapperForTest extends StatelessWidget {
  const SupportAppWrapperForTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(
        dashboardOverride: const Center(
          key: Key('dashboard_stub'),
          child: Text('Dashboard (test stub)'),
        ),
      ),
    );
  }
}
