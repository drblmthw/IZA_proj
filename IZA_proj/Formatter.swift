//
//  Formatter.swift
//  IZA_proj
//
//  Created by Matej Kubový on 10/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import Foundation


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
    
    return tmpDescription
}



func formatDate(date: String, portal: String) -> String {
    
    var tmpDate = ""
    
    // trim whitespaces and newlines
    tmpDate = date.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // get proper date from string
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
    
    // here we have date in structure
    let date = dateFormatter.date(from:tmpDate)!
    
    // get string from date
    dateFormatter.locale = Locale(identifier: "sk")
    dateFormatter.dateFormat = "dd/MM/yy HH:mm"
    tmpDate = dateFormatter.string(from: date)
    
    return tmpDate
    
}


func getMonth(month: String) -> Int {
    switch month {
        case "Jan":
            return 1
        case "Feb":
            return 2
        case "Mar":
            return 3
        case "Apr":
            return 4
        case "May":
            return 5
        case "Jun":
            return 6
        case "Jul":
            return 7
        case "Aug":
            return 8
        case "Sep":
            return 9
        case "Oct":
            return 10
        case "Nov":
            return 11
        case "Dec":
            return 12
        default:
            return 0
    }
}
