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

class PixabayJSONFetcher: Fetcher {
    var page: Int = 1 {
        didSet {
            self.service.updateServiceRequestParams(with: String(self.page), for: "page")
        }
    }
    
    init() {
        super.init(with: PixabayImageService())
    }
    
    override func fetch(_ completion: @escaping ([Hit]) -> ()) -> Void  {

        guard let url = URL(string: self.sourceURL) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let pixabayImageJSON = try? newJSONDecoder().decode(PixabayImage.self, from: data)
                self.page += 1
                guard let receivedHits = pixabayImageJSON?.hits else {return}
                completion(receivedHits)
            }
        }.resume()
    }
}
