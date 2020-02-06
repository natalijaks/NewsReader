//
//  NewsStruct.swift
//  NewsReader
//
//  Created by Natalija Krsnik on 04/02/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
    
    init (status:String, totalResults: Int, articles: [Articles]){
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

struct Articles: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init (source: Source, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?){
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
    
    init (id: String, name: String){
        self.id = id
        self.name = name
    }
}
