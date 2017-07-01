//
//  NavigatorViewController.swift
//  CoApp
//
//  Created by Student on 3/9/17.
//  Copyright © 2017 Lucas Amorim. All rights reserved.
//

import UIKit

class NavigatorViewController: UIViewController {
    
    var url: String = ""
    
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CoApp Navigator"
        webView.loadRequest(URLRequest(url: URL(string: url)!))
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
