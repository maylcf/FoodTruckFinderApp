//
//  ReviewsController.swift
//  Foodtruck Finder
//
//  Created by Mayara Felix on 2018-01-24.
//  Copyright © 2018 Mayara Felix. All rights reserved.
//

import UIKit

class ReviewsController: UIViewController
{
    var selectedFoodTruck: FoodTruck?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instace.delegate = self
        
        if let foodtruck = selectedFoodTruck
        {
            self.title = foodtruck.name
            DataService.instace.getAllReviews(foodtruck: foodtruck)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ReviewsController: DataServiceDelegate
{
    func trucksLoaded() {
        
    }
    
    func reviewsLoaded()
    {
        OperationQueue.main.addOperation
        {
            self.tableView.reloadData()
        }
    }
}

extension ReviewsController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return DataService.instace.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
        let review = DataService.instace.reviews[indexPath.row]
        cell.textLabel?.text = review.title
        cell.detailTextLabel?.text = review.text
        
        return cell

    }
}
