//
//  ContentView.swift
//  PhotoViewerDemo
//
//  Created by Quien on 2026-06-06.
//

import PhotoViewer
import SwiftUI

struct ContentView: View {
  enum Source: String, CaseIterable, Identifiable {
    case urls = "URLs"
    case images = "UIImages"
    var id: Self { self }
  }

  @State private var source: Source = .urls
  @State private var selectedIndex = 0
  @State private var isViewing = false

  private let photoURLs = [
    "https://picsum.photos/id/1015/800/600",
    "https://picsum.photos/id/1016/800/600",
    "https://picsum.photos/id/1018/800/600",
    "https://picsum.photos/id/1020/800/600",
  ]

  // SF Symbols are template (black) glyphs, which are invisible on the viewer's
  // black background. Render each onto a colored tile so the UIImage path is
  // actually visible.
  private let images: [UIImage] = [
    ("sun.max.fill", UIColor.systemOrange),
    ("cloud.rain.fill", UIColor.systemBlue),
    ("snowflake", UIColor.systemTeal),
    ("bolt.fill", UIColor.systemPurple),
  ].map { Self.tile(symbol: $0.0, background: $0.1) }

  private static func tile(
    symbol: String,
    background: UIColor,
    size: CGFloat = 600
  ) -> UIImage {
    let bounds = CGRect(x: 0, y: 0, width: size, height: size)
    let config = UIImage.SymbolConfiguration(pointSize: size * 0.4, weight: .semibold)
    let glyph = UIImage(systemName: symbol, withConfiguration: config)?
      .withTintColor(.white, renderingMode: .alwaysOriginal)

    return UIGraphicsImageRenderer(size: bounds.size).image { context in
      background.setFill()
      context.fill(bounds)
      if let glyph {
        let rect = CGRect(
          x: (size - glyph.size.width) / 2,
          y: (size - glyph.size.height) / 2,
          width: glyph.size.width,
          height: glyph.size.height
        )
        glyph.draw(in: rect)
      }
    }
  }

  private var count: Int {
    source == .urls ? photoURLs.count : images.count
  }

  var body: some View {
    NavigationStack {
      VStack(spacing: 24) {
        Picker("Source", selection: $source) {
          ForEach(Source.allCases) { Text($0.rawValue).tag($0) }
        }
        .pickerStyle(.segmented)

        Text("Tap a photo to open the viewer at that index.")
          .font(.footnote)
          .foregroundStyle(.secondary)

        thumbnails

        Spacer()
      }
      .padding()
      .navigationTitle("PhotoViewer Demo")
    }
    .fullScreenCover(isPresented: $isViewing) {
      switch source {
      case .urls:
        PhotoViewer(photos: photoURLs, selectedIndex: $selectedIndex)
      case .images:
        PhotoViewer(images: images, selectedIndex: $selectedIndex)
      }
    }
  }

  // MARK: - Subviews
  private var thumbnails: some View {
    LazyVGrid(
      columns: [GridItem(.adaptive(minimum: 100), spacing: 12)],
      spacing: 12
    ) {
      ForEach(0..<count, id: \.self) { index in
        Button {
          selectedIndex = index
          isViewing = true
        } label: {
          thumbnail(at: index)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .clipShape(.rect(cornerRadius: 12))
        }
        .buttonStyle(.plain)
      }
    }
  }

  @ViewBuilder
  private func thumbnail(at index: Int) -> some View {
    switch source {
    case .urls:
      AsyncImage(url: URL(string: photoURLs[index])) { image in
        image.resizable().scaledToFill()
      } placeholder: {
        Color.gray.opacity(0.2)
      }
    case .images:
      Image(uiImage: images[index])
        .resizable()
        .scaledToFit()
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.15))
    }
  }
}

#Preview {
  ContentView()
}
