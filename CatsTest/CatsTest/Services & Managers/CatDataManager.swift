//
//  DataService.swift
//  CatsTest
//
//  Created by worker on 06.09.2021.
//

import Foundation

final class CatDataManager {
    static let shared = CatDataManager()
    var cats = [CatModel]()
    
    private init() {}
    
    func getCats() {
        CatNetworkService.shared.getCats {(cats) in
            cats.forEach { (cat) in
                let catModel = CatModel(with: cat)
                self.cats.append(catModel)
            }
        }
    }
}
