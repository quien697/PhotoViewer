//
//  PhotoSourceImage.swift
//  PhotoViewer
//
//  Created by Quien on 2026-06-02.
//

import CachedAsyncImage
import SwiftUI

/// Renders a `PhotoSource`, loading remote URLs asynchronously and showing
/// `placeholder` while a URL is loading or fails.
struct PhotoSourceImage<Placeholder: View>: View {
  let source: PhotoSource
  let contentMode: ContentMode
  @ViewBuilder let placeholder: () -> Placeholder

  var body: some View {
    switch source {
    case .url(let string):
      GeometryReader { proxy in
        CachedAsyncImage(url: URL(string: string), targetSize: proxy.size) { phase in
          if case .success(let image) = phase {
            image
              .resizable()
              .aspectRatio(contentMode: contentMode)
          } else {
            placeholder()
          }
        }
      }
    case .image(let uiImage):
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: contentMode)
    }
  }
}
