//
//  ProductDetailViewModel.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 03/08/2023.
//

import ARKit
import Combine
import Foundation
import RealityKit

@MainActor
final class ProductDetailViewModel: NSObject, ObservableObject {
    @Published var isShowingCameraView = false
    @Published var product: Product
    @Published var isLoading = false

    var progress: Double {
        product.progress
    }

    private var download: Download?
    private let model = Model.shared

    private lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
    }()

    init(product: Product) {
        self.product = product
    }

    /*
    @MainActor
    func fetchARModel() async throws {
        guard let url = URL(string: AppConstants.baseURL + product.modelFileName) else {
            print("Error: invalid AR model URL")
            return
        }

        do {
            let tuple = try await URLSession.shared.download(from: url)
            let destinationURL = tuple.0
            let newURL = destinationURL.deletingPathExtension().appendingPathExtension("usdz")
            try FileManager.default.moveItem(at: destinationURL, to: newURL)

            model.entity = try Entity.load(contentsOf: newURL)
            print("Model loaded")

            // Show CameraView, it will setup ARView with a scene / entity in Model
            isShowingCameraView = true
        } catch {
            print("Failed to load entity. Error: \(error)")
        }
    }
    */

    func downloadFileTapped() {
        Task {
            if FileManager.default.fileExists(atPath: product.savedModelFileURL.path()) {
                loadARModel()
            } else {
                try? await fetchARModel()
            }
        }
    }

    @MainActor
    func fetchARModel() async throws {
        guard download == nil, let modelUrl = product.modelUrl else { return }

        let download = Download(url: modelUrl, downloadSession: downloadSession)
        self.download = download
        product.isDownloading = true
        for await event in download.events {
            process(event)
        }
        self.download = nil

        loadARModel()

        product.isDownloading = false
    }

    func pauseDownload() {
        download?.pause()
        product.isDownloading = false
    }

    func resumeDownload() {
        download?.resume()
        product.isDownloading = true
    }
}

private extension ProductDetailViewModel {
    func process(_ event: Download.Event) {
        switch event {
        case let .progress(current, total):
            product.update(currentBytes: current, totalBytes: total)
        case let .success(url):
            saveFile(at: url)
        }
    }

    func saveFile(at url: URL) {
        let fileManager = FileManager.default
        try? fileManager.moveItem(at: url, to: product.savedModelFileURL)
    }

    func loadARModel() {
        do {
            model.entity = try Entity.load(contentsOf: product.savedModelFileURL)
            print("Model loaded")

            // Show CameraView, it will setup ARView with a scene / entity in Model
            isShowingCameraView = true
        } catch {
            print("Failed to load entity. Error: \(error)")
        }
    }
}
