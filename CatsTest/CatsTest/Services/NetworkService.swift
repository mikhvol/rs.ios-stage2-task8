import Foundation
import UIKit

class NetworkService {
    let catApiBaseUrl = "https://api.thecatapi.com"
    let apiKey = "55c2df8b-09bb-4576-aec6-92ed7fafaa2d"
    var imageCache = NSCache<NSString, UIImage>()
    var cats = [Cat]()
    
    static let shared = NetworkService()
    
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
                    guard let data = data else { return }
                    guard let image = UIImage(data: data) else { return }
                    
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getCatBreeds(completion: @escaping ([Cat]) -> ()) {
        
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
            
            do {
                guard let breeds = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] else { return }
                
                for cat in breeds {
                    let name = cat["name"] as? String ?? "No name found"
                    let image = cat["image"] as? [String : Any] ?? ["No image" : "image not found"]
                    let imageUrl = image["url"] as? String ?? "No url found"
                    let cat = Cat(name: name, imageUrl: imageUrl)
                    self.cats.append(cat)
                }
                completion(self.cats)
            } catch {
                debugPrint("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
