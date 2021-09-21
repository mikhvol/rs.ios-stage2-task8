import UIKit

final class CatModel {
    var name = "defaultName"
    var description = "defaultDescription"
    var origin = "defaultCountry"
    var JSONimage = CatJSONImage()
    var image: UIImage! = UIImage(named: "cat.jpg")
    var isFavorite = false
    
    init(with catJSONModel: CatJSONModel) {
        let cat = catJSONModel
        
        guard let name = cat.name else { return }
        guard let description = cat.description else { return }
        guard let image = cat.image else { return }
        guard let origin = cat.origin else { return }
        
        self.name = name
        self.description = description
        self.origin = origin
        self.JSONimage = image
    }
}
