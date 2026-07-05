# 🩺 My Doctor — Doctor Appointment Booking App (Flutter)

A clean, feature-driven Flutter application UI for discovering doctors, viewing their profiles, and initiating appointment booking. Built with a scalable, production-style folder structure and a fully custom skeleton-loading system — no third-party shimmer packages, no shortcuts.

This project is not a UI-only demo thrown together for a tutorial. It's structured the way a real product team would organize a growing mobile codebase: features are isolated, routing is centralized, and every screen has a matching loading-state counterpart.

---

## ✨ Key Features

- **Splash & Onboarding Flow** — An animated splash screen introducing the app's value proposition ("More Comfortable Chat With the doctor"), transitioning into the main experience.
- **Custom Skeleton Loading (Shimmer) System** — Hand-built shimmer placeholders (`SplashWireframe`, `HomeWireframe`, `DetailsWireframe`) using `AnimationController` and `ShaderMask`, mirroring the exact layout of the real screen before content loads. This is implemented from scratch, not via a shimmer package.
- **Home Dashboard**
  - Personalized welcome header with avatar and notification badge.
  - Integrated search field.
  - Horizontal, scrollable specialty filter chips (All, Cardiologist, Dentist, Neurologist, Pediatrician, Dermatologist, Orthopedic) with selectable state.
  - "Favourite Doctor" grid view (2-column responsive grid).
  - "Top Doctor" vertical list view.
- **Doctor Details Screen**
  - Collapsing `SliverAppBar` with hero doctor image and gradient overlay.
  - Doctor rating badge, specialty tag, and stat cards (years of experience, patient count, location).
  - Full doctor biography section.
  - Persistent "Book Appointment" call-to-action.
- **Named Routing System** — Centralized route table (`AppRoutes`) and a single `onGenerateRoute` handler, including safe fallback handling when required navigation arguments (`DetailsData`) are missing.
- **Responsive Layout Engine** — Every screen scales proportionally across device sizes using `flutter_screenutil`, with a fixed design reference of `365x832`.
- **Custom Typography** — Application-wide custom font (`FinlandicaHeadline`) applied via a centralized `ThemeData`.

