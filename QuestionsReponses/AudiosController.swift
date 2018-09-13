//
//  AudiosController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class AudiosController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Ref widgets
    @IBOutlet weak var tableViewAudios: UITableView!
    
    // Ref attributes
    private final var urlAudios = "https://www.levraievangile.org/webservice/audios/questions-reponses/"
    private var audios = [Ressource]()
    private var common:Common!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Audios"
        loadJsonData { (audiosArray) in
            print("Download completed.")
            self.common.hideActivityIndicatorView()
            audiosArray.forEach({ (audio) in
                DispatchQueue.main.async {
                    self.tableViewAudios.reloadData()
                }
                //print(audio.title!)
            })
        }
        self.tableViewAudios.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJsonData(completion: @escaping ([Ressource]) -> Void){
        print("Download in progress .........")
        self.common = Common()
        self.common.showActivityIndicatorView(view: self.view)
        
        let url:URL = URL(string: urlAudios)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "type=Audios"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let audiosArray = try? JSONDecoder().decode([Ressource].self, from: data) else { return print("Failed to decode json data.") }
            self.audios = audiosArray
            completion(audiosArray)
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.audios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewAudios.dequeueReusableCell(withIdentifier: "idAudiosCell") as? AudiosCell else { return UITableViewCell() }
        //cell.labelAudiosTitle.text = audios[indexPath.row].title!
        var tableDuration = (audios[indexPath.row].duration!).components(separatedBy: ":")
        let duration = (Int(tableDuration[0])!*60)+Int(tableDuration[1])!
        //cell.labelAudiosSubTitle.text = "\(duration) min | " + audios[indexPath.row].author!
        return cell.loadDataCell(titleValue: audios[indexPath.row].title!, subTitleValue: "\(duration) min | " + audios[indexPath.row].author!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlAudio = audios[indexPath.row].urlaccess! + audios[indexPath.row].source!
        print("Numéro de l'audio sélectionné : \(indexPath.row)")
        //--
        let audioURL = URL(string: urlAudio)
        let player = AVPlayer(url: audioURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) { playerViewController.player!.play() }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }}
