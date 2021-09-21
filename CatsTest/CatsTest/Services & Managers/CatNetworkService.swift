import Foundation
import UIKit

final class CatNetworkService {
    let catApiBaseUrl = "https://api.thecatapi.com"
    let apiKey = "55c2df8b-09bb-4576-aec6-92ed7fafaa2d"
    var imageCache = NSCache<NSString, UIImage>()
    var cats = [CatJSONModel]()
    
    static let shared = CatNetworkService()
    
    private init() {}
    
    func downloadImageWithCache(url: String, completion: @escaping (UIImage) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        if let cachedImage = self.imageCache.object(forKey: url.absoluteString as NSString) {
                completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    debugPrint(error.localizedDescription)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    debugPrint("Server error")
                    return
                }
                
                DispatchQueue.global().async { [weak self] in
                    guard let self = self else { return }
                    guard let data = data else { return }
                    guard let image = UIImage(data: data) else { return }
                    
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getCats(completion: @escaping ([CatJSONModel]) -> ()) {
        
        guard let url = URL(string: catApiBaseUrl + "/v1/breeds") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(self.apiKey, forHTTPHeaderField: "x-api-key")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let cats = try? JSONDecoder().decode([CatJSONModel].self, from: data) else { return }
            completion(cats)
        }
        task.resume()
    }
}
