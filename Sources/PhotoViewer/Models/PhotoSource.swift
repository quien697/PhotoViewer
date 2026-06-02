//
//  PhotoSource.swift
//  PhotoViewer
//
//  Created by Quien on 2026-06-02.
//

import UIKit

/// A single photo the viewer can display, either a remote image referenced by
/// URL string or an in-memory `UIImage`.
enum PhotoSource {
  case url(String)
  case image(UIImage)
}
