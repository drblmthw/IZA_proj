//
//  Downloader.swift
//  IZA_proj
//
//  Created by Matej Kubový on 10/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import Foundation

// delegate protocol
protocol XmlDownloaderDelegate {
    func didFinishDownloading(_ sender:XmlParserManager)
}


class XmlParserManager: NSObject, XMLParserDelegate {
    
    // delegate
    var delegate: XmlDownloaderDelegate?
    
    var parser = XMLParser()
    
    var url = URL(string: "https://www.aktuality.sk/rss/")!
    
    private var element = ""
    
    // flags to check if element is inside item and to avoid elements inside image element
    private var is_in_item = false
    private var is_in_image = false
    
    private var n_header = ""
    private var n_description = ""
    private var n_date = ""
    
    private var tempNews: [NewsItem] = []
    
    
    
    func downloadNews() -> Void {
    
        // run async download
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            // clear array
            self.tempNews.removeAll()
            self.parser = XMLParser(contentsOf: self.url)!
            
            self.parser.delegate = self
            self.parser.shouldProcessNamespaces = false
            self.parser.shouldReportNamespacePrefixes = false
            self.parser.shouldResolveExternalEntities = false
            self.parser.parse()
            
            // call didDownloadXml func
            DispatchQueue.main.async {
                self.didDownloadXml()
            }
        }
    }
    
    func didDownloadXml() {
        //
        delegate?.didFinishDownloading(self)
    }
    
    func getNews() -> [NewsItem] {
        // return news list
        return tempNews
    }
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        // set flag if going into image element
        if elementName == "image" {
            is_in_image = true
        }
        
        element = elementName
        
        if element == "item" {
            // clear variables
            n_header = ""
            n_description = ""
            n_date = ""
            
            // is inside item element
            is_in_item = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // skip elements inside image el.
        if is_in_image == true {
            return
        }
        
        if is_in_item == true {
            if element == "title" {
                n_header.append(string)
            }
            
            if element == "description" {
                n_description.append(string)
            }
            
            if element == "pubDate" {
                n_date.append(string)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // set flag if going out of image element
        if elementName == "image" {
            is_in_image = false
        }
        
        if elementName == "item" && is_in_item == true {
            
            // format final output
            n_header = formatHeader(header: n_header, portal: "Aktuality")
            n_description = formatDescription(description: n_description, portal: "Aktuality")
            n_date = formatDate(date: n_date, portal: "Aktuality")
            
            // trim whitespaces
            n_header = n_header.trimmingCharacters(in: .whitespacesAndNewlines)
            n_description = n_description.trimmingCharacters(in: .whitespacesAndNewlines)
            n_date = n_date.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if !n_header.isEmpty {
                let tmp_item = NewsItem(header: n_header, description: n_description, date: n_date, source: "Aktuality")
                tempNews.append(tmp_item)
            }
        }
        
        if elementName == "item" {
            is_in_item = false
        }
    }
    
}






