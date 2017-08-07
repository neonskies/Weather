//
//  ViewController.swift
//  Weather
//
//  Created by Vladislav Fedotovskiy on 03.05.16.
//  Copyright © 2016 Vladislav Fedotovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    
    @IBAction func go(_ sender: AnyObject) {
        
        let attemptedUrl = URL(string: "http://www.weather-forecast.com/locations/" + cityText!.text!.replacingOccurrences(of: " ", with:"-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                
                let websiteArray = webContent?.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray!.count > 1 {
                    
                    let weatherArray = websiteArray![1].components(separatedBy: "</span>")
                    
                    if weatherArray.count > 1 {
                        
                        let weatherSummary = weatherArray[0].replacingOccurrences(of: "&deg;", with:"º")
                        
                        DispatchQueue.main.async(execute: {
                            self.result.text = weatherSummary
                        })
                        
                        
                        
                    }
                    
                    
                }
                
                
            }
        }) 
        
        task.resume()
        
        } else {
            
            result.text = "Cannot find any weather for your request"
        }
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

