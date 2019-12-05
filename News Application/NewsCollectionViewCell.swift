//
//  NewsCollectionViewCell.swift
//  News Application
//
//  Created by Simranjeet  Singh on 2019-11-06.
//  Copyright © 2019 Simranjeet  Singh. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setNewsItem(newsItem: Article) {
        self.imageView.loadImage(url: URL(string: newsItem.urlToImage))

        self.headlineLabel.text = newsItem.title
        self.descriptionLabel.text = newsItem.articleDescription
        self.authorLabel.text = newsItem.author

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        if let date = newsItem.publishedAt {
            self.dateLabel.text = dateFormatter.string(from: date)
        }
    }
    
    
    
    
}
