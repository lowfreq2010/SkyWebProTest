import Foundation
import UIKit

protocol Fetchable: class {
    var sourceURL: String { get set }
    func fetch(_ completion: @escaping ([Hit]?) -> ()) -> Void
}

class Fetcher: Fetchable {
    var sourceURL:String = ""
    var service: NetworkServiceDescription
    
    func fetch(_ completion: @escaping ([Hit]?) -> ()) -> Void {
    }
    
    init(with service:NetworkServiceDescription) {
        self.service = service
        self.sourceURL = self.service.requestURL
    }
}

// Fetch via URLSession class
class PixabayJSONFetcher: Fetcher {
    var page: Int = 1
    
    init() {
        super.init(with: PixabayImageService())
    }
    
    override func fetch(_ completion: @escaping ([Hit]?) -> ()) -> Void  {
        
        guard let url = URL(string: self.sourceURL) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let pixabayImage = try? newJSONDecoder().decode(PixabayImage.self, from: data)
                self.page += 1
                self.service.updateServiceRequestParams(with: String(self.page), for: "page")
                guard let receivedHits = pixabayImage?.hits else {return}
                completion(receivedHits)
            }
        }.resume()
    }
}

//// MARK: - URLSession response handlers
//
//extension URLSession {
//    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completionHandler(nil, response, error)
//                return
//            }
//            let decoded = try? newJSONDecoder().decode(T.self, from: data)
//            completionHandler(decoded, response, nil)
//        }
//    }
//
//    func pixabayImageTask(with url: URL, completionHandler: @escaping (PixabayImage?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
//}


