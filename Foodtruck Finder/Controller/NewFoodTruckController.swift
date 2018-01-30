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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewFoodTruckController.viewTapped))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func viewTapped()
    {
        nameField.resignFirstResponder()
        foodTypeField.resignFirstResponder()
        avgCostField.resignFirstResponder()
        latitudeField.resignFirstResponder()
        longitudeField.resignFirstResponder()
    }
    
    @IBAction func saveButtonSelected(_ sender: UIButton)
    {
        guard let name = nameField.text, nameField.text != "" else {
            showAlert(title: "Error", message: "Please enter a name")
            return
        }
        
        guard let foodType = foodTypeField.text, foodTypeField.text != "" else {
            showAlert(title: "Error", message: "Please enter a food type")
            return
        }
        
        guard let avgCost = Double(avgCostField.text!), avgCostField.text != "" else {
            showAlert(title: "Error", message: "Please enter an average cost")
            return
        }

        guard let latitude = Double(latitudeField.text!), latitudeField.text != "" else {
            showAlert(title: "Error", message: "Please enter a latitude")
            return
        }
        
        guard let longtude = Double(longitudeField.text!), longitudeField.text != "" else {
            showAlert(title: "Error", message: "Please enter a longitude")
            return
        }
        
        DataService.instace.addNewFoodTruck(name, foodtype: foodType, avgcost: avgCost, latitude: latitude, longitude: longtude, completion: { Success in
            
            if Success {
                print ("Saved")
                DataService.instace.getAllFoodTrucks()
                self.dismissViewController()
            }
            else
            {
                self.showAlert(title: "Error", message: "Error saving the new food truck")
            }
        })
    }
    
    @IBAction func cancelButtonSelected(_ sender: UIButton)
    {
        self.dismissViewController()
    }
    
    func showAlert(title: String?, message: String?)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func dismissViewController()
    {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
}
