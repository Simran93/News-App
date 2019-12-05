//
//  ArticleViewController.swift
//  News Application
//
//  Created by Simranjeet  Singh on 2019-11-06.
//  Copyright © 2019 Simranjeet  Singh. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKNavigationDelegate{

    @IBOutlet weak var articleWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var newsURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.articleWebView.navigationDelegate = self
        if let url = newsURL {
            let request = URLRequest(url: url)
            self.articleWebView.load(request)
            self.activityIndicator.startAnimating()
            
            
        }
        
       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           self.activityIndicator.stopAnimating()
           self.activityIndicator.isHidden = true
       }
       
    }
    

  

}
