//
//  ViewController.swift
//  weather app
//
//  Created by New Horizons Computer Learning Centers of Singapore on 6/2/19.
//  Copyright © 2019 SLT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    

    @IBAction func showWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        let attemptedUrl = NSURL(string: "https://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                //let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                

                let websiteArray  = webContent!.componentsSeparatedByString("Live weather stations")
                
                if websiteArray.count > 1 {
                    
                    //print(websiteArray.count)


                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                    
                    if weatherArray.count > 1 {
                        
                        //wasSuccessful = true
                        
                        //print(weatherArray.count)
                        print(weatherArray[6])
                        var tempArray = weatherArray[6].componentsSeparatedByString("<span class=\"temp\">")
                        
                        if tempArray.count > 1 {
                            
                            wasSuccessful = true
                            
                        //let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            var weatherSummary = tempArray[1].stringByAppendingString("ºC")
                        
                        print(tempArray[1])
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.resultLabel.text = weatherSummary
                            
                            
                        })
                        
                        
                        
                    }
                    
                    }
                    
                    
                }
                
                
                
            }
            
            if wasSuccessful == false {
                
                self.resultLabel.text = "Couldn't find the weather for that city - please try again."
                
                
            }
            
        }
        
        task.resume()
        
        } else {
            
            self.resultLabel.text = "Couldn't find the weather for that city - please try again."
            
            
        }

    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of anyresources that can be recreated.
    }


}

