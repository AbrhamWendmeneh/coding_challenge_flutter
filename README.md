# Flutter Mobile App Developer Coding Interview

## Task 1: Develop a Peer-to-Peer Service Application (Airbnb like)

**Task:**
- **User Registration and Login:** Implement user registration and login using Authentication mechanism.
- **Listing Creation:** Allow users to post their accommodations with details such as title, description, and price.
- **Browse Listings:** Implement a simple feature to view and list available accommodations.

**Requirements:**
- **Firebase Setup / Authentication Setup:** Use Firebase or other tools of your choice for user authentication and data storage. Provide Firebase or other tool configuration details.
- **State Management:** Use a state management solution such as Provider.
- **UI/UX:** Basic user interface for posting and viewing listings.

**Evaluation Criteria:**
- Code quality and organization.
- Proper use of Firebase/other tools for authentication and data storage.
- Basic state management.
- Functional UI design.

**Dependencies Provided:**
- Firebase project configuration details (API keys, project ID, etc.).

## Task 2: Integrate Google Maps API (Simplified)
**Objective:** Assess the candidate's skills in integrating Google Maps API into a Flutter mobile application.

**Task:**
- **Map Integration:** Integrate Google Maps into the app to display a map.
- **Markers:** Display markers on the map for at least three hard-coded accommodation listings.

**Requirements:**
- **Google Maps API:** Integrate Google Maps API into the app. Provide necessary API keys.
- **Secure API Key Handling:** Ensure API keys are securely managed.
- **User Experience:** Basic map interface with markers.

**Evaluation Criteria:**
- Proper integration of Google Maps API.
- Secure handling of API keys.
- Basic implementation of markers.

**Dependencies Provided:**
- Google Maps API keys: AIzaSyC3TxwdUzV5gbwZN-61Hb1RyDJr0PRSfW4


### Firebase setup (optional) 
-------------
You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
- Once your Firebase instance is created, you'll need to enable anonymous authentication.
- Go to the Firebase Console for your new instance.
- Click "Authentication" in the left-hand menu
- Click the "sign-in method" tab
- Click "Google" and enable it
- Enable the Firebase Database
- Go to the Firebase Console
- Click "Database" in the left-hand menu
- Click the Cloudstore "Create Database" button
- Select "Start in test mode" and "Enable"
(skip if not running on Android)
- Create an app within your Firebase instance for Android, with package name com.bmitech.dari_darek_admin
- Run the following command to get your SHA-1 key:
`keytool -exportcert -list -v `
`-alias androiddebugkey -keystore ~/.android/debug.keystore`
- In the Firebase console, in the settings of your Android app, add your SHA-1 key by clicking "Add Fingerprint".
- Follow instructions to download google-services.json
- place google-services.json into /android/app/.
(skip if not running on iOS)
- Create an app within your Firebase instance for iOS, with your app package name
- Follow instructions to download GoogleService-Info.plist
- Open XCode, right click the Runner folder, select the "Add Files to 'Runner'" menu, and select the GoogleService-Info.plist file to add it to /ios/Runner in XCode
- Open /ios/Runner/Info.plist in a text editor. Locate the CFBundleURLSchemes key. The second item in the array value of this key is specific to the Firebase instance. Replace it with the value for REVERSED_CLIENT_ID from GoogleService-Info.plist
Double check install instructions for both

- Google Auth Plugin
https://pub.dartlang.org/packages/firebase_auth
- Firestore Plugin
https://pub.dartlang.org/packages/cloud_firestore

