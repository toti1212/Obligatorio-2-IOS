//
//  ViewController.swift
//  SegundoObligatorio
//
//  Created by Diego Pais on 5/18/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconLabel: UILabel!
    
    @IBAction func viewSettings(sender: AnyObject) {
        performSegueWithIdentifier("viewSettings", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        condition: weather.id
//        iconString: weather.icon
//        ver: http://openweathermap.org/current#parameter
//        http://openweathermap.org/weather-conditions
        
        self.weatherIconLabel.text = WeatherIcon(condition: 200, iconString: "01n").iconText
        
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img-background.png")!)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        APIClient.sharedClient.wheatherOnCompletion { () -> Void in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

