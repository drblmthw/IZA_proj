//
//  PageViewController.swift
//  IZA_proj
//
//  Created by Matej Kubový on 11/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class PageViewController: UIViewController, WKNavigationDelegate {
    
    // to pass item from MainView
    var newsUrl: URL?
    
    
    @IBOutlet weak var webview: WKWebView!
    
    @IBAction func doneBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard (newsUrl != nil) else {
            return
        }
        
        let myurlreq = URLRequest(url: newsUrl!)
        
        webview.load(myurlreq)
        webview.allowsBackForwardNavigationGestures = true

    }
    

}
