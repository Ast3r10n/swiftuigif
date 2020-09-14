# SwiftUIGif

A GIF utility package for SwiftUI.

## Installation

### Swift Package Manager

Add a Swift Package Dependency to your project with URL:
```
https://github.com/Ast3r10n/swiftuigif
```

## Usage

Append the frame number to the image frame names, as such:
*gifName0, gifName1, gifName2...*

Initialise a `GifView`, specifying the root name of the images, the number of frames and the delay between each frame.

```swift
GifView(name: "gifName", numberOfFrames: 5, delay: 0.3)
```
