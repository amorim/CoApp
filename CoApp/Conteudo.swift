//
//  Conteudo.swift
//  CoApp
//
//  Created by Student on 3/9/17.
//  Copyright © 2017 Lucas Amorim. All rights reserved.
//

import Foundation
import ObjectMapper
import Gloss
class Conteudo : Mappable, Glossy {
    var id: Int = 0
    var nome: String = ""
    var criador: Usuario? = nil
    var uri: String = ""
    init() {
        
    }
    public required init?(json: JSON) {
        
    }
    required init?(map: Map) {
        
    }
    func toJSON() -> JSON? {
        return jsonify([
            "nome" ~~> nome,
            "criador" ~~> criador,
            "uri" ~~> uri
            ])
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        nome <- map["nome"]
        criador <- map["criador"]
        uri <- map["uri"]
    }
}

class ConteudoDAO {
    static var refProj: NewsPaperViewControllerTableViewController? = nil
    static var refAdd: AdicionarConteudoViewController? = nil
    static func getConteudo(data: Data) {
        do {
            print(String(describing: data))
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let Conteudos = Mapper<Conteudo>().mapArray(JSONArray: json as! [[String : Any]])!
            DispatchQueue.main.async {
                if let refProjj = refProj {
                    refProjj.callbackJSon(conteudos: Conteudos)
            }
            }
            
            
        } catch {
            print("Error getting Conteudos: \(error)")
        }
        
    }
    
    static func get_data_from_url(url:String)
    {
        var request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            
            ConteudoDAO.getConteudo(data: data!)
            print("Response: \(response)"
                
                
            )})
        task.resume()
    }
    
    static func SubmeteNewsPaper(c: Conteudo, i: AdicionarConteudoViewController) {
        var request = URLRequest(url: URL(string: "https://www.amorim.tk:5555/publishContent")!)
        let session = URLSession.shared
        request.httpMethod = "POST"
        let j = c.toJSON()
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
