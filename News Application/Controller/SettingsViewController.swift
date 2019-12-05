//
//  SettingsViewController.swift
//  News Application
//
//  Created by Simranjeet  Singh on 2019-11-15.
//  Copyright © 2019 Simranjeet  Singh. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
 

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var articlesSlider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var sourcePicker: UIPickerView!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        self.sliderLabel.text = "\(Int(articlesSlider.value))"
        UserDefaults.standard.set(articlesSlider.value, forKey: "num_articles")
    }
    
    let sourceArray = ["techcrunch", "cnn", "espn","google-news", "time"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        let numArticles = UserDefaults.standard.float(forKey: "num_articles")

        if numArticles >= 1 {
            articlesSlider.value = numArticles
            self.sliderChanged(articlesSlider)
        }

     
        if let username = UserDefaults.standard.string(forKey: "username"){
            userNameTextField.text = username
            
            if let source = UserDefaults.standard.string(forKey: "news_source") {
                if let row = sourceArray.firstIndex(of: source) {
                    sourcePicker.selectRow(row, inComponent: 0, animated: false)
                }
            }
            
            
            
        }
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        
        UserDefaults.standard.set(userNameTextField.text, forKey: "username")
    }
    @IBAction func returnKeyPressed(_ sender: UITextField) {
        
        sender.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sourceArray.count
     }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return sourceArray[row]
     }

     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         UserDefaults.standard.set(sourceArray[row], forKey: "news_source")
     }
      
 
    
}
