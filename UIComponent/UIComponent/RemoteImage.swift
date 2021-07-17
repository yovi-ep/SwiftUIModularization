//
//  RemoteImage.swift
//  UIComponent
//
//  Created by Yovi Eka Putra on 27/06/21.
//

import SwiftUI

private var imageCache: [String: Data] = [:]

public struct RemoteImage: View {
    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    
    private enum LoadState {
        case loading, success, failure
    }
    
    public init(
        url: String,
        loading: Image = Image(systemName: "photo"),
        failure: Image = Image(systemName: "multiply.circle")
    ) {
        self._loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            if (imageCache.contains(where: { $0.key == url})) {
                self.data = imageCache[url]!
                self.state = .success
            } else {
                guard let parsedURL = URL(string: url) else {
                    fatalError("Invalid URL: \(url)")
                }

                DispatchQueue.global(qos: .background).async {
                    URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                        if let data = data, data.count > 0 {
                            imageCache[url] = data
                            self.data = data
                            self.state = .success
                        } else {
                            self.state = .failure
                        }

                        DispatchQueue.main.async {
                            self.objectWillChange.send()
                        }
                    }.resume()
                }
            }
        }
    }

    public var body: some View {
        selectImage()
            .resizable()
    }
    
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
