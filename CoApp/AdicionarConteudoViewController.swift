//
//  AdicionarConteudoViewController.swift
//  CoApp
//
//  Created by Lucas Amorim on 10/03/17.
//  Copyright © 2017 Lucas Amorim. All rights reserved.
//

import UIKit

class AdicionarConteudoViewController: UIViewController {

    @IBOutlet weak var lblNome: UITextField!
    
    @IBOutlet weak var txtUri: UITextField!
    
    var alert : UIAlertController? = nil
    
    @IBAction func addConteudo(_ sender: Any) {
        if lblNome.text != nil {
            if txtUri.text != nil {
                let alert = UIAlertController(title: nil, message: "Aguarde...", preferredStyle: .alert)
                
                alert.view.tintColor = UIColor.black
                let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.activityIndicatorViewStyle = .gray
                loadingIndicator.startAnimating();
                
                alert.view.addSubview(loadingIndicator)
                self.alert = alert
                present(alert, animated: true, completion: nil)
                
                let c = Conteudo()
                c.nome = lblNome.text!
                c.uri = txtUri.text!
                c.criador = Usuario()
                let defaults = UserDefaults.standard
                defaults.setValue(6, forKey: "id")
                let id = defaults.integer(forKey: "id")
                c.criador!.id = id
                ConteudoDAO.SubmeteNewsPaper(c: c, i: self)
                
            }
        }
    }
    
    func completeCallBack() {
        if let allert = alert {
            allert.dismiss(animated: false, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ConteudoDAO.refAdd = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
