//
//  APIService.swift
//  Bai1LamQuenJSON
//
//  Created by hehehe on 6/23/20.
//  Copyright © 2020 hehehe. All rights reserved.
//

import UIKit

typealias ApiCompletion = (_ data: Any?, _ error: Error?) -> ()

typealias ApiParam = [String: Any]

enum ApiMethod: String {
    case GET = "GET"
    case POST = "POST"
}
extension String {
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}

extension Dictionary {
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            if value is String {
                let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
                return "\(percentEscapedKey)=\(percentEscapedValue)"
            }
            else {
                return "\(percentEscapedKey)=\(value)"
            }
        }
        return parameterArray.joined(separator: "&")
    }
}
class APIService:NSObject {
    static let shared: APIService = APIService()

    func requestSON(_ url: String,
                    param: ApiParam?,
                    method: ApiMethod,
                    loading: Bool,
                    completion: @escaping ApiCompletion)
    {
        var request:URLRequest!
        
        // set method & param
        if method == .GET {
            if let paramString = param?.stringFromHttpParameters() {
                request = URLRequest(url: URL(string:"\(url)?\(paramString)")!)
            }
            else {
                request = URLRequest(url: URL(string:url)!)
            }
        }
        else if method == .POST {
            request = URLRequest(url: URL(string:url)!)
            
            // content-type
            let headers: Dictionary = ["Content-Type": "application/json"]
            request.allHTTPHeaderFields = headers
            
            do {
                if let p = param {
                    request.httpBody = try JSONSerialization.data(withJSONObject: p, options: .prettyPrinted)
                }
            } catch { }
        }
        
        request.timeoutInterval = 30
        request.httpMethod = method.rawValue
        
        //
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                // check for fundamental networking error
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }
                
                // check for http errors
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200, let res = response {
                }
                
                if let resJson = self.convertToJson(data) {
                    completion(resJson, nil)
                }
                else if let resString = String(data: data, encoding: .utf8) {
                    completion(resString, error)
                }
                else {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    private func convertToJson(_ byData: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: byData, options: [])
        } catch {
            //            self.debug("convert to json error: \(error)")
        }
        return nil
    }
    //http://api.mangageek.net/comics/features?package_name=net.mangamaster.super&version_code=200&version_name=1.2.0.0&channel=google&sign=6e02c5f1e43cc41efe3b13655f2094c7&platform=android&lang=en&country=US&sim=us
    
    func GetHomeManga(closure: @escaping (_ response: MangaHome?, _ error: Error?) -> Void) {
        requestSON("http://14.225.7.179:19883/home", param: nil, method: .GET, loading: true) { (data, error) in
            if let dataHome = data as? [String: Any] {
                var listComicReturn:MangaHome = MangaHome()
                listComicReturn = listComicReturn.initLoad(dataHome)
                closure(listComicReturn, nil)
            }
            else {
                closure(nil,nil)
            }
        }
    }
    func GetTopManga(closure: @escaping (_ response: TopManga?, _ error: Error?) -> Void) {
        requestSON("http://14.225.7.179:19883/home/topmanga", param: nil, method: .GET, loading: true) { (data, error) in
            if let data = data as? [String: Any] {
                var listComicReturn:TopManga = TopManga()
                listComicReturn = listComicReturn.initLoad(data)
                closure(listComicReturn, nil)
            }
            else {
                closure(nil,nil)
            }
        }
    }
    func GetGenre(closure: @escaping (_ response: Genre?, _ error: Error?) -> Void) {
        requestSON("http://14.225.7.179:19883/home/genre", param: nil, method: .GET, loading: true) { (data, error) in
            if let data = data as? [[String: Any]] {
                var listComicReturn:Genre = Genre()
                listComicReturn = listComicReturn.initLoad(data)
                closure(listComicReturn, nil)
            }
            else {
                closure(nil,nil)
            }
        }
    }
}
