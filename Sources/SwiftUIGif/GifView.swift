//
//  GifView.swift
//  SwiftUIProva
//
//  Created by e-voluzione on 15/09/2020.
//

import SwiftUI

struct GifView: View {
  class ImageSourceProvider {
    var source: CGImageSource?
    var numberOfFrames: Int?
    var name: String
    var delay: Double

    init(name: String, delay: Double) {
      self.name = name
      self.delay = delay
      self.source = imageSource(named: name)
      self.numberOfFrames = frameCount()
    }

    private func imageSource(named imageName: String) -> CGImageSource? {
      guard let bundleURL = Bundle.main.url(forResource: imageName, withExtension: "gif"),
            let imageData = try? Data(contentsOf: bundleURL) else {
        print("Cannot turn image named \"\(imageName)\" into NSData")
        return nil
      }

      let gifOptions = [
        kCGImageSourceShouldAllowFloat as String : true as NSNumber,
        kCGImageSourceCreateThumbnailWithTransform as String : true as NSNumber,
        kCGImageSourceCreateThumbnailFromImageAlways as String : true as NSNumber
      ] as CFDictionary

      guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, gifOptions) else {
        debugPrint("Cannot create image source with data!")
        return nil
      }

      return imageSource
    }

    func frameCount() -> Int {
      if let source = source {
        return CGImageSourceGetCount(source)
      }

      return 0
    }

    func frame(at index: Int) -> Image? {
      guard let imageSource = source,
            let cgImageRef = CGImageSourceCreateImageAtIndex(imageSource, index, nil) else {
        return nil
      }
      return Image(cgImageRef, scale: 1.0, label: Text(""))
    }
  }

  @State var currentFrame = 0
  @State var direction = false
  var provider: ImageSourceProvider

  var body: some View {
    //Image("\(name)\(currentFrame)")
    provider.frame(at: currentFrame)?
      .resizable()
      .onReceive(Timer.publish(every: provider.delay, on: .main, in: .common).autoconnect()) { _ in
        if self.direction {
          self.currentFrame = (self.currentFrame == 0) ? self.provider.numberOfFrames! - 1 : self.currentFrame - 1
        } else {
          self.currentFrame = (self.currentFrame + 1 ) % self.provider.numberOfFrames!
        }
      }
  }
}

//struct GifViewModifier: ViewModifier {
//  typealias Body = GifView
//
//  func body(content: Content) -> GifView {
//
//  }
//}
//
//extension GifView {
//  func reversed() -> GifView {
//    return GifView(name: self.name,
//                   numberOfFrames: self.numberOfFrames,
//                   delay: self.delay,
//                   updateFunction: { $0 = $0 == 0 ? $1 : ($0 - 1) })
//  }
//}
