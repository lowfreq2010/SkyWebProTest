import Foundation

struct PixabayImageService: NetworkServiceDescription {
    internal var baseURL: String = "https://pixabay.com/"
    internal var api: String = "api/"
    internal var endpoint: String = ""
    internal var requestParams: RequestParams = [:]
    
    init() {
        let params = ["key" : "20294730-c05284c1853e0f56dff069a0e",
                      "q":"yellow+cat","image_type":"photo","page":"1","lang":"en"]
        self.requestParams = params
    }
}
