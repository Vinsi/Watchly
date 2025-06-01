
# 📽️ Watchly – TMDB Movie App

**Watchly** is a modern, modular iOS app built using **Swift**, **SwiftUI**, and **async/await**. It interacts with **The Movie Database (TMDB)** to showcase trending movies, detailed views, and favorites. The architecture is clean, testable, and cross-platform ready with a reusable **XCFramework**.

---

## ✨ Features

- ✅ Trending movie list UI  
- ✅ Movie detail screen with rich metadata  
- ✅ ⭐ **Favorite button** with local persistence  
- ✅ ⚙️ **XCFramework** built for reuse — supports **iOS**, **tvOS**, and **visionOS**  
- ✅ ⏱ **Custom debounce** utility for search & UI responsiveness  
- ✅ 🧠 **LRU cache** support in memory layer  
- ✅ 🌐 **Retry mechanism** on network failure (e.g. no internet)  
- ✅ 🧩 UIKit integration example — **SwiftUI + UIKit interop demo**  
- ✅ ✅ Uses **async/await only** — no Combine dependency  
- ✅ 🧪 Full **unit and UI test coverage**

---

## 🧱 Architecture

- MVVM with modular layering
- Custom `Router` for navigation control
- Shared `ThemeManager`, `FavouritesManager`, and `Loader`
- Built-in debouncer and pagination manager

---

## 📦 Project Structure

```
Watchly/
├── App/
├── Config/
├── Features/
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

No API key is needed when running with stubs; for live mode, plug in your TMDB key via `.xcconfig`.

---

## 📄 License

Licensed under MIT. See `LICENSE.md`.
