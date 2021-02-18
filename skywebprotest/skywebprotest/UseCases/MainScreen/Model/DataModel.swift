
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

class DataModel: NSObject {
    
    // MARK: Private properties
    private var receivedhits: [Hit] = [] //contains array of images from Pixabay
//    private var receivedPage: [Hit]? = nil  // contains all hits from one page fetch
    private let jsonFetcher: Fetchable
    private let imageFetcher: ImageFetcher = ImageFetcher()
    
    // MARK: Class initializers and methods
    init(with fetcher: Fetchable) {
        self.jsonFetcher = fetcher
    }
    
    // fetch all image json
    func getData(_ completion: @escaping ([Hit]) -> ()) {
        
        let _ = self.jsonFetcher.fetch({[weak self] jsonHits in
        
            guard let receivedHitPage = jsonHits else {return}
            self?.receivedhits.append(contentsOf: receivedHitPage)
            guard let rec = self?.receivedhits else {return}
            completion(rec)
            
        })
    }
    
    func downloadImages(with urlList: [Int:String], completion: @escaping () -> Void) {
        
        self.imageFetcher.fetch(with: urlList, completion: completion)
    }
}
