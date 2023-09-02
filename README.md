# Introduction

Augmented reality, attached using a QR code / horizontal or vertical plane. 
QR code can be removed after the placement of objects or can be sticky to the object.

# Screenshots

![]<img src="https://github.com/wzbozon/ViewInAR/blob/master/Screenshots/1.jpg?raw=true"  width="200px">  |  ![]<img src="https://github.com/wzbozon/ViewInAR/blob/master/Screenshots/2.jpg?raw=true"  width="200px"> |  ![]<img src="https://github.com/wzbozon/ViewInAR/blob/master/Screenshots/3.jpg?raw=true"  width="200px"> |  ![]<img src="https://github.com/wzbozon/ViewInAR/blob/master/Screenshots/4.jpg?raw=true"  width="200px"> |  ![]<img src="https://github.com/wzbozon/ViewInAR/blob/master/Screenshots/5.jpg?raw=true"  width="200px">

# Videos

[<img src="https://github.com/wzbozon/ViewInAR/blob/master/Screenshots/video1.jpg?raw=true" width="200px">](https://youtube.com/shorts/bZ8h5qPIa7s?feature=share)

[<img src="https://github.com/wzbozon/ViewInAR/blob/master/Screenshots/video2.jpg?raw=true" width="200px">](https://youtu.be/xp0ouvnIxxk)

# Features

- View 3D model in AR, position relative to QR code or horizontal plane, QR code can be removed after placement
- Load 3D animated model from usdz or reality file, from server or from local files
- Display a list of products, choose a product and load a 3D model for it from server, loading progress is displayed
- iPhone & iPad are supported
- Model can be animated

# Stack

- iOS 16+
- SwiftUI
- ARKit, RealityKit
- Unit tests (coverage > 80%)

# Git LFS

Large files are stored in Git LFS (for example, usdz files)

To install Git LFS follow [instructions](https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage)

To pull Git LFS files after you pull a project itself:

    % git lfs pull

# SwiftLint

To install Swiftlint: 

    % brew install SwiftLint

If you get Permission denied error, do from project folder:

    % chmod 755 scripts/swiftlint.sh
