# PhotoViewer

![iOS](https://img.shields.io/badge/iOS-26-blue.svg) ![Swift](https://img.shields.io/badge/Swift-6-orange.svg) ![SwiftUI](https://img.shields.io/badge/SwiftUI-brightgreen.svg) ![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg) ![Xcode](https://img.shields.io/badge/Xcode-26.5-blue) ![License](https://img.shields.io/badge/license-MIT-green)

A lightweight SwiftUI view for browsing photos full-screen on iOS, from remote URLs or in-memory images.



## 📝 Overview

1. A reusable SwiftUI component for viewing a gallery of photos, distributed via Swift Package Manager.
2. Accepts photos as remote URLs or in-memory `UIImage`s through two matching initializers.
3. Pages through photos full-screen with a swipeable, paged `TabView`.
4. Provides a thumbnail strip that scrolls to and highlights the selected photo.
5. Built with pure SwiftUI and no third-party dependencies.



## 📸 Screenshots

<table>
  <tr>
    <th>Gallery</th>
    <th>Full-screen viewer</th>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/quien697/PhotoViewer/main/Screenshots/photo_viewer-url_tab.png" alt="Gallery with remote URL photos" width="260"></td>
    <td><img src="https://raw.githubusercontent.com/quien697/PhotoViewer/main/Screenshots/photo_viewer-url_viewer.png" alt="Full-screen viewer for a remote URL photo" width="260"></td>
  </tr>
  <tr>
    <td colspan="2"><em>Remote URLs — tap a thumbnail to open the photo full-screen with a swipeable thumbnail strip.</em></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/quien697/PhotoViewer/main/Screenshots/photo_viewer-uiimage_tab.png" alt="Gallery with in-memory UIImages" width="260"></td>
    <td><img src="https://raw.githubusercontent.com/quien697/PhotoViewer/main/Screenshots/photo_viewer-uiimage_viewer.png" alt="Full-screen viewer for an in-memory UIImage" width="260"></td>
  </tr>
  <tr>
    <td colspan="2"><em>In-memory <code>UIImage</code>s — the same viewer, driven by decoded images.</em></td>
  </tr>
</table>



## ✨ Features

1. **Flexible sources** — supply photos as remote URLs (`[String]`) or in-memory images (`[UIImage]`).
2. **Paged browsing** — swipe horizontally to move between full-screen photos.
3. **Thumbnail strip** — tap a thumbnail to jump to its photo; the strip auto-scrolls to keep the selection centered.
4. **Async loading** — remote images load via `AsyncImage` with progress and placeholder states.
5. **Customizable highlight** — tint the selected thumbnail's outline with any color.
6. **Simple API** — a single `PhotoViewer` driven by a `selectedIndex` binding.



## 🛠️ Technologies & Frameworks

- iOS 26
- Swift 6
- SwiftUI
- Swift Package Manager - distribution



## 🔧 Development Tools

- Xcode 26.5
- Icons: [SF Symbols](https://developer.apple.com/sf-symbols/)
- Version control: GitHub / Git
- AI tools: [Claude Code](https://claude.com/claude-code)



## 📦 Installation

### Swift Package Manager

In Xcode, go to **File → Add Package Dependencies…** and enter the repository URL:

```
https://github.com/quien697/PhotoViewer.git
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/quien697/PhotoViewer.git", from: "1.0.0")
]
```

Then add the product to your target:

```swift
.target(
    name: "YourApp",
    dependencies: ["PhotoViewer"]
)
```



## 💻 Usage

Present `PhotoViewer` full-screen (for example, in a `fullScreenCover`) with the photo URLs and a binding to the selected index.

```swift
import PhotoViewer
import SwiftUI

struct ContentView: View {
    @State private var selectedIndex = 0
    @State private var isViewing = false

    let photos = [
        "https://example.com/photo-1.jpg",
        "https://example.com/photo-2.jpg",
    ]

    var body: some View {
        // ...
        .fullScreenCover(isPresented: $isViewing) {
            PhotoViewer(photos: photos, selectedIndex: $selectedIndex)
        }
    }
}
```

Already have decoded images? Use the `UIImage` initializer instead:

```swift
PhotoViewer(images: uiImages, selectedIndex: $selectedIndex)
```

To match your app's accent, pass a custom `highlightColor` for the selected thumbnail outline (defaults to `.accentColor`):

```swift
PhotoViewer(photos: photos, selectedIndex: $selectedIndex, highlightColor: .orange)
```



## 📂 Folder Structure

```text
PhotoViewer/
└─ Sources/
   └─ PhotoViewer/
      ├─ Models/         # PhotoSource
      └─ Views/          # PhotoViewer, PhotoViewerHeader, PhotoViewerFooter, PhotoSourceImage
```



## 🚀 Getting Started

Add the package to your project (see [Installation](#-installation)) and present `PhotoViewer` (see [Usage](#-usage)).



## 👨‍💻 Author

**Tsung-Hsun Liu**  
📧 [quien697@gmail.com](mailto:quien697@gmail.com)  
🌐 [tsunghsun.me](https://www.tsunghsun.me)



## 📄 License

MIT License © 2026 Tsung-Hsun Liu
