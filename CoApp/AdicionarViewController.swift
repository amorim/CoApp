//
//  AdicionarViewController.swift
//  CoApp
//
//  Created by Lucas Amorim on 09/03/17.
//  Copyright © 2017 Lucas Amorim. All rights reserved.
//

import UIKit
import ImagePicker
import Cloudinary
class AdicionarViewController: UIViewController, ImagePickerDelegate {

    @IBOutlet weak var txtNomeProj: UITextField!
    
    @IBOutlet weak var txtDescricao: UITextField!
    
    @IBOutlet weak var imgProj: UIImageView!
    var alert : UIAlertController? = nil
    var interesses = [Interesse]()
    @IBAction func addProj(_ sender: Any) {
        if txtNomeProj.text != nil {
            if txtDescricao.text != nil {
                if imgProj.image != nil {
                    let alert = UIAlertController(title: nil, message: "Aguarde...", preferredStyle: .alert)
                    
                    alert.view.tintColor = UIColor.black
                    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
                    loadingIndicator.hidesWhenStopped = true
                    loadingIndicator.activityIndicatorViewStyle = .gray
                    loadingIndicator.startAnimating();
                    
                    alert.view.addSubview(loadingIndicator)
                    self.alert = alert
                    present(alert, animated: true, completion: nil)
                    uploadImage()
                    return
                }
            }
        }
    }
    func uploadCallBack(str: String) {
        let p = Projeto()
        p.name = txtNomeProj.text!
        p.description = txtDescricao.text!
        p.image = str
        p.interesses = interesses
        let usu = Usuario()
        let defaults = UserDefaults.standard
        defaults.setValue(6, forKey: "id")
        let id = defaults.integer(forKey: "id")
        usu.id = id
        p.criador = usu
        ProjetoDAO.SubmeteProjeto(p: p, i: self)
    }
    func completeCallBack() {
        
        
        if let allert = alert {
            allert.dismiss(animated: false, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
        
    }
    func uploadImage() {
        let imgData: Data = UIImagePNGRepresentation(imgProj.image!)!
        let config = CLDConfiguration(cloudName: "coapp", apiKey: "117371276712673", apiSecret: "Z3Z7m8397a5h_zxG6uaRSr-HUFU", secure: true)
        let cld = CLDCloudinary(configuration: config)
        let progressHandler = { (progress: Progress) in
            print(String("Uploading to Cloudinary: \(Int(progress.fractionCompleted * 100))%")!)
        }
        cld.createUploader().upload(data: imgData, uploadPreset: "dpa3078n", progress: progressHandler) { (result, error) in
            if let error = error {
                print("Error uploading image %@", error)
            } else {
                if let result = result, let publicId = result.publicId {
                    print(publicId)
                    self.uploadCallBack(str: "http://res.cloudinary.com/coapp/image/upload/\(publicId)")
                }
            }
        }
    }
    @IBAction func selectImage() {
        let imagePickerController = ImagePickerController()
        imagePickerController.imageLimit = 1
       imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProjetoDAO.refAdd = self
        // Do any additional setup after loading the view.
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        print("wrapper")
    }

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imgProj.image = images[0]
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "interesseSegue",
            let destination = segue.destination as? InteressesTableViewController {
            destination.controller = self
        }
    }
    

}
