import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIImageView!
    
    var dataService = DataService.instace
    var authService = AuthService.instance
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dataService.delegate = self
        //tableView.delegate = self
        //tableView.dataSource = self
        
        DataService.instace.getAllFoodTrucks()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "DetailFoodTruckSegue"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                if let destination = segue.destination as? FoodTruckDetailController
                {
                    destination.selectedFoodTruck = DataService.instace.foodTrucks[indexPath.row]
                }
            }
        }
        //NewFoodTruckSegue
    }
}

extension MainViewController: DataServiceDelegate
{
    func trucksLoaded()
    {
        OperationQueue.main.addOperation
        {
            self.tableView.reloadData()
        }
    }
    
    func reviewsLoaded()
    {
        print("")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataService.foodTrucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTruckCell", for: indexPath) as? FoodTruckCell
        {
            cell.configureCell(foodtruck: dataService.foodTrucks[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

