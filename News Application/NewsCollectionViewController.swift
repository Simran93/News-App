//
//  NewsCollectionViewController.swift
//  News Application
//
//  Created by Simranjeet  Singh on 2019-11-06.
//  Copyright © 2019 Simranjeet  Singh. All rights reserved.
//

import UIKit
class NewsCollectionViewController: UICollectionViewController {
    var articles : [Article]?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.reloadData()
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return articles?.count ?? 0
      }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setNewsItem(newsItem: self.articles![indexPath.row])

        return cell
    }
    func reloadData() {
        let source = "cnn"

        if let url = NewsApiManager.getNewsURL(source: source) {
            let session = URLSession.shared

            let task = session.newsTask(with: url) { (news, response, error) in
                self.articles = news?.articles
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            task.resume()

            
        }
    }
}
      