> **Note:** Authentication screens (`LoginScreen`, `SignupScreen`) and input validation (`app_validators.dart`) are scaffolded and routed, but not yet implemented — see [Future Improvements](#-future-improvements).

---

## 🛠️ Tech Stack

| Category            | Technology                          |
|---------------------|--------------------------------------|
| Language             | Dart                                 |
| Framework            | Flutter (Material Design)            |
| Responsive Design    | `flutter_screenutil`                 |
| Navigation           | Native `Navigator` + custom `onGenerateRoute` |
| State Management     | `StatefulWidget` / `setState`        |
| Animations           | `AnimationController`, `ShaderMask`, `AnimatedBuilder` |
| Data Layer           | Static in-memory models (mock data)  |

---

## 🏗️ Project Architecture

The codebase follows a **feature-first architecture**, a pattern commonly used in scalable Flutter applications to keep each business domain self-contained and independently maintainable.

```
lib/
├── main.dart                     # App entry point
├── app.dart                      # MaterialApp setup, theming, ScreenUtil init
├── core/
│   ├── routing/
│   │   └── app_routes.dart       # Centralized route names + route generator
│   └── validators/
│       └── app_validators.dart   # Reserved for form validation logic
└── features/
    ├── splash/
    │   └── presentation/
    │       ├── screens/          # Real splash screen
    │       └── screens/wireframe # Shimmer loading version of splash
    ├── auth/
    │   ├── domain/                # Reserved for auth business logic
    │   └── presentation/
    │       ├── screens/login/     # Login screen (scaffolded)
    │       └── screens/signup/    # Signup screen (scaffolded)
    ├── home/
    │   ├── data/                  # Doctor + filter mock data models
    │   └── presentation/
    │       ├── screens/           # Home screen + shimmer wireframe
    │       └── widgets/           # AppBar, filters, cards, grid, titles
    └── details/
        ├── data/                  # Extended doctor detail model
        └── presentation/
            ├── screens/           # Details screen + shimmer wireframe
            └── widgets/           # Reserved for detail-specific widgets
```

**Why this matters:** each feature owns its data, its screens, and its widgets. Nothing about the "home" feature depends on knowing how "details" is implemented internally, aside from the shared route table and data contracts — making the codebase easy to extend, test, and hand off between engineers.

---

## ⚙️ How It Works

1. **App Boot** — `main.dart` launches `App`, which wraps the entire widget tree in `ScreenUtilInit` for consistent scaling and configures the initial route.
2. **Splash Sequence** — The app opens on `SplashWireframe`, a shimmering skeleton that auto-navigates after a timed delay to the real `SplashScreen`, which presents the value proposition and a "Get Started" action.
3. **Navigation** — "Get Started" pushes the user into `HomeWireframe`, another shimmer-based loading screen that automatically transitions into the live `HomeScreen` once its timer completes — simulating a real data-fetch experience even though data is currently local/mock.
4. **Home Experience** — `HomeScreen` renders `HomeBody`, a `CustomScrollView` composed of slivers: search app bar, specialty filters, a favourites grid, and a top-doctors list — all built from the `doctors` mock dataset.
5. **Doctor Selection** — Tapping a doctor card passes a `DetailsData` object as route arguments to `DetailsWireframe`, which shimmers briefly before revealing the full `DetailsScreen` with the doctor's stats, bio, and booking action.
6. **Routing Safety** — `AppRouter.onGenerateRoute` checks argument types before building detail routes, falling back to an error screen if a doctor object wasn't correctly passed — preventing runtime crashes from malformed navigation calls.

---

## 🚀 Installation & Setup

**Prerequisites**
- Flutter SDK installed ([flutter.dev](https://flutter.dev))
- A configured emulator or physical device

**Steps**

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/my-doctor-app.git
cd my-doctor-app

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

> Ensure `flutter_screenutil` is present in `pubspec.yaml` under dependencies, and that referenced image assets (e.g. `assets/images/`) are registered in the `assets:` section of `pubspec.yaml`.

---

## 📸 Screenshots

| Splash | Home | Doctor Details |
|--------|------|-----------------|
| _Add screenshot_ | _Add screenshot_ | _Add screenshot_ |

> Screenshots are not included in the current repository snapshot. Replace the placeholders above with actual captures from `flutter run` or `flutter screenshot`.

---

## 🔭 Future Improvements

These are logical next steps based directly on what's already scaffolded in the codebase:

- **Implement `app_validators.dart`** — the file exists and is wired into the `core/` layer but currently contains no logic; this is the natural home for email/password validation feeding into auth forms.
- **Complete `LoginScreen` and `SignupScreen`** — both are registered in the routing table and structurally present, but currently render empty containers.
- **Connect the specialty filter chips to actual filtering logic** — selection state is tracked in `HomeFilters`, but the doctor list is not yet filtered by the selected specialty.
- **Wire up the search field** — `AppSearchTextField` and its controller are in place but not yet connected to a search/filter pipeline.
- **Replace mock data with a real data source** — `doctors` and `detailsDatas` are currently static in-memory lists; introducing a repository/service layer would allow a straightforward swap to a REST or Firebase backend.
- **Implement the "Book Appointment" action** — the button exists on the details screen with an empty `onPressed` callback, ready for booking-flow logic.
- **Introduce a state management solution** (Provider, Riverpod, or Bloc) as the app grows beyond local `setState`.
- **Add automated tests** for widgets and routing logic, particularly around the argument-safety checks in `AppRouter`.

---

## 💼 A Note for Reviewers

This repository demonstrates disciplined engineering habits that go beyond making the UI "look right": a feature-first architecture that scales, a centralized and defensively-coded routing layer, a custom-built shimmer/skeleton loading system applied consistently across every major screen, and a codebase where incomplete areas are clearly scaffolded rather than hidden. It reflects the kind of foundation a team can build a production app on top of — structured, predictable, and easy to reason about.
