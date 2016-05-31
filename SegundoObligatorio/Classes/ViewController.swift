//
//  ViewController.swift
//  SegundoObligatorio
//
//  Created by Diego Pais on 5/18/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftLocation


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //@IBOutlet weak var weatherIconLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UILabel!
    
    @IBOutlet weak var degrees: UILabel!
    
    @IBOutlet weak var cityName: UILabel!
    

    
    @IBOutlet weak var weatherIconLabel: UILabel!
    let locationManager =  CLLocationManager()
    var latitude : Double = 0.0
    var longitude : Double = 0.0


    
    @IBAction func viewSettings(sender: AnyObject) {
        performSegueWithIdentifier("viewSettings", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        condition: weather.id
//        iconString: weather.icon
//        ver: http://openweathermap.org/current#parameter
//        http://openweathermap.org/weather-conditions
        
        self.weatherIcon.text = WeatherIcon(condition: 200, iconString: "01n").iconText
        
        //self.weatherIconLabel.text = WeatherIcon(condition: 200, iconString: "01n").iconText

        self.weatherIconLabel.text = WeatherIcon(condition: 200, iconString: "01n").iconText

        
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img-background.png")!)
        
            }
    
    override func viewWillAppear(animated: Bool) {
        try! SwiftLocation.shared.currentLocation(Accuracy.Neighborhood, timeout: 100,
            
            onSuccess: { (placemark) -> Void in
                self.latitude = (placemark?.coordinate.latitude)!
                self.longitude = (placemark?.coordinate.longitude)!
                
                print(self.latitude)
                print(self.longitude)
                
                APIClient.sharedClient.wheatherOnCompletion(self.latitude, longitude: self.longitude, OnCompletion: { () -> Void in
                    
                })
            } , onFail:{ (error) -> Void in
                print(error)
        })

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    let reuseIdentifier = "cell"
    //var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    

    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.items.count
        return 6
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DayCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.dayWeatherIcon.text = self.items[indexPath.item]
        
        cell.dayWeatherIcon.text = WeatherIcon(condition: 200, iconString: "01n").iconText
        
        
        //cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }


}

