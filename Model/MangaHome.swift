//
//  ModelMangaJar.swift
//  MangaJar
//
//  Created by Nguyen Tien Quan on 17/03/2023.
//

import UIKit

class MangaHome: NSObject {
    var Popular: [MangaItemModel] = [MangaItemModel]()
    var Recent_added: [MangaItemModel] = [MangaItemModel]()
    var NewTrends: [MangaItemModel] = [MangaItemModel]()
    var FullList: [MangaItemFullList] = [MangaItemFullList]()
    var MangaOfDay: [MangaItemMangaOfDay] = [MangaItemMangaOfDay]()
    var NewChapter: [MangaItemNewChapter] = [MangaItemNewChapter]()
    var NewTrending: [MangaItemNewTrending] = [MangaItemNewTrending]()
    var TopMangaUpdate: [MangaItemTopUpdate] = [MangaItemTopUpdate]()
    
    func initLoad(_ json: [String: Any]) -> MangaHome {
        if let popular = json["Popular"] as? [[String:Any]]{
            for item in popular{
                var itemPopular: MangaItemModel = MangaItemModel()
                itemPopular = itemPopular.initLoad(item)
                Popular.append(itemPopular)
            }
        }
        if let recently = json["Recently_added"] as? [[String:Any]]{
            for item in recently{
                var itemRecent: MangaItemModel = MangaItemModel()
                itemRecent = itemRecent.initLoad(item)
                Recent_added.append(itemRecent)
            }
        }
        if let newsTrend = json["new_trending"] as? [[String:Any]]{
            for item in newsTrend{
                var itemTrend: MangaItemModel = MangaItemModel()
                itemTrend = itemTrend.initLoad(item)
                NewTrends.append(itemTrend)
            }
        }
        if let fullList = json["full_list"] as? [[String:Any]]{
            for item in fullList{
                var itemFullList: MangaItemFullList = MangaItemFullList()
                itemFullList = itemFullList.initLoadFullList(item)
                FullList.append(itemFullList)
            }
        }
        if let magaOfDay = json["manga_of_the_day"] as? [[String:Any]]{
            for item in magaOfDay{
                var itemOfDay: MangaItemMangaOfDay = MangaItemMangaOfDay()
                itemOfDay = itemOfDay.initLoadMangaOfDay(item)
                MangaOfDay.append(itemOfDay)
            }
        }
        if let newChapter = json["new_chapter"] as? [[String:Any]]{
            for item in newChapter{
                var itemNewChapter: MangaItemNewChapter = MangaItemNewChapter()
                itemNewChapter = itemNewChapter.initLoadNewChapter(item)
                NewChapter.append(itemNewChapter)
            }
        }
        if let newTrending = json["new_trending"] as? [[String:Any]]{
            for item in newTrending{
                var itemNewTrending: MangaItemNewTrending = MangaItemNewTrending()
                itemNewTrending = itemNewTrending.initLoadNewTrending(item)
                NewTrending.append(itemNewTrending)
            }
        }
        if let topUpdate = json["top_manga_update"] as? [[String:Any]]{
            for item in topUpdate{
                var itemTopUpdate: MangaItemTopUpdate = MangaItemTopUpdate()
                itemTopUpdate = itemTopUpdate.initLoadTopUpdate(item)
                TopMangaUpdate.append(itemTopUpdate)
            }
        }
        return self
    }
}
class MangaItemModel: NSObject{
    var chapter_name: String = ""
    var link_chapter: String = ""
    var manga_link: String = ""
    var manga_poster: String = ""
    var manga_title: String = ""

    func initLoad(_ json: [String: Any]) -> MangaItemModel {
        if let temp = json["chapter_name"] as? String { chapter_name = temp }
        if let temp = json["link_chapter"] as? String { link_chapter = temp }
        if let temp = json["manga_link"] as? String { manga_link = temp }
        if let temp = json["manga_poster"] as? String { manga_poster = temp }
        if let temp = json["manga_title"] as? String { manga_title = temp }
        return self
    }
}

class MangaItemFullList: NSObject{
    var link: String = ""
    func initLoadFullList(_ json: [String: Any]) -> MangaItemFullList {
        if let temp = json["link"] as? String { link = temp }
        return self
    }
}

class MangaItemMangaOfDay: NSObject{
    var linkMangaDay: String = ""
    var posterManga: String = ""
    var titleMangaDay: String = ""
    
    func initLoadMangaOfDay(_ json: [String: Any]) -> MangaItemMangaOfDay {
        if let temp = json["link_manga_day"] as? String { linkMangaDay = temp }
        if let temp = json["poster_manga"] as? String { posterManga = temp }
        if let temp = json["title_manga_day"] as? String { titleMangaDay = temp }
        return self
    }
}

class MangaItemNewChapter: NSObject{
    var chapter: String = ""
    var date: String = ""
    var linkNew: String = ""
    var manga: String = ""
    
    func initLoadNewChapter(_ json: [String: Any]) -> MangaItemNewChapter {
        if let temp = json["chapter"] as? String { chapter = temp }
        if let temp = json["date"] as? String { date = temp }
        if let temp = json["link_new"] as? String { linkNew = temp }
        if let temp = json["manga"] as? String { manga = temp }
        return self
    }
}

class MangaItemNewTrending: NSObject{
    var chapter_name: String = ""
    var link_chapter: String = ""
    var manga_link: String = ""
    var manga_poster: String = ""
    var manga_title: String = ""

    func initLoadNewTrending(_ json: [String: Any]) -> MangaItemNewTrending {
        if let temp = json["chapter_name"] as? String { chapter_name = temp }
        if let temp = json["link_chapter"] as? String { link_chapter = temp }
        if let temp = json["manga_link"] as? String { manga_link = temp }
        if let temp = json["manga_poster"] as? String { manga_poster = temp }
        if let temp = json["manga_title"] as? String { manga_title = temp }
        return self
    }
}

class MangaItemTopUpdate: NSObject{
    var chapter_name: String = ""
    var link_chapter: String = ""
    var manga_link: String = ""
    var manga_poster: String = ""
    var manga_title: String = ""

    func initLoadTopUpdate(_ json: [String: Any]) -> MangaItemTopUpdate {
        if let temp = json["chapter_name"] as? String { chapter_name = temp }
        if let temp = json["link_chapter"] as? String { link_chapter = temp }
        if let temp = json["manga_link"] as? String { manga_link = temp }
        if let temp = json["manga_poster"] as? String { manga_poster = temp }
        if let temp = json["manga_title"] as? String { manga_title = temp }
        return self
    }
}
