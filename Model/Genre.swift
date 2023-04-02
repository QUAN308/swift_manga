//
//  Genre.swift
//  MangaJar
//
//  Created by Nguyen Tien Quan on 22/03/2023.
//

import UIKit

class Genre: NSObject {
    var DataGenre: [ModelGenre] = [ModelGenre]()
    func initLoad(_ json: [[String:Any]]) -> Genre {
        for item in json {
            var itemGenre: ModelGenre = ModelGenre()
            itemGenre = itemGenre.initLoad(item)
            DataGenre.append(itemGenre)
        }
        return self
    }

}
class ModelGenre: NSObject {
    var link_genre: String = ""
    var name_genre: String = ""
    var number: String = ""
    
    func initLoad(_ json: [String: Any]) -> ModelGenre {
        if let temp = json["link_genre"] as? String { link_genre = temp }
        if let temp = json["name_genre"] as? String { name_genre = temp }
        if let temp = json["number"] as? String { number = temp }
        return self
    }
}
