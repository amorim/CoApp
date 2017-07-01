//
//  PerfilViewController.swift
//  CoApp
//
//  Created by Student on 3/8/17.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit
import Kingfisher
class PerfilViewController: UIViewController {
    @IBOutlet var viewLogado: UIView!
    @IBOutlet weak var lblNomeUsu: UILabel!
    @IBOutlet weak var dadosCadastro: UIButton!
    @IBOutlet weak var ajustes: UIButton!
    @IBOutlet weak var imagemUser: UIImageView!
    @IBOutlet weak var imagemFundo: UIImageView!
    var usuario: Usuario? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        // Do any additional setup after loading the view.
        
        defaults.setValue(6, forKey: "id")
        let id = defaults.integer(forKey: "id")
        loadOnView(id: id)
        
    }
    func loadOnView(id: Int) {
        UsuarioDAO.refUsuario = self
        UsuarioDAO.get_data_from_url(url: "https://www.amorim.tk:5555/user/\(id)")
        dadosCadastro.layer.cornerRadius = 6
        
        ajustes.layer.cornerRadius = 6
        imagemUser.layer.cornerRadius = 0.5 * imagemUser.bounds.size.width
        imagemUser.layer.masksToBounds = true
        imagemFundo.layer.masksToBounds = true
        imagemFundo.image = UIImage(named: "fundo.jpg")
    }
    public func callbackJSon(usu: Usuario)
    {
        lblNomeUsu.text = usu.name
        imagemUser.kf.setImage(with: URL(string: usu.photo)!,
                    placeholder: nil,
                    options: [.transition(ImageTransition.fade(1))])
        usuario = usu
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if  segue.identifier == "vaiInteressesSegue",
            let destination = segue.destination as? InteressesTableViewController {
            destination.interesses = usuario!.interesses
        }
    }
    
}
