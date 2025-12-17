# Project Name



## How to Run

### Angular Dashboard
cd webpage
npm install
ng serve --port 4200

### Flutter App
cd flutter_app

# Android emulator
adb reverse tcp:4200 tcp:4200
flutter run -d emulator-5554

# iOS simulator
flutter run -d <ios-simulator-id>
