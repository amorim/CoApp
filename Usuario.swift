//
//  Usuario.swift
//  testecomments
//
//  Created by Student on 3/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import ObjectMapper
import Gloss
class Usuario : Mappable, Glossy {
    var id: Int = 0
    var name: String = ""
    var photo: String = ""
    var bgPhoto: String = ""
    var email: String = ""
    var interesses: [Interesse] = [Interesse]()
    
    init() {
        
    }
    required init?(json: JSON) {
        
    }

    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            ])
    }

    required init?(map: Map) {
        
    }
        func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]
        photo <- map["photo"]
        bgPhoto <- map["bgPhoto"]
        email <- map["email"]
        interesses <- map["interesses"]
    }
    
}

class UsuarioDAO {
    static var refUsuario: PerfilViewController? = nil
    
    static func getUsuario(data: Data) {
        do {
            print(String(describing: data))
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let usu = Mapper<Usuario>().map(JSON: json as! [String : Any])
            DispatchQueue.main.async {
                if let refProjj = refUsuario {
                    refProjj.callbackJSon(usu: usu!)
                }
            }
            
            
        } catch {
            print("Error getting Usuario: \(error)")
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
            
            
            UsuarioDAO.getUsuario(data: data!)
            print("Response: \(response)"
                
                
            )})
        task.resume()
    }

}
