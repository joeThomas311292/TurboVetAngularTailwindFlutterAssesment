import 'package:flutter/material.dart';
import 'controllers/chat_controller.dart';
import 'screens/chat_screen.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SupportApp());
}

class SupportApp extends StatelessWidget {
  const SupportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Support Messenger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.dashboardOverride});

  final Widget? dashboardOverride;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChatController _chatController = ChatController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ChatScreen(controller: _chatController),
      widget.dashboardOverride ?? const DashboardScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_index == 0 ? 'Messages' : 'Internal Tools'),
        actions: [
          if (_index == 0)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Clear chat',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Clear chat'),
                    content: const Text(
                      'Are you sure you want to delete all messages?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await _chatController.clear?.call();
                }
              },
            ),
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, key: Key('tab_messages')),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined, key: Key('tab_dashboard')),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
