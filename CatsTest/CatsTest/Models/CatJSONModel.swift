struct CatJSONModel: Codable {
    var adaptability : Int?
    var affection_level : Int?
    var alt_names : String?
    var cfa_url : String?
    var child_friendly : Int?
    var country_code : String?
    var country_codes : String?
    var description : String?
    var dog_friendly : Int?
    var energy_level : Int?
    var experimental : Int?
    var grooming : Int?
    var hairless : Int?
    var health_issues : Int?
    var hypoallergenic : Int?
    var id : String?
    var image : CatJSONImage?
    var indoor : Int?
    var intelligence : Int?
    var lap : Int?
    var life_span : String?
    var name : String?
    var natural : Int?
    var origin : String?
    var rare : Int?
    var reference_image_id : String?
    var rex : Int?
    var shedding_level : Int?
    var short_legs : Int?
    var social_needs : Int?
    var stranger_friendly : Int?
    var suppressed_tail : Int?
    var temperament : String?
    var vcahospitals_url : String?
    var vetstreet_url : String?
    var vocalisation : Int?
    var weight : CatJSONWeight?
    var wikipedia_url : String?
}

struct CatJSONImage: Codable {
    var height : Int?
    var id : String?
    var url : String?
    var width : Int?
}

struct CatJSONWeight: Codable {
    var imperial : String?
    var metric : String?
}
