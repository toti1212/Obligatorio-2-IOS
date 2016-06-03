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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var weatherIcon: UILabel!
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    var unitDegree : Int! = NSUserDefaults.standardUserDefaults().integerForKey(PersitedData.unit)
    var textDegree : String! = ""
    let locationManager =  CLLocationManager()
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var weatherArray = [Weather]()
    
    
    
    @IBAction func viewSettings(sender: AnyObject) {
        performSegueWithIdentifier("viewSettings", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "viewSettings" {
            
            let nav = segue.destinationViewController as! UINavigationController
            let secondViewController = nav.topViewController as! SettingsViewController
            secondViewController.selectedUnitSwitch = self.unitDegree
            secondViewController.viewController = self
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide objects and start activity Indicator
        self.hideObjects()
        activityIndicator.startAnimating()
        self.unitDegree = NSUserDefaults.standardUserDefaults().integerForKey(PersitedData.unit)
        
        getData()
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        if(self.unitDegree != NSUserDefaults.standardUserDefaults().integerForKey(PersitedData.unit)){
            self.activityIndicator.hidden = false
            self.hideObjects()
            activityIndicator.startAnimating()
            
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(unitDegree, forKey: PersitedData.unit)
        
            getData()
        
       
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //---------------- FUNCTIONS -----------------------
    
    func getData(){
        //Getting data and parse to set in views elements.
        try! SwiftLocation.shared.currentLocation(Accuracy.Neighborhood, timeout: 100,
                                                  
                                                  onSuccess: { (placemark) -> Void in
                                                    self.latitude = (placemark?.coordinate.latitude)!
                                                    self.longitude = (placemark?.coordinate.longitude)!
                                                    
                                                    //Getting data
                                                    APIClient.sharedClient.wheatherOnCompletion(self.latitude, longitude: self.longitude, units:self.unitDegree, OnCompletion: { (weatherList, error) -> Void in
                                                        if let result = weatherList{
                                                            self.cityName.text = result.city
                                                            self.weatherIcon.text = WeatherIcon(condition: result.weathers![0].condition!, iconString:result.weathers![0].icon!).iconText
                                                            self.weatherArray = (weatherList?.weathers)!
                                                            
                                                            if(self.unitDegree == 0){
                                                                self.textDegree = "ºC"
                                                            }else{
                                                                self.textDegree = "ºF"
                                                            }
                                                            
                                                            self.degrees.text = String("\(self.averageTemp(self.weatherArray[0].minTemp!, max: self.weatherArray[0].maxTemp!))\(self.textDegree)")
                                                            
                                                            self.collectionDays.reloadData()
                                                            self.activityIndicator.stopAnimating()
                                                            self.activityIndicator.hidden = true
                                                            self.unhideObjects()
                                                        }
                                                        else{
                                                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                                                            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                                                            self.presentViewController(alert, animated: true, completion: nil)
                                                        }
                                                    })
            } , onFail:{ (error) -> Void in
                print("\(error)")
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    func averageTemp(min:Double,max:Double) -> Int{
        return Int(min + max)/2
    }
    
    func hideObjects(){
        self.collectionDays.hidden = true
        self.cityName.hidden = true
        self.degrees.hidden = true
        self.weatherIcon.hidden = true
    }
    
    func unhideObjects(){
        self.collectionDays.hidden = false
        self.cityName.hidden = false
        self.degrees.hidden = false
        self.weatherIcon.hidden = false
    }
    
    //-------------------------------------------------
    
    
    @IBOutlet weak var collectionDays: UICollectionView!
    
    let reuseIdentifier = "cell"
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count - 1
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DayCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.dayWeatherIcon.text = self.items[indexPath.item]
        let day = weatherArray[indexPath.row + 1]
        
        cell.dayWeatherIcon.text = WeatherIcon(condition: day.condition!, iconString: day.icon!).iconText
        cell.dayDegree.text = String("\(averageTemp(day.minTemp!, max: day.maxTemp!))\(self.textDegree)")
        cell.dayName.text = day.day
        
        return cell
    }
    
     struct PersitedData{
        static let unit = "units"
    }

}


