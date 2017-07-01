//
//  Interesse.swift
//  testecomments
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import ObjectMapper
import Gloss
class Interesse : Mappable, Glossy {
    var id: Int = 0
    var description: String = ""
    
    public required init?(json: JSON) {
        
    }
    required init?(map: Map) {

    }
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "description" ~~> description
            ])
    }
    init(id: Int, description: String) {
        self.id = id
        self.description = description
    }
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
    }
}

class InteresseDAO {
    static var refInt: InteressesTableViewController? = nil
    
    static func getConteudo(data: Data) {
        do {
            print(String(describing: data))
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let interesses = Mapper<Interesse>().mapArray(JSONArray: json as! [[String : Any]])!
            DispatchQueue.main.async {
                if let refIntt = refInt {
                    refIntt.callbackJSon(interesses: interesses)
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
            
            
            InteresseDAO.getConteudo(data: data!)
            print("Response: \(response)"
                
                
            )})
        task.resume()
    }
    

}
