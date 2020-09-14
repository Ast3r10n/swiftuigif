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

  var body: some View {
    Image("\(name)\(currentFrame)")
      .resizable()
      .onReceive(Timer.publish(every: delay,
                               on: .main,
                               in: .common)
                  .autoconnect()) { _ in
        currentFrame = (currentFrame + 1) % numberOfFrames
      }
  }
}
