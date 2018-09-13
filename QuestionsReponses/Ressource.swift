//
//  Ressource.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import Foundation

struct Ressource: Decodable {
    
    var id: Int?
    var title: String?
    var duration: String?
    var source: String?
    var date: String?
    var author: String?
    var urlaccess: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "titre"
        case duration = "duree"
        case source = "src"
        case date = "date"
        case author = "auteur"
        case urlaccess = "urlacces"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.title = try values.decodeIfPresent(String.self, forKey: .title)
        self.duration = try values.decodeIfPresent(String.self, forKey: .duration)
        self.source = try values.decodeIfPresent(String.self, forKey: .source)
        self.date = try values.decodeIfPresent(String.self, forKey: .date)
        self.author = try values.decodeIfPresent(String.self, forKey: .author)
        self.urlaccess = try values.decodeIfPresent(String.self, forKey: .urlaccess)
    }
    
}
