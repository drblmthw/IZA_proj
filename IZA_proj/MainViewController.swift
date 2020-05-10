//
//  ViewController.swift
//  IZA_proj
//
//  Created by Matej Kubový on 09/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, XMLParserDelegate {
    
    // create array for news
    var news: [NewsItem] = []
    
    // XmlParserManager instance/object/variable.
    let myParser = XmlParserManager()
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate and data source for TableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
        // set table properties and hide
        self.mainTableView.rowHeight = 140
        self.mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.mainTableView.isHidden = true
        
        // show ActivityIndicator while getting data
        self.activityIndicator.startAnimating()
        
        // download news
        news = getNews()
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.mainTableView.isHidden = false
            
            // to start animation
            loadAnim = true
            self.mainTableView.reloadData()
            
            // loadAnim is set to false after reloadData() (both are in main thread queue)
            DispatchQueue.main.asyncAfter(deadline: 1, execute: { loadAnim = false })
        })

    }

}

// global var to ensure proper animation
var loadAnim = false

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        cell.setItem(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        if loadAnim == true {
            UIView.animate(
                withDuration: 0.7,
                delay: 0.1 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
                }
            )
        } else {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                animations: {
                    cell.alpha = 1
                }
            )
        }
    }
}
