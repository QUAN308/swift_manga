//
//  HomeViewController.swift
//  MangaJar
//
//  Created by Nguyen Tien Quan on 23/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var HistoryCollection: UICollectionView!
    @IBOutlet weak var HomeCollection: UICollectionView!
    @IBOutlet weak var NewBiesCollection: UICollectionView!
    @IBOutlet weak var ReadEditorCollection: UICollectionView!
    @IBOutlet weak var GenreHotCollection: UICollectionView!
    @IBOutlet weak var CompletedCollection: UICollectionView!
    
    @IBOutlet weak var MoreGenre: UILabel!
    var dataHome = MangaHome()
    var dataGenre = Genre()
    var dataCompleted = TopManga()
    
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
//    MoreGenre.addGestureRecognizer(tapGesture)
//    MoreGenre.isUserInteractionEnabled = true
//    @objc func labelTapped() {
//        // Thực hiện việc chuyển trang tại đây
//        let viewController = MyViewController()
//        navigationController?.pushViewController(viewController, animated: true)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeCollection.register(UINib(nibName: "CellHome", bundle: nil), forCellWithReuseIdentifier: "CellHome")
        HistoryCollection.register(UINib(nibName: "CellHistory", bundle: nil), forCellWithReuseIdentifier: "CellHistory")
        NewBiesCollection.register(UINib(nibName: "CellForNewbie", bundle: nil), forCellWithReuseIdentifier: "CellForNewbie")
        ReadEditorCollection.register(UINib(nibName: "CellReadEditor", bundle: nil), forCellWithReuseIdentifier: "CellReadEditor")
        GenreHotCollection.register(UINib(nibName: "CellGenreHot", bundle: nil), forCellWithReuseIdentifier: "CellGenreHot")
        CompletedCollection.register(UINib(nibName: "CellCompletedClassics", bundle: nil), forCellWithReuseIdentifier: "CellCompletedClassics")
        
        APIService.shared.GetTopManga() { [weak self] (response, error) in
            if let mangaData = response {
                self?.dataCompleted = mangaData
                self?.CompletedCollection.reloadData()
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        
        APIService.shared.GetHomeManga() { [weak self] (response, error) in
            if let mangaData = response {
                self?.dataHome = mangaData
                self?.HomeCollection.reloadData()
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        APIService.shared.GetHomeManga() { [weak self] (response, error) in
            if let mangaData = response {
                self?.dataHome = mangaData
                self?.HistoryCollection.reloadData()
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        APIService.shared.GetHomeManga() { [weak self] (response, error) in
            if let mangaData = response {
                self?.dataHome = mangaData
                self?.ReadEditorCollection.reloadData()
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        APIService.shared.GetHomeManga() { [weak self] (response, error) in
            if let mangaData = response {
                self?.dataHome = mangaData
                self?.NewBiesCollection.reloadData()
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        APIService.shared.GetGenre() { [weak self] (response, error) in
            if let mangaData = response {
                self?.dataGenre = mangaData
                self?.GenreHotCollection.reloadData()
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == NewBiesCollection {
            return 2
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == HomeCollection {
            return dataHome.NewTrending.count
        }
        if collectionView == NewBiesCollection {
            return dataHome.Popular.count
        }
        if collectionView == ReadEditorCollection {
            return dataHome.TopMangaUpdate.count
        }
        if collectionView == HistoryCollection {
            return dataHome.Recent_added.count
        }
        if collectionView == GenreHotCollection {
            return dataGenre.DataGenre.count
        }
        if collectionView == CompletedCollection {
            return dataCompleted.DataTopManga.count
        }
        return 0;
    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == HistoryCollection {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellHistory", for: indexPath) as! CellHistory
                let manga = dataHome.Recent_added[indexPath.row]
                cell.titleHistory.text = manga.manga_title
                cell.chapterHistory.text = manga.chapter_name
                
                let url = URL(string: manga.manga_poster)
                let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        let image = UIImage(data: data)
                        cell.imageHistory.image = image
                    }
                }
                task.resume()
                return cell
            }
            if collectionView == NewBiesCollection {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForNewbie", for: indexPath) as! CellForNewbie
                let manga = dataHome.Popular[indexPath.row]
                cell.titleNewbie.text = manga.manga_title
                cell.descriptNewbie.text = manga.manga_link
                let url = URL(string: manga.manga_poster)
                let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        let image = UIImage(data: data)
                        cell.imageNewbie.image = image
                    }
                }
                task.resume()
                return cell
            }
            if collectionView == ReadEditorCollection {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellReadEditor", for: indexPath) as! CellReadEditor
                let manga = dataHome.TopMangaUpdate[indexPath.row]
                cell.titleReadEditor.text = manga.manga_title
                if manga.manga_poster != "" {
                    let url = URL(string: manga.manga_poster)
                    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            let image = UIImage(data: data)
                            cell.imageReadEditor.image = image
                        }
                    }
                    task.resume()
                }
                return cell
            }
            if collectionView == HomeCollection {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellHome", for: indexPath) as! CellHome
                let manga = dataHome.NewTrending[indexPath.row]
                let url = URL(string: manga.manga_poster)
                if manga.manga_poster == ""{
                    return cell
                }else if manga.manga_poster != "" {
                    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            let image = UIImage(data: data)
                            cell.imageCellHome.image = image
                        }
                    }
                    task.resume()
                }
                return cell
            }
            if collectionView == CompletedCollection {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCompletedClassics", for: indexPath) as! CellCompletedClassics
                let manga = dataCompleted.DataTopManga[indexPath.row]
                cell.TitleClassics.text = manga.title_manga
                cell.UpdateClassics.text = manga.time_update
                let url = URL(string: manga.link_poster)
                if manga.link_poster == ""{
                    return cell
                }else if manga.link_poster != "" {
                    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            let image = UIImage(data: data)
                            cell.ImageClassics.image = image
                        }
                    }
                    task.resume()
                }
                return cell
            }
            if collectionView == GenreHotCollection {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellGenreHot", for: indexPath) as! CellGenreHot
                let manga = dataGenre.DataGenre
                let item = manga[indexPath.row]
                cell.titleGenreHot.setTitle(item.name_genre, for: .normal)
                return cell
            }
            return UICollectionViewCell() // trả về cell rỗng
            }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == HomeCollection{
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
                return CGSize(width: UIScreen.main.bounds.width/8 - 10, height: 150)
            }else{
                let width = Int(collectionView.bounds.size.width/3 - 10 )
                return CGSize(width: width, height: 200)
            }
        }
        if collectionView == NewBiesCollection{
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
                return CGSize(width: UIScreen.main.bounds.width/8 - 10, height: 150)
            }else{
                let width = Int(collectionView.bounds.size.width/2 - 10 )
                return CGSize(width: width, height: 130)
            }
        }
        if collectionView == ReadEditorCollection{
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
                return CGSize(width: UIScreen.main.bounds.width/8 - 10, height: 150)
            }else{
                let width = Int(collectionView.bounds.size.width/4 - 10 )
                return CGSize(width: width, height: 200)
            }
        }
        if collectionView == GenreHotCollection{
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
                return CGSize(width: UIScreen.main.bounds.width/8 - 10, height: 150)
            }else{
                let width = Int(collectionView.bounds.size.width/2 - 10 )
                return CGSize(width: width, height: 50)
            }
        }
        if collectionView == HistoryCollection {
            let width = Int(collectionView.bounds.size.width/3 - 10 )
            return CGSize(width: width, height: 200)
        }
        if collectionView == CompletedCollection {
            let width = Int(collectionView.bounds.size.width/3 - 10 )
            return CGSize(width: width, height: 200)
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if collectionView == HomeCollection {
//            return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
//        }
//        if collectionView == HistoryCollection {
//            return UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
//        }
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
}
