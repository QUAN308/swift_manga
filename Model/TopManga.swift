//
//  TopManga.swift
//  MangaJar
//
//  Created by Nguyen Tien Quan on 21/03/2023.
//

import UIKit

class TopManga: NSObject {
    var DataTopManga: [ModelTopManga] = [ModelTopManga]()
    func initLoad(_ json: [String:Any]) -> TopManga {
        if let ListItem = json["list_item"] as? [[String:Any]]{
            for item in ListItem{
                var itemList: ModelTopManga = ModelTopManga()
                itemList = itemList.initLoad(item)
                DataTopManga.append(itemList)
            }
        }
        return self
    }

}

class ModelTopManga: NSObject {
    var card_genres_item_1: String = ""
    var card_genres_item_2: String = ""
    var card_text: String = ""
    var chapter: String = ""
    var link_chapter: String = ""
    var link_detail: String = ""
    var link_poster: String = ""
    var number_chapter: String = ""
    var time_update: String = ""
    var title_manga: String = ""
    
    func initLoad(_ json: [String: Any]) -> ModelTopManga {
        if let temp = json["card-genres-item_1"] as? String { card_genres_item_1 = temp }
        if let temp = json["card-genres-item_2"] as? String { card_genres_item_2 = temp }
        if let temp = json["card-text"] as? String { card_text = temp }
        if let temp = json["chapter"] as? String { chapter = temp }
        if let temp = json["link-chapter"] as? String { link_chapter = temp }
        if let temp = json["link_detail"] as? String { link_detail = temp }
        if let temp = json["link_poster"] as? String { link_poster = temp }
        if let temp = json["number-chapter"] as? String { number_chapter = temp }
        if let temp = json["title_manga"] as? String { title_manga = temp }
        if let temp = json["time_update"] as? String { time_update = temp }
        return self
    }
}
