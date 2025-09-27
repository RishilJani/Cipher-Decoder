# 🔐 SherlockCode (Cipher-Decoder)

A Flutter-based mobile application for **encoding/decoding** and **encryption/decryption** of text using classical and modern methods.  
This project is designed as a handy tool for students, developers, and security enthusiasts to experiment with data transformation techniques in an intuitive UI.

---

## ✨ Features

- 📝 **Encode & Decode**
  - Base64, Base32, and other encoding schemes
  - Simple UI for text conversion  
- 🔒 **Encrypt & Decrypt**
  - Classical ciphers (Caesar, Vigenère, etc.)
  - Modern encryption methods (planned support)  
- 📱 **User-Friendly Interface**
  - Dashboard with quick navigation
  - Dark theme friendly design  
- ℹ️ **About Section**
  - Learn more about the app and its purpose
- 📮 **Feedback Screen**
  - A built-in feedback form/screen allowing users to submit issues, suggestions or contact details directly from the app. (Included in the app source; see Project Structure below.)

---

## 📂 Project Structure (high-level)

```
lib/
 ├── main.dart                      # Entry point
 ├── dashboard/                     # Main dashboard + splash screen
 ├── encoding_decoding/             # Encode/Decode features
 │   ├── encode/                    # Encoding logic & views
 │   ├── decode/                    # Decoding logic & views
 │   └── encode_decode/             # Shared models & options
 ├── encrypt_decrypt/               # Encryption/Decryption features
 ├── about_us/                      # About Us page
 ├── feedback/                      # Feedback screen & related controllers/views
 └── ...                            # other modules and utilities
```

> **Note:** I added `lib/feedback/` above to reflect the feedback screen you mentioned. If your feedback screen lives under a different path (for example `lib/about_us/feedback.dart`), replace the path accordingly in the README.

---

## 📮 Feedback Screen (in README)

The app includes a **Feedback** screen where users can submit comments, bug reports, or contact info without leaving the app. This is useful for collecting user input during testing and early releases.

**Typical behavior:**
- Access from the app's navigation drawer or About page.  
- Includes form fields such as Name, Email (optional), Message, and a Submit button.  
- On submit the feedback can either be saved locally, sent to an API endpoint, or opened as an email draft (depending on how you implemented it).

If you want, I can also add a short code snippet in README showing how to navigate to the Feedback screen (e.g., `Get.to(FeedbackView())`) — tell me which navigator / class name you used and I'll include the exact snippet.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (≥ 3.0.0)  
- Android Studio / VS Code with Flutter & Dart plugins

### Installation
```bash
# Clone the repository
git clone https://github.com/RishilJani/Cipher-Decoder.git

# Navigate into the project
cd Cipher-Decoder

# Get dependencies
flutter pub get

# Run on a connected device
flutter run
```

---

## 🛠️ Tech Stack

- **Framework:** Flutter  
- **Language:** Dart  
- **State Management:** GetX (observed from repo file names)  
- **Design:** Material Design, custom splash screen  

---

## 📸 Screenshots

(Add screenshots here – e.g., splash screen, dashboard, encode/decode screens, feedback screen)  
Example:

<p align="center">
  <img src="assets/image/SherlockCode.png" width="200" />
</p>

---

## 🤝 Contributing

Contributions are welcome!  
- Fork the repo  
- Create a new branch (`feature/my-feature`)  
- Commit changes  
- Open a Pull Request  

When contributing, please include any UI screenshots for new screens like the Feedback screen so reviewers can see the UX changes quickly.

---

## 📜 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.  
