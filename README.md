# 📽️ Watchly – TMDB Movie App

![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)
![Swift](https://img.shields.io/badge/swift-5.0-orange.svg)

**Watchly** is a modern, modular iOS app built using **Swift**, **SwiftUI**, and **async/await**. It interacts with **The Movie Database (TMDB)** to showcase trending movies, detailed views, and favorites. The architecture is clean, testable, and cross-platform ready with a reusable **XCFramework**.

## 📸 Screenshots

| Home Screen              | Search                       | Details                        |
| ------------------------ | ---------------------------- | ------------------------------ |
| ![Home](Assets/home.png) | ![Search](Assets/search.png) | ![Details](Assets/detail1.png) |

---

## ✨ Features

- ✅ Trending movie list UI
- ✅ Movie detail screen with rich metadata
- ✅ ⭐ **Favorite button** with local persistence
- ✅ ⚙️ **XCFramework** built for reuse — supports **iOS**, **tvOS**, and **visionOS**
- ✅ ⏱ **Custom debounce** utility for search & UI responsiveness
- ✅ ⏱ **Paging Support** utility for Trending
- ✅ 🧠 **LRU cache** support in memory layer
- ✅ 🌐 **Retry mechanism** on network failure (e.g. no internet)
- ✅ 🧩 UIKit integration example — **SwiftUI + UIKit interop demo**
- ✅ ✅ Uses **async/await only** — no Combine dependency
- ✅ 🧪 50% **unit test coverage** > 80% with UI Automation

---

## 🧱 Architecture: Feature-Based Modular Architecture

The Features/ directory is organized using a feature-first approach, where each major functionality (e.g., MovieDetails, SearchMovies, TrendingMoviesList) is isolated and self-contained. Each feature includes:

- ViewModel: Handles state and business logic using ObservableObject.
- §Usecase: Business-specific logic and orchestration of services.
- Service: API or data layer implementations.
- Coordinator: View navigation control.
- View: SwiftUI views, organized by screen.
- Components (optional): Reusable subviews or UI elements.

---

## 📦 Project Structure

```
Watchly/
├── App/
├── Config/
Features/
├── MovieDetails/
│   ├── Components/
│   ├── Coordinator/
│   ├── Service/
│   ├── Usecase/
│   ├── View/
│   └── ViewModel/
│
├── SearchMovies/
│   ├── Components/
│   ├── Coordinator/
│   ├── Service/
│   ├── Usecase/
│   ├── View/
│   └── ViewModel/
│
└── TrendingMoviesList/
|    ├── Coordinator/
|    ├── Service/
|    ├── Usecase/
|    ├── View/
|    └── ViewModel/
├── Frameworks/            # XCFrameworks
├── Resources/
├── Shared/
│   ├── CacheManager/
│   ├── Debounce/
│   ├── FavouriteManager/
│   ├── Loader/
│   ├── NetworkPluggable/
│   └── Router/
├── WatchlyTests/
└── WatchlyUITests/
```

---

## 🧪 Testing

- ✅ Unit Tests: `WatchlyTests/`
- ✅ UI Tests: `WatchlyUITests/`
- Use `⌘ + U` in Xcode or run via CI for automation.

---

## 🧰 Tools & Tech
- Tested on Xcode 6.0 and 6.2
- Min Depolyment Target 16.6
- Swift 5.9+
- SwiftUI + UIKit (interoperability)
- XCTest / XCUITest
- SwiftLint
- XCFrameworks (iOS / tvOS / visionOS)
- Async/Await concurrency (no Combine)

---

## 🚀 Getting Started

```bash
git clone https://github.com/your-org/Watchly.git
open Watchly.xcodeproj
```

No API key is needed has 3 Environments Token is passed through Xcconfig, plug in your TMDB key via `.xcconfig`.

⚠️ Note for Reviewer:

If the project fails to load due to SwiftFormat-related issues, it’s likely caused by a mismatch in SwiftPM manifest evaluation.

I’m using Xcode 16.0 and 16.2, and in some environments (especially with Mint or SwiftFormat via SPM), the Package.swift file may not resolve properly if the wrong SDK (e.g., iPhoneSimulator) is used.

✅ Workaround: If you encounter build issues related to SwiftFormat, try temporarily commenting out the SwiftFormat package reference and proceed with the review. This will not affect the app logic.

Let me know if you need a preformatted version or help setting up SwiftFormat via Homebrew instead of SPM.

---

🙏 Final Note to the Reviewer

Thank you for taking the time to review my submission.

This project reflects my approach to building scalable and testable iOS apps with a focus on clean architecture, modularity, and modern Swift patterns like async/await. I’ve aimed to strike a balance between simplicity and structure, ensuring each feature is independently testable and easy to extend.

I am happy to answer any questions or walk you through specific parts of the code. Looking forward to your feedback!

Warm regards,
Vinsi
