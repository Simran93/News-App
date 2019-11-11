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

		let urlString = "https://newsapi.org/v1/articles?source=\(newsSource)&apiKey=d6572d2119784dd985b97c0e94cfbad1"

		return URL(string: urlString)
	}

}
