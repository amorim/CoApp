//
//  NewsPaperViewControllerTableViewController.swift
//  CoApp
//
//  Created by Student on 3/9/17.
//  Copyright © 2017 Lucas Amorim. All rights reserved.
//

import UIKit

class NewsPaperViewControllerTableViewController: UITableViewController {
    var conteudos = [Conteudo]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        ConteudoDAO.refProj = self
        super.viewWillAppear(animated)
        ConteudoDAO.get_data_from_url(url: "https://www.amorim.tk:5555/conteudo")
        //tableView.isHidden = true
    }
    func callbackJSon(conteudos: [Conteudo]) {
        self.conteudos = conteudos
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return conteudos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newspaperIdentifier", for: indexPath)

        // Configure the cell...
        if let cellContent = cell as? NewsPaperCellTableViewCell {
            let c = conteudos[indexPath.row]
            cellContent.lblNome.text = c.nome
            cellContent.lblUrl.text = c.uri
            cellContent.lblCriador.text = c.criador!.name
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
        if  segue.identifier == "newspaperSegue",
            let destination = segue.destination as? NavigatorViewController,
            let idx = tableView.indexPathForSelectedRow?.row
        {
            destination.url = conteudos[idx].uri
        }
    }
    

}
