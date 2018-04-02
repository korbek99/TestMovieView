//
//  ViewControllerTop.swift
//  PruebasCencosudDemo
//
//  Created by Jose David Bustos H on 26-03-18.
//  Copyright © 2018 Jose David Bustos H. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerTop: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    final let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=34738023d27013e6d1b995443764da44"
    let pathWebpicture = "http://image.tmdb.org/t/p/w500/"
    
  //  @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var dobArray = [String]()
    var imgURLArray = [String]()
    var imgURLArrayPost = [String]()
    var overviews  = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJsonWithURL()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func downloadJsonWithURL() {
        let url = NSURL(string: urlString)
        // print(urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "results"))
                
                if let actorArray = jsonObj!.value(forKey: "results") as? NSArray {
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            if let name = actorDict.value(forKey: "title") {
                                self.nameArray.append(name as! String)
                            }
                            if let name = actorDict.value(forKey: "original_language") {
                                self.dobArray.append(name as! String)
                            }
                            if let name = actorDict.value(forKey: "poster_path") {
                                self.imgURLArray.append(String(self.pathWebpicture) + String(name as! String))
                            }
                            if let name = actorDict.value(forKey: "overview") {
                                self.overviews.append(name as! String)
                            }
                            
                            if let name = actorDict.value(forKey: "backdrop_path") {
                                self.imgURLArrayPost.append(String(self.pathWebpicture) + String(name as! String))
                            }
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        }).resume()
    }
    
    
    func downloadJsonWithTask() {
        
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(jsonData)
            
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.dobLabel.text = dobArray[indexPath.row]
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.imgView.image = UIImage(data: data as! Data)
        }
        
        return cell
    }
    
    ///for showing next detailed screen with the downloaded info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.imageString = imgURLArray[indexPath.row]
        vc.imageStringPost = imgURLArrayPost[indexPath.row]
        vc.nameString = nameArray[indexPath.row]
        vc.dobString = dobArray[indexPath.row]
        vc.overString = overviews[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


