# 🐻 Animated Bear Login

An interactive and immersive Flutter login interface featuring a dynamic bear character animated with Rive. This project demonstrates the seamless integration of state machine animations with user input forms to create a unique and playful user experience.

---

## 🎓 Academic Information
* **Course Name:** Graficación
* **Teacher's Name:** Gaxiola Sosa Rodrigo Fidel
* **Student Name:** Tapia Puc Marcos Antonio
* **Institution:** Tecnológico Nacional De México, Instituto Tecnológico De Mérida

---

## ✨ Features
* 👀 **Eye-tracking:** The bear follows your email input with its eyes using the `isChecking` state.
* 🙈 **Privacy mode:** The bear covers its eyes when typing the password or when the password field gains focus via `isHandsUp`.
* 😁 **Happy bear:** Appears when login credentials are correct (**Admin@gmail.com / Admin12345**) triggering the `trigSuccess` input.
* 😢 **Sad bear:** Appears when login credentials are incorrect, activating the `trigFail` trigger.
* 🎨 **Smooth animations:** High-performance vector animations powered by the Rive engine.

---

## 📚 Theory
### What is Rive?
Rive is a real-time interactive design and animation tool that allows developers to create high-quality vector animations. Unlike traditional video or GIF formats, Rive animations are functional, allowing for state changes and user interaction without losing quality.

### What is a State Machine?
A State Machine in Rive is a visual logic layer that connects different animations. It allows the creator to define **Inputs** (Booleans, Numbers, or Triggers) that change the animation state based on logic provided by the Flutter application.



---

## 🛠 Technologies
* **Flutter 3.x:** UI Framework.
* **Dart 3.x:** Programming Language.
* **Rive 0.13.x:** Animation Engine.

---
## 🚀 Installation
1- Clone the repository:

git clone <your_project_url>

2- Install dependencies:
flutter pub get

3- Run the application:
flutter run
---

## 🎮 Usage
1. Enter your email
The bear will follow your typing with its eyes.

2. Enter your password
The bear automatically covers its eyes.

3. Press Login

✅ Correct credentials (Admin@gmail.com / Admin12345) → Bear becomes happy.

❌ Wrong credentials → Bear becomes sad.

---

## 📂 Project Structure
```text
lib/
├── main.dart             # Application entry point
└── login_screen.dart     # Main UI and Rive logic (FocusNodes, Listeners)
assets/
└── animated_login_bear.riv # Rive binary animation file
pubspec.yaml               # Project dependencies and assets
```
---

## 🎬 Demo
![Project Demo](assets/Osito.gif)
---
## 👤 Credits
This project uses animations from the Rive community:

Remix by: dexterc

Original Creator: Juan Carlos (JcToon)

Original Work: Login Bear

Implementation: Tapia Puc Marcos Antonio

---

## 📜 License
This project is for academic purposes for the Graficación course.
