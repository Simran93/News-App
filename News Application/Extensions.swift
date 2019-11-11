//
//  Extensions.swift
//  News Application
//
//  Created by Simranjeet  Singh on 2019-11-06.
//  Copyright © 2019 Simranjeet  Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(url: URL?) {
        self.image = nil
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let data = data, error == nil {
                        if let image = UIImage(data: data){
                        self.image = image
                    }
                }
            }
           
        }
            task.resume()
  
    }

}

}
