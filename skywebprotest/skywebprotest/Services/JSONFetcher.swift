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
        let params = ["key" : "20294730-c05284c1853e0f56dff069a0",
                      "q":"yellow+cat","image_type":"photo","page":"1","lang":"en"]
        super.init(with: PixabayImageService(with: params))
    }
    
    override func fetch(_ completion: @escaping ([Hit]?) -> ()) -> Void  {
        
        guard let url = URL(string: self.sourceURL) else {return}
        let task = URLSession.shared.pixabayImageTask(with: url) { pixabayImage, response, error in
            guard let pixabayImage = pixabayImage else {return}
            self.page += 1
            self.service.updateServiceRequestParams(with: String(self.page), for: "page")
            let receivedHits: [Hit] = pixabayImage.hits
            completion(receivedHits)
           }
           task.resume()
    }
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


