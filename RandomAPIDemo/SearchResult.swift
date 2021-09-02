//
//  SearchResult.swift
//  RandomAPIDemo
//
//  Created by 李世文 on 2021/9/1.
//

import Foundation

struct SearchResult: Decodable {
    let results: [User]
    let info: Info
}

struct User: Decodable {
    let name: Name
    let location: Location
    let email: String
    let dob: Dob
    let phone: String
    let picture: Picture
    
    struct Name: Decodable{
        let title: String
        let first: String
        let last: String
    }
    
    struct Location: Decodable {
        let street: Street
        let city: String
        
        struct Street: Decodable {
            let number: Int
            let name: String
        }
    }
    
    struct Dob: Decodable {
        let date: Date
        let age: Int
        var dateString: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter.string(from: date)
        }
    }
    
    struct Picture: Decodable {
        let large: URL
        let medium: URL
        let thumbnail: URL
    }
}

struct Info: Decodable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}




