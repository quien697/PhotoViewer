//
//  PhotoViewer.swift
//  PhotoViewer
//
//  Created by Quien on 2026-04-17.
//

import SwiftUI

/// A full-screen photo gallery that pages through a set of remote images with a
/// thumbnail strip for quick navigation.
public struct PhotoViewer: View {
  // MARK: - Environment
  @Environment(\.dismiss) private var dismiss

  // MARK: - State
  @Binding private var selectedIndex: Int

  // MARK: - Properties
  private let photos: [String]
  private let highlightColor: Color

  // MARK: - Init
  public init(
    photos: [String],
    selectedIndex: Binding<Int>,
    highlightColor: Color = .accentColor
  ) {
    self.photos = photos
    self._selectedIndex = selectedIndex
    self.highlightColor = highlightColor
  }

  // MARK: - Body
  public var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      TabView(selection: $selectedIndex) {
        ForEach(photos.indices, id: \.self) { index in
          AsyncImage(url: URL(string: photos[index])) { phase in
            switch phase {
            case .success(let image):
              image
                .resizable()
                .aspectRatio(contentMode: .fit)
            default:
              ProgressView()
                .tint(.white)
            }
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
          photos: photos,
          selectedIndex: $selectedIndex,
          highlightColor: highlightColor
        )
      }  // VStack
    }  // ZStack
  }
}

#Preview {
  @Previewable @State var selectedIndex = 0
  PhotoViewer(
    photos: [
      "https://picsum.photos/id/1015/800/600",
      "https://picsum.photos/id/1016/800/600",
      "https://picsum.photos/id/1018/800/600",
    ],
    selectedIndex: $selectedIndex
  )
}
