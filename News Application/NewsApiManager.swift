//
//  NewsCollectionViewController.swift
//  News Application
//
//  Created by Simranjeet  Singh on 2019-11-07.
//  Copyright © 2019 Simranjeet  Singh. All rights reserved.
//


import Foundation

class NewsApiManager
{
	class func getNewsURL(source: String? = nil) -> URL?
	{
		let newsSource = source ?? "techcrunch"

		let urlString = "https://newsapi.org/v1/articles?source=\(newsSource)&apiKey=84c54c145e944bb19b25805e463746e8"

		return URL(string: urlString)
	}

}
