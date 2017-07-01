///
//  ProjetosTableViewController.swift
//  CoApp
//
//  Created by Student on 3/8/17.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit
import Kingfisher
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class ProjetosTableViewController: UITableViewController {
    var projetos = [Projeto]()
    let searchController = UISearchController(searchResultsController: nil)
    var projetosFiltrados = [Projeto]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProjetoDAO.refProj = self;
        ProjetoDAO.get_data_from_url(url: "https://www.amorim.tk:5555/projects")
    }
    func callbackJSon(projetos: [Projeto]) {
        self.projetos = projetos
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
        return projetosFiltrados.count
        }
        return projetos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projidentifier", for: indexPath)

        if let cellProj = cell as? ProjetoTableViewCell {
            let p: Projeto
            if searchController.isActive && searchController.searchBar.text != "" {
                p = projetosFiltrados[indexPath.row]
            }
            else {
                p = projetos[indexPath.row]
            }
            
            if let criador = p.criador {
                cellProj.lblCriador.text = criador.name
            }
            else {
                cellProj.lblCriador.text = "anon"
            }
            var tags = ""
            for i in p.interesses {
                tags += i.description + ","
            }
            if !tags.isEmpty {
            tags.remove(at: tags.index(before: tags.endIndex))
            }
            cellProj.lblInteresses.text = tags
            cellProj.lblNome.text = p.name
            cellProj.imgProj.kf.setImage(with: URL(string: p.image)!,
                                             placeholder: nil,
                                             options: [.transition(ImageTransition.fade(1))])
            cellProj.imgProj.layer.masksToBounds = true
        }


        return cell
    }
    
    func filterContent(for searchText: String, scope: String = "All") {
        projetosFiltrados = projetos.filter({ projeto in
            if (projeto.name.lowercased().contains(searchText.lowercased())) {
                return true
            }
            for i in projeto.interesses {
                if i.description.lowercased().contains(searchText.lowercased()) {
                    return true
                }
            }
            return false
        })
        
        tableView.reloadData()
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
        if  segue.identifier == "ProjetoSegue",
            let destination = segue.destination as? DetalheProjetoViewController,
            let idx = tableView.indexPathForSelectedRow?.row
        {
            if searchController.isActive && searchController.searchBar.text != "" {
            destination.projeto = projetosFiltrados[idx]
            }
            else {
                destination.projeto = projetos[idx]
            }
        }

    }
    

}
extension ProjetosTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(for: searchController.searchBar.text!)
    }
}
