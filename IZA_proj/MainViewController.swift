//
//  ViewController.swift
//  IZA_proj
//
//  Created by Matej Kubový on 09/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import UIKit

// to ensure proper animation when cell is displayed
var loadAnim = false


class MainViewController: UIViewController, UISearchBarDelegate, XMLParserDelegate, XmlDownloaderDelegate {
    
    // create array for all news
    var news: [NewsItem] = []
    // create array for filtered/searched news
    var filteredNews: [NewsItem] = []
    
    var parser: XmlParserManager?
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResults: UILabel!
    
    
    // reloads data when reload icon is pressed
    @IBAction func reloadData(_ sender: Any) {
        // scroll table to first row and hide it
        self.mainTableView.setContentOffset(.zero, animated: false)
        self.mainTableView.isHidden = true
        
        // show ActivityIndicator while getting data
        self.activityIndicator.startAnimating()
        
        // reset searchbox
        searchBar.text = ""
        searchBar.endEditing(true)
        
        // download data
        parser?.downloadNews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate for search bar
        searchBar.delegate = self
        // this removes ugly borders?
        searchBar.backgroundImage = UIImage()
        
        
        // set delegate and data source for TableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
        // set table properties and hide
        self.mainTableView.rowHeight = 155
        self.mainTableView.isHidden = true
        
        // show ActivityIndicator while getting data
        self.activityIndicator.startAnimating()
        
        // new object
        parser = XmlParserManager()
        
        // set parser delegate
        parser?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // reload data on every appearence event
        self.mainTableView.setContentOffset(.zero, animated: false)
        self.mainTableView.isHidden = true
        // show ActivityIndicator while getting data
        self.activityIndicator.startAnimating()
        searchBar.text = ""
        searchBar.endEditing(true)
        // async download news
        parser?.downloadNews()
    }
    
    func didFinishDownloading(_ sender: XmlParserManager) {
        
        // get news
        news = sender.getNews()
        filteredNews = filterNews(news: news)
        
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.mainTableView.isHidden = false
            
        // to start table load animation
        loadAnim = true
        self.mainTableView.reloadData()
            
        // loadAnim is set to false after reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { loadAnim = false })
    }
    
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // hide keyboard when "Search" hitted
        searchBar.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // dynamic search in news while typing
        filteredNews = searchNews(news: news, key: searchBar.text ?? "")
        
        // if no results, show label displaying it
        if filteredNews.count == 0 {
            noResults.isHidden = false
            mainTableView.isHidden = true
        } else {
            noResults.isHidden = true
            mainTableView.isHidden = false
            self.mainTableView.setContentOffset(.zero, animated: false)
            mainTableView.reloadData()
        }
    }
    
    
    // to pass data to PageViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // set var to selected TableCell (see tableView didSelectRow)
        if segue.identifier == "MainToNavigation" {
            
            let destVC = segue.destination as! UINavigationController
            let targetC = destVC.topViewController as! PageViewController
            
            targetC.newsUrl = sender as? URL
        }
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = filteredNews[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        cell.setItem(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // if row is selected, select newsItem to pass
        let newsLink = filteredNews[indexPath.row].link
        let newsUrl = URL(string: newsLink)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "MainToNavigation", sender: newsUrl)
         
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // animation -  on load gradualy appear
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
                withDuration: 0.1,
                delay: 0,
                animations: {
                    cell.alpha = 1
                }
            )
        }
    }
}
