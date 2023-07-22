# Introduction

Augmented reality, attached using a QR code / horizontal or vertical plane. 
QR code can be removed after the placement of objects or can be sticky to the object.

# Stack

- iOS 16+
- SwiftUI
- ARKit, RealityKit

# Git LFS

We store large files in Git LFS (for example, usdz files)

To install Git LFS follow [instructions](https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage)

To pull Git LFS files after you pull a project itself:

    % git lfs pull

# SwiftLint

To install Swiftlint: 

    % brew install SwiftLint

If you get Permission denied error, do from project folder:

    % chmod 755 scripts/swiftlint.sh
