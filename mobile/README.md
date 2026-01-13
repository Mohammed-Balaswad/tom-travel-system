# 🧳 TOM Travel App

A modern tourism and travel guide application built with **Flutter**.  
The app provides tourists with access to destinations, hotels, and flight booking services — all inside one elegant mobile experience.

---

## 🚀 Overview

**TOM Travel App** aims to simplify travel planning by connecting tourists with travel agencies and hotel services through an interactive app.  
The system includes:

- 🧭 **Tourist App:** Main user interface (Explore destinations, book hotels & flights).  
- 🏢 **Admin Panel:** For companies (airlines/hotels) to manage bookings and approve or reject them.  
- ☁️ **Backend:** Uses Firebase and RESTful APIs (to be integrated later).

---

## 📱 App Features

| Category | Features |
|-----------|-----------|
| User | Register, Login, Edit Profile |
| Explore | Browse destinations, view details |
| Booking | Flight & Hotel booking, manage reservations |
| Admin | Manage destinations, handle bookings |
| General | Splash, Onboarding, Notifications, Dark Mode |

---

## 🧩 Project Structure
```markdown
lib/
│
├── core/ # Common logic (constants, helpers, services)
│ ├── constants/
│ ├── utils/
│ └── theme/
│
├── data/ # Data Layer
│ ├── models/
│ ├── repositories/
│ └── services/
│
├── logic/ # State Management (BLoC / Cubit)
│ └── blocs/
│
├── presentation/ # UI Layer
│ ├── screens/
│ ├── widgets/
│ └── routes/
│
└── main.dart # Entry point
```
---

## 🧠 State Management

The app uses **BLoC** (Business Logic Component) for structured and scalable state management.  
For smaller features → use `Cubit`,  
For complex flows → use full `Bloc`.

---

## 🧑‍💻 Development Setup

1. Clone the repository:
```bash
 git clone https://github.com/Mohammed-Balaswad/TOM-Travel-App.git
 cd TOM-Travel-App
   ```
2. Get Flutter dependencies:
 ```bash
 flutter pub get
```
4. Run the app:
```bash
   flutter pub get
   ```
 

---

## 🌱 Git Workflow (Team Guide)

```markdown
 - main → Stable version only
 - feature/ branches for each new task:
   EX:
   git checkout -b feature/onboarding-ui
   git add .
   git commit -m "feat: add onboarding screens"
   git push origin feature/onboarding-ui

- Create Pull Requests → Review → Merge into main
```

---

## 📦 Tools & Technologies

```markdown
- Flutter (UI Framework)
- Dart (Language)
- Firebase (Authentication & DB)
- RESTful APIs (Backend Integration)
- Git & GitHub (Version Control)
```

---

## 🧰 Folder Notes

If you add any helper examples or prototypes (like counter_bloc),
put them inside:
examples/

---

## 👥 Team

This project is part of a university team project, led by
Project Lead: Mohammed Balaswad
and includes multiple student developers collaborating via GitHub.

---

## 🗓️ Status
```markdown
✅ Project Setup Complete
🕓 Currently: Preparing Flutter Architecture & Database Design
```

---

## 💡 Notes

Keep commits clean and descriptive — we’re building a scalable, production-ready structure even for a university project.
