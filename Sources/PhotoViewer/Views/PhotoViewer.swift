//
//  PhotoViewer.swift
//  PhotoViewer
//
//  Created by Quien on 2026-04-17.
//

import SwiftUI

/// A full-screen photo gallery that pages through a set of images with a
/// thumbnail strip for quick navigation. Photos can be supplied as remote URLs
/// or as in-memory `UIImage`s.
public struct PhotoViewer: View {
  // MARK: - Environment
  @Environment(\.dismiss) private var dismiss

  // MARK: - State
  @Binding private var selectedIndex: Int

  // MARK: - Properties
  private let sources: [PhotoSource]
  private let highlightColor: Color

  // MARK: - Init
  /// Creates a viewer for remote images referenced by URL string.
  public init(
    photos: [String],
    selectedIndex: Binding<Int>,
    highlightColor: Color = .accentColor
  ) {
    self.init(
      sources: photos.map(PhotoSource.url),
      selectedIndex: selectedIndex,
      highlightColor: highlightColor
    )
  }

  /// Creates a viewer for in-memory images.
  public init(
    images: [UIImage],
    selectedIndex: Binding<Int>,
    highlightColor: Color = .accentColor
  ) {
    self.init(
      sources: images.map(PhotoSource.image),
      selectedIndex: selectedIndex,
      highlightColor: highlightColor
    )
  }

  private init(
    sources: [PhotoSource],
    selectedIndex: Binding<Int>,
    highlightColor: Color
  ) {
    self.sources = sources
    self._selectedIndex = selectedIndex
    self.highlightColor = highlightColor
  }

  // MARK: - Body
  public var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      TabView(selection: $selectedIndex) {
        ForEach(sources.indices, id: \.self) { index in
          PhotoSourceImage(source: sources[index], contentMode: .fit) {
            ProgressView()
              .tint(.white)
          }
          .tag(index)
        }  // ForEach
      }  // TabView
      .tabViewStyle(.page(indexDisplayMode: .never))
      .ignoresSafeArea()

      VStack {
        PhotoViewerHeader(onClose: { dismiss() })

        Spacer()

        PhotoViewerFooter(
          sources: sources,
          selectedIndex: $selectedIndex,
          highlightColor: highlightColor
        )
      }  // VStack
    }  // ZStack
  }
}

#Preview("URLs") {
  @Previewable @State var selectedIndex = 0

  PhotoViewer(
    photos: [
      "https://picsum.photos/id/1015/800/600",
      "https://picsum.photos/id/1016/800/600",
      "https://picsum.photos/id/1018/800/600"
    ],
    selectedIndex: $selectedIndex
  )
}

#Preview("UIImages") {
  @Previewable @State var selectedIndex = 0

  PhotoViewer(
    images: [
      UIImage(systemName: "photo")!,
      UIImage(systemName: "camera")!,
      UIImage(systemName: "star")!
    ],
    selectedIndex: $selectedIndex
  )
}
