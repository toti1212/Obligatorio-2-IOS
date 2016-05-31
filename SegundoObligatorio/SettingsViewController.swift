//
//  SettingsController.swift
//  SegundoObligatorio
//
//  Created by SP26 on 25/5/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    weak var viewController: ViewController?
    
    @IBOutlet weak var unitSwitch: UISegmentedControl!
    var selectedUnitSwitch : Int! = nil
    
    @IBAction func returnToMain(sender: AnyObject) {
        
        //performSegueWithIdentifier(<#T##identifier: String##String#>, sender: <#T##AnyObject?#>)
        
        self.dismissViewControllerAnimated(true, completion: nil);
        
    }
    @IBAction func saveAndReturnToMain(sender: AnyObject) {
        
        viewController!.unitDegree = selectedUnitSwitch
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.unitSwitch.selectedSegmentIndex = selectedUnitSwitch
        
        // Do any additional setup after loading the view.
        self.selectedUnitSwitch = unitSwitch.selectedSegmentIndex
        unitSwitch.addTarget(self, action: #selector(SettingsViewController.segmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func segmentedControlValueChanged(segment: UISegmentedControl){
        if(segment.selectedSegmentIndex != self.selectedUnitSwitch){
            self.selectedUnitSwitch = segment.selectedSegmentIndex
        }
        print("UNIT SWITCH--->\(self.selectedUnitSwitch)")
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
