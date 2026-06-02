//
//  PhotoViewerFooter.swift
//  PhotoViewer
//
//  Created by Quien on 2026-04-18.
//

import SwiftUI

/// The bottom thumbnail strip of `PhotoViewer`; tapping a thumbnail selects its
/// photo and the selected one is outlined with `highlightColor`.
struct PhotoViewerFooter: View {
  let sources: [PhotoSource]
  @Binding var selectedIndex: Int
  let highlightColor: Color

  var body: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 6) {
          ForEach(sources.indices, id: \.self) { index in
            PhotoSourceImage(source: sources[index], contentMode: .fill) {
              Color.gray.opacity(0.3)
            }
            .frame(width: 60, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(
                  selectedIndex == index ? highlightColor : Color.clear,
                  lineWidth: 2
                )
            )
            .onTapGesture {
              withAnimation { selectedIndex = index }
            }
            .id(index)
          }  // ForEach
        }  // HStack
        .padding()
      }  // ScrollView
      .onChange(of: selectedIndex) { _, newValue in
        withAnimation {
          proxy.scrollTo(newValue, anchor: .center)
        }
      }
    }  // ScrollViewReader
  }
}

#Preview {
  PhotoViewerFooter(
    sources: [],
    selectedIndex: .constant(0),
    highlightColor: .accentColor
  )
}
