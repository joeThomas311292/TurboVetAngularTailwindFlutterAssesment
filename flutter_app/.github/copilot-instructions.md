### Purpose

This file guides AI coding agents (Copilot-style) to be immediately productive in this Flutter messaging app.

### Big picture
- **App type:** Flutter mobile app with two main screens: messaging UI (`lib/screens/chat_screen.dart`) and an embedded Angular dashboard (`lib/screens/dashboard_screen.dart`).
- **Data flow:** Messages are in-memory model instances (`lib/models/message.dart`). `ChatScreen` manages local state and simulates auto-replies. The dashboard is a `WebView` pointed at a local dev server (`webpage/`).

### Key files to read first
- `lib/main.dart` — app entry, `HomeScreen` navigation and tab structure.
- `lib/screens/chat_screen.dart` — message UI, input controls, auto-reply logic.
- `lib/screens/dashboard_screen.dart` — creates `WebViewController` and loads `http://localhost:4200`; supports `testMode` to stub the view in tests.
- `lib/models/message.dart` — message shape used across app.
- `webpage/` — Angular dashboard source (dev server expected at port 4200).

### Project-specific conventions & patterns
- UI state is local to widgets (no global state management package). Look for small stateful widgets managing controllers and lists (e.g., `_messages` in `ChatScreen`).
- Tests and test hooks: `DashboardScreen` exposes `testMode` to avoid launching the webview in CI; use this for widget/unit tests.
- Keys are used for test selectors: e.g., `Key('chat_input')`, `Key('chat_send')`, `Key('tab_messages')`, `Key('dashboard_stub')` — reference these in tests or assistant-suggested changes.

### Build, run and test workflows (concrete commands)
- Install deps: `flutter pub get`
- Run on simulator/device: `flutter run -d <device>`
- Build APK: `flutter build apk`
- iOS: open `ios/Runner.xcworkspace` in Xcode; run `pod install` in `ios/` if CocoaPods changed.
- Tests: `flutter test` (project has a widget_test scaffold in `test/widget_test.dart`).
- Dashboard dev server: `cd webpage && npm install && npm start` (Angular dev server expected at `http://localhost:4200`).

### Integration & external dependencies
- `webview_flutter` is used to embed the Angular dashboard — be mindful of platform WebView setup on Android/iOS.
- `intl` is used for message timestamps formatting.

### Typical agent tasks & examples
- Fix a UI bug in messages: update `lib/screens/chat_screen.dart` — preserve `TextEditingController` / `ScrollController` lifecycles and `_scrollToBottom()` usage.
- Add a feature that affects both views: update `lib/models/message.dart` first, then propagate changes to `chat_screen.dart` and any tests that create `Message` instances.
- Support test-friendly Dashboard changes: prefer using the `testMode` flag in `lib/screens/dashboard_screen.dart` rather than instantiating a live `WebView` in test runs.

### What not to change without justification
- Do not replace local state patterns with global state managers unless required by feature scope; the codebase intentionally uses lightweight widget-local state.
- Avoid changing the `WebView` URL constant in `dashboard_screen.dart` without confirming Angular server expectations in `webpage/`.

### Where to look for related code examples
- Navigation and tabs: [lib/main.dart](lib/main.dart)
- Message UI/logic: [lib/screens/chat_screen.dart](lib/screens/chat_screen.dart)
- Dashboard integration: [lib/screens/dashboard_screen.dart](lib/screens/dashboard_screen.dart)
- Data model: [lib/models/message.dart](lib/models/message.dart)

### If unsure, ask the user
- Confirm whether the Angular dashboard should be part of CI/local tests or always stubbed via `testMode`.
- Ask whether persistent message storage (SQLite/shared prefs) is planned before suggesting database changes.

---
Please review these instructions and tell me any project-specific workflows or conventions I missed so I can refine the guide.
