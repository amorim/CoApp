//
//  DestaquesTableViewController.swift
//  CoApp
//
//  Created by Student on 3/8/17.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit
import Kingfisher

class DestaquesTableViewController: UITableViewController {
    var projetos = [Projeto]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.barTintColor = UIColor(netHex: 0x00BCD4)
        tabBarController?.tabBar.unselectedItemTintColor = UIColor(netHex: 0xFFFFFF)
        tabBarController?.tabBar.tintColor = UIColor(netHex: 0x607D8B)

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProjetoDAO.refProj = self;
        ProjetoDAO.get_data_from_url(url: "https://www.amorim.tk:5555/destaques")
        //tableView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func callbackJSon(projetos: [Projeto]) {
        self.projetos = projetos
        tableView.reloadData()
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return projetos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "destaquescell", for: indexPath)

        if let cellDestaque = cell as? DestaquesTableViewCell {
            let p = projetos[indexPath.row]
            if let criador = p.criador {
                cellDestaque.lblCriador.text = criador.name
            }
            else {
                cellDestaque.lblCriador.text = "anon"
            }
            var tags = ""
            for i in p.interesses {
                tags += i.description + ","
            }
            if !tags.isEmpty {
            tags.remove(at: tags.index(before: tags.endIndex))
            }
            cellDestaque.lblTags.text = tags
            cellDestaque.lblNomeProj.text = p.name
            cellDestaque.imgProj.kf.setImage(with: URL(string: p.image)!,
                     placeholder: nil,
                     options: [.transition(ImageTransition.fade(1))])
            cellDestaque.imgProj.layer.masksToBounds = true
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if  segue.identifier == "DestaqueSegue",
            let destination = segue.destination as? DetalheProjetoViewController,
            let idx = tableView.indexPathForSelectedRow?.row
        {
            destination.projeto = projetos[idx]
        }
    }
}
