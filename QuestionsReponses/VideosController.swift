//
//  VideosController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideosController: UITableViewController {
    
    // Ref widgets
    @IBOutlet weak var tableViewVideos: UITableView!
    
    // Ref attributes
    private final var urlVideos = "https://www.levraievangile.org/webservice/videos/questions-reponses/"
    private var videos = [Ressource]()
    private var common:Common!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vidéos"
        loadJsonData { (videosArray) in
            print("Download completed.")
            self.common.hideActivityIndicatorView()
            videosArray.forEach({ (video) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //print(video.title!)
            })
        }
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJsonData(completion: @escaping ([Ressource]) -> Void){
        print("Download in progress .........")
        self.common = Common()
        self.common.showActivityIndicatorView(view: self.view)
        
        let url:URL = URL(string: urlVideos)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "type=Videos"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let videosArray = try? JSONDecoder().decode([Ressource].self, from: data) else { return print("Failed to decode json data.") }
            self.videos = videosArray
            completion(videosArray)
        }
        task.resume()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "idVideosCell") as? VideosCell else { return UITableViewCell() }
        //cell.labelVideosTitle.text = videos[indexPath.row].title!
        var tableDuration = (videos[indexPath.row].duration!).components(separatedBy: ":")
        let duration = (Int(tableDuration[0])!*60)+Int(tableDuration[1])!
        //cell.labelVideosSubTitle.text = "\(duration) min | " + videos[indexPath.row].author!
        return cell.loadDataCell(titleValue: videos[indexPath.row].title!, subTitleValue: "\(duration) min | " + videos[indexPath.row].author!)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlVideo = videos[indexPath.row].urlaccess! + videos[indexPath.row].source!
        print("Numéro de la vidéo sélectionnée : \(indexPath.row) : "+urlVideo)
        //--
        let videoURL = URL(string: urlVideo)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) { playerViewController.player!.play() }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
