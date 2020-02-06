//
//  ViewController.swift
//  NewsReader
//
//  Created by Natalija Krsnik on 04/02/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//
//  Icon from  https://icons8.com/icon/a_HIsIu2fM19/no-image

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tblArticles: UITableView!
    var totalNews: Int = 0
    var articlesArray: [Articles] = []
    var articleInfo: [Articles] = []
    var reusable = Reusables()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblArticles.delegate = self
        tblArticles.dataSource = self
       
        self.parseJSON()
        
        let nib = UINib(nibName: "ArticlesCell", bundle: nil)
        self.tblArticles.register(nib, forCellReuseIdentifier: "ArticlesCell")
    }
    
    func parseJSON(){
        if let url = URL(string:"https://newsapi.org/v2/top-headlines?" + "country=us&" + "apiKey=6c9051d9261c40d6a524740dc4739ed9") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let news = try JSONDecoder().decode(News.self, from: data)
                        self.totalNews = news.totalResults
                        let articles = news.articles
                        for a in articles {
                           
                            let jsonDate = (a.publishedAt?.isEmpty == true ? "1970-01-01T00:00:00Z" : a.publishedAt)!
                            let dateString = self.reusable.formatDate(jsonDate)
                            
                            let source = a.source
                            let author = a.author
                            let title = a.title
                            let description = a.description
                            let url = a.url
                            let urlToImage = a.urlToImage
                            let publishedAt = dateString
                            let content = a.content
                            
                            let a = Articles(source: source, author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content)
                            self.articlesArray.append(a)
                        }
                        
                    } catch let error {
                        print(error)
                    }
                    
                    OperationQueue.main.addOperation({
                        self.tblArticles.reloadData()
                    })
                }
                
            }.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesCell", for: indexPath) as! ArticlesCell
        
        cell.lblTitle.text = self.articlesArray[indexPath.item].title
        cell.lblDate.text = self.articlesArray[indexPath.item].publishedAt
        
        let fallbackImageUrl = "https://img.icons8.com/bubbles/100/000000/no-image.png"
        let articleImageUrl = self.articlesArray[indexPath.item].urlToImage ?? fallbackImageUrl
        let url = reusable.resolveImageUrl(articleImageUrl, fallbackImageUrl)
       
        let data = try? Data(contentsOf: url)
        
        if let imageData = data {
            cell.imgArticle.image = UIImage(data: imageData)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        articleInfo = [self.articlesArray[indexPath.item]]
    
        let articleVC = self.storyboard?.instantiateViewController(withIdentifier: "ToArticle") as! SingleArticleVC
        articleVC.articleInfo = articleInfo
        
        self.present(articleVC, animated: true, completion: nil)
    }
}

