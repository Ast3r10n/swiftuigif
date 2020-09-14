//
//  GifView.swift
//  SwiftUIProva
//
//  Created by e-voluzione on 15/09/2020.
//

import SwiftUI

struct GifView: View {
  var name: String
  var numberOfFrames: Int
  var delay: Double = 0.2
  @State private var currentFrame = 0

  fileprivate var updateFunction: ((inout Int, Int) -> Void)?

  var body: some View {
    Image("\(name)\(currentFrame)")
      .resizable()
      .onReceive(Timer.publish(every: delay,
                               on: .main,
                               in: .common)
                  .autoconnect()) { _ in
        if let updateFunction = updateFunction {
          updateFunction(&currentFrame, numberOfFrames)
        } else {
          currentFrame = (currentFrame + 1) % numberOfFrames
        }
      }
  }
}

extension GifView {
  func reversed() -> GifView {
    return GifView(name: self.name,
                   numberOfFrames: self.numberOfFrames,
                   delay: self.delay,
                   updateFunction: { $0 = $0 == 0 ? $1 : ($0 - 1) })
  }
}
