// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pixabayImage = try? newJSONDecoder().decode(PixabayImage.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.pixabayImageTask(with: url) { pixabayImage, response, error in
//     if let pixabayImage = pixabayImage {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - PixabayImage
struct PixabayImage: Codable {
    let total: Int
    let totalHits: Int
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.hitTask(with: url) { hit, response, error in
//     if let hit = hit {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Hit
struct Hit: Codable {
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let previewURL: String
    let previewWidth: Int
    let previewHeight: Int
    let webformatURL: String
    let webformatWidth: Int
    let webformatHeight: Int
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
    let imageSize: Int
    let views: Int
    let downloads: Int
    let favorites: Int
    let likes: Int
    let comments: Int
    let userid: Int
    let user: String
    let userImageURL: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case pageURL = "pageURL"
        case type = "type"
        case tags = "tags"
        case previewURL = "previewURL"
        case previewWidth = "previewWidth"
        case previewHeight = "previewHeight"
        case webformatURL = "webformatURL"
        case webformatWidth = "webformatWidth"
        case webformatHeight = "webformatHeight"
        case largeImageURL = "largeImageURL"
        case imageWidth = "imageWidth"
        case imageHeight = "imageHeight"
        case imageSize = "imageSize"
        case views = "views"
        case downloads = "downloads"
        case favorites = "favorites"
        case likes = "likes"
        case comments = "comments"
        case userid = "user_id"
        case user = "user"
        case userImageURL = "userImageURL"
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func pixabayImageTask(with url: URL, completionHandler: @escaping (PixabayImage?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
