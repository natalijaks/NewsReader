//
//  SingleArticleVC.swift
//  NewsReader
//
//  Created by Natalija Krsnik on 05/02/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class SingleArticleVC: UIViewController {
    
    @IBOutlet var lblSource: UILabel!
    @IBOutlet var txtViewContent: UITextView!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblAuthor: UILabel!
    @IBOutlet var imgSingleArticle: UIImageView!
    
    var articleInfo: [Articles] = []
    var reusable = Reusables()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        
        let openURLTap = UITapGestureRecognizer(target: self, action: #selector(self.openURL(_:)))
        openURLTap.numberOfTouchesRequired = 1
        imgSingleArticle.addGestureRecognizer(openURLTap)
        lblTitle.addGestureRecognizer(openURLTap)
    }
    
    @objc func openURL(_ sender: UITapGestureRecognizer? = nil) {
        guard let url = URL(string:articleInfo[0].url!) else { return }
        UIApplication.shared.open(url)
    }
    
    func fillData(){
        
        lblAuthor.text = articleInfo[0].author == nil ? "Unknown author" : articleInfo[0].author
        lblSource.text = articleInfo[0].source.name
        lblDesc.text = articleInfo[0].description
        lblDate.text = articleInfo[0].publishedAt//dateString
        lblTitle.text = articleInfo[0].title
        txtViewContent.text = articleInfo[0].content
        txtViewContent.isEditable = false
        
        let fallbackImageUrl = "https://img.icons8.com/bubbles/100/000000/no-image.png"
        let articleImageUrl = articleInfo[0].urlToImage ?? fallbackImageUrl
        let url = reusable.resolveImageUrl(articleImageUrl, fallbackImageUrl)
     
        let data = try? Data(contentsOf: url)
        
        if let imageData = data {
            imgSingleArticle.image = UIImage(data: imageData)
        }
    }
}
