//
//  Projeto.swift
//  testecomments
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Gloss
class Projeto : Mappable, Glossy {
    
    
    public required init?(json: JSON) {
        
    }

    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var image: String = ""
    var criador: Usuario? = nil
    var usersOnProject: Int = 0
    var interesses: [Interesse] = [Interesse]()
    var usuarios: [Usuario] = [Usuario]()
    init() {
        
    }
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "description" ~~> self.description,
            "image" ~~> self.image,
            "criador" ~~> self.criador,
            "interesses" ~~> self.interesses
            ])
    }

    required init? (map: Map) {
    
    }
    
    
    func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        criador <- map["criador"]
        description <- map["description"]
        usersOnProject <- map["usersOnProject"]
        interesses <- map["interesses"]
        usuarios <- map["usuarios"]
    }
    
    
    
}
class ProjetoDAO {
    static var refProj: UITableViewController? = nil
    static var refAdd: AdicionarViewController? = nil
    static func getProjects(data: Data) {
        do {
            print(String(describing: data))
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let projetos = Mapper<Projeto>().mapArray(JSONArray: json as! [[String : Any]])!
            DispatchQueue.main.async {
                if let refProjj = refProj as? DestaquesTableViewController {
                    refProjj.callbackJSon(projetos: projetos)
                }
                else if let refProjj = refProj as? ProjetosTableViewController {
                    refProjj.callbackJSon(projetos: projetos)
                }
            }
            
            
        } catch {
            print("Error getting Projetos: \(error)")
        }
        
    }

    static func get_data_from_url(url:String)
    {
        var request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        request.httpMethod = "GET"
        
        //var params = ["username":"username", "password":"password"] as Dictionary<String, String>
        
        //request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: [])
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            
            ProjetoDAO.getProjects(data: data!)
            print("Response: \(response)"
                
                
            )})
        task.resume()
    }
    static func SubmeteProjeto(p: Projeto, i: AdicionarViewController) {
        var request = URLRequest(url: URL(string: "https://www.amorim.tk:5555/createProject")!)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        
        //request.httpBody = try? JSONSerialization.data(withJSONObject: p, options: []
        let j = p.toJSON()
        //request.httpBody = p.toJSON()
        request.httpBody = try? JSONSerialization.data(withJSONObject: j!, options: [])
        print(request.httpBody!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            DispatchQueue.main.async {
                if let reffAdd = refAdd {
                reffAdd.completeCallBack()
                }
            }
            
            })
        task.resume()
    }
}
