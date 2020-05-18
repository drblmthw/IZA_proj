//
//  Formatter.swift
//  IZA_proj
//
//  Created by Matej Kubový on 10/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import Foundation


extension String {
    /// Converts HTML string to a `NSAttributedString`
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}


func formatHeader(header: String, portal: String) -> String {
    
    var tmpHeader = ""
    
    // trim whitespaces and newlines
    tmpHeader = header.trimmingCharacters(in: .whitespacesAndNewlines)
    
    return tmpHeader
}



func formatDescription(description: String, portal: String) -> String {
    
    var tmpDescription = description
    
    // remove <img> from description
    if let startIndex = description.range(of: "<br/>")?.upperBound {
        // if found, crop the description
        tmpDescription = String(description[startIndex...])
    }
    
    // trim whitespaces and newlines
    tmpDescription = tmpDescription.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // decode HTML string
    if let result = tmpDescription.htmlAttributedString?.string {
        tmpDescription = result
    }
    
    return tmpDescription
}



func formatDate(date: String, portal: String) -> String {
    
    var tmpDate = ""
    
    // trim whitespaces and newlines
    tmpDate = date.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // get proper date from string
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if(portal == "Pravda") {
        //has different pubDate format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    } else {
        // default date format
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
    }
    
    // here we have date in structure
    let date = dateFormatter.date(from:tmpDate)!
    
    if date < Date(timeIntervalSinceNow: -86400) {
        // filter last 24h
        return ""
    }
        
    
    // get string from date
    dateFormatter.locale = Locale(identifier: "sk")
    dateFormatter.dateFormat = "dd/MM/yy HH:mm"
    tmpDate = dateFormatter.string(from: date)

    return tmpDate
    
}


func formatLink(link: String, portal: String) -> String {

    var tmpLink = ""
    
    // trim whitespaces and newlines
    tmpLink = link.trimmingCharacters(in: .whitespacesAndNewlines)
    
    return tmpLink
}

