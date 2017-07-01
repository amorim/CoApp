//
//  DetalheProjetoViewController.swift
//  CoApp
//
//  Created by Lucas Amorim on 08/03/17.
//  Copyright © 2017 Lucas Amorim. All rights reserved.
//

import UIKit
import Kingfisher
import MessageUI

class DetalheProjetoViewController: UIViewController, MFMailComposeViewControllerDelegate {
    var projeto: Projeto? = nil
    
    
    @IBOutlet weak var imgProj: UIImageView!
    
    @IBOutlet weak var btnParticipantes: UIButton!
    
    @IBOutlet weak var btnPedir: UIButton!
    
    @IBAction func sendEmail() {
        let projetoo = projeto!
        let emailTitle = "Participação no projeto " + projetoo.name
        let messageBody = "Olá, " + projetoo.criador!.name + "!\nGostaria de participar do seu projeto!\n\nPara aprovar o cadastro"
        let toRecipents = [projetoo.criador!.email]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.present(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure: \(error)")        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var lblCriador: UILabel!
    @IBOutlet weak var lblDescricao: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let proj = projeto!
        self.title = proj.name
        lblDescricao.lineBreakMode = .byWordWrapping
        lblDescricao.numberOfLines = 0;
        lblCriador.text = "Admin do Projeto: " + proj.criador!.name
        lblDescricao.text = proj.description
        imgProj.kf.setImage(with: URL(string: proj.image)!,
                            placeholder: nil,
                            options: [.transition(ImageTransition.fade(1))])
        imgProj.layer.masksToBounds = true
        btnParticipantes.layer.cornerRadius = 6
        btnPedir.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "usuariosSegue",
            let destination = segue.destination as? UsuariosTableViewController {
            destination.usuarios = projeto!.usuarios
        }
    }
    

}
