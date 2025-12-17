# Flutter Messaging App + Angular Internal Tools Dashboard
This project demonstrates a hybrid mobile + web architecture:
A Flutter mobile app with a native messaging experience
An Angular (standalone) internal tools dashboard embedded via WebView
Clean separation of concerns between customer-facing UI and internal tooling

## Architecture Overview
### Flutter (Mobile App)
* Native chat UI (messages + auto replies)
* Bottom navigation (Messages / Dashboard)
* WebView integration for internal tools
* Runs on both Android emulator and iOS simulator
### Angular (Web Dashboard)
* Angular v15+ using standalone components
* Tailwind CSS for styling
* Sidebar layout with routing
* Three internal tools:
  - Ticket Viewer
  - Knowledgebase Editor
  - Live Logs Panel


## How to Run
### Run the Angular Dashboard
    cd webpage
    npm install
    ng serve --port 4200

And open in browser: http://localhost:4200

### Run the Flutter App
#### Android Emulator
    cd flutter_app
    adb reverse tcp:4200 tcp:4200
    flutter run -d emulator-5554

#### iOS Simulator
    flutter run -d <ios-simulator-id>


## Features Implemented
### Flutter App
* Native chat UI with message bubbles
* Auto-reply simulation
* Timestamped messages
* Bottom navigation
* Embedded Angular dashboard via WebView
* Reload button for WebView

### Angular Dashboard
* Responsive sidebar layout
* Ticket Viewer with status filtering
* Knowledgebase editor with live preview
* Live Logs panel with auto-scrolling output
* Tailwind CSS styling
* Modern Angular control flow (@for, @if)
