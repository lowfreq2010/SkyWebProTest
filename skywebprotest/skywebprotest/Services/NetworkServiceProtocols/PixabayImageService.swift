
import Foundation

struct PixabayImageService: NetworkServiceDescription {
    var serviceKey: String = "20294730-c05284c1853e0f56dff069a0e"
    var baseURL: String = "https://pixabay.com/"
    var api: String = "api/"
    var endpoint: String = ""
    var requestParams: RequestParams
    
    init(with params:RequestParams) {
        self.requestParams = params
    }
}
