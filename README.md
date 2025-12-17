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





## Screenshots


| Name | iOS | Android |
|------|-----|------|
| Messages Tab (Blank)  |  <img width="108" height="240" alt="android_message_blank" src="https://github.com/user-attachments/assets/7dca0a4b-29e8-4e7f-90e3-a0d19372db6b" /> | <img width="108" height="240" alt="iOS_messages_blank" src="https://github.com/user-attachments/assets/463201ef-3dda-457d-bdc0-021612b39e7b" /> |
| Messages Tab | <img width="108" height="240" alt="android_messages" src="https://github.com/user-attachments/assets/54bf3bcc-0ad0-43ac-b7cd-a534a8534ca2" />  | <img width="108" height="240" alt="iOS_messages" src="https://github.com/user-attachments/assets/32d5ef83-5497-4d39-9437-9c4bcef5ab10" /> |
| Messages Tab - Clear message  | <img width="108" height="240" alt="android_message_clear" src="https://github.com/user-attachments/assets/79b6da61-1f46-4c25-8c46-2cfed7f3f2eb" />  | <img width="108" height="240" alt="iOS_message_clear" src="https://github.com/user-attachments/assets/0bb6814d-998b-4046-84dc-485a13a3a863" /> |
| Dashboard tickets  | <img width="108" height="240" alt="iOS_dashboard_ticket" src="https://github.com/user-attachments/assets/2f535f05-f31d-4f53-9733-02c4b1a5f4a5" />  | <img width="108" height="240" alt="android_dashboard_ticket" src="https://github.com/user-attachments/assets/b0b31868-afa0-4eeb-ae5d-d6dba10a8b3a" /> |
| Dashboard tickets filtered | <img width="108" height="240" alt="iOS_dashboard_ticket_filter" src="https://github.com/user-attachments/assets/ea1e04de-925e-4531-b393-9cd851840183" /> | <img width="108" height="240" alt="android_dashboard_tickets_filtered" src="https://github.com/user-attachments/assets/a530fa8a-bb4e-4759-b7f3-b6e648d9d93e" /> |
| Dashboard logs | <img width="108" height="240" alt="iOS_dashboard_logs" src="https://github.com/user-attachments/assets/2bb62aea-8811-4b20-908d-fc0945900eb5" /> | <img width="108" height="240" alt="android_dashboard_logs" src="https://github.com/user-attachments/assets/8f9351eb-9359-4088-b671-f9a6bce70849" /> |
| Dashboard knowledge base  | <img width="108" height="240" alt="iOS_dashboard_knowledgebase" src="https://github.com/user-attachments/assets/b36fb41c-5ed2-48c7-a6aa-a196d2478412" /> | <img width="108" height="240" alt="android_dashboard_knowledgebase" src="https://github.com/user-attachments/assets/cc101814-6a2c-4792-bedc-5facafefa632" /> |



| Name | Screenshot |
|------|-----|
| WebApp Ticket  |  <img width="300" height="200" alt="web_ticketview" src="https://github.com/user-attachments/assets/e53953c1-12d1-4308-81a9-47aeda935ec7" /> |
| WebApp Ticket (Filtered)  |  <img width="300" height="200" alt="web_ticketview_filtered" src="https://github.com/user-attachments/assets/b495aeb4-25d6-4100-9a26-5349fe8d60cd" /> |
| WebApp Logs  |  <img width="300" height="200" alt="web_livelogs" src="https://github.com/user-attachments/assets/457d926b-1436-4571-8e83-b71f8f393a0f" /> |
| WebApp Knowledgebase (Preview)  |  <img width="300" height="200" alt="web_knowledgebase_split" src="https://github.com/user-attachments/assets/2e52281f-7167-4f0e-b06b-d6c71f03cb9c" /> |
| WebApp Knowledgebase  |  <img width="300" height="200" alt="web_knowledgebase" src="https://github.com/user-attachments/assets/e1efae83-7fe6-4bea-ae1b-2124a39e44e0" /> |
