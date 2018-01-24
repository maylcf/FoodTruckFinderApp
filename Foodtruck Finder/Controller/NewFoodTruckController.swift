//
//  NewFoodTruckController.swift
//  Foodtruck Finder
//
//  Created by Mayara Felix on 2018-01-23.
//  Copyright © 2018 Mayara Felix. All rights reserved.
//

import UIKit

class NewFoodTruckController: UIViewController
{
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var foodTypeField: UITextField!
    @IBOutlet weak var avgCostField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveButtonSelected(_ sender: UIButton) {
    }
    
    @IBAction func cancelButtonSelected(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
