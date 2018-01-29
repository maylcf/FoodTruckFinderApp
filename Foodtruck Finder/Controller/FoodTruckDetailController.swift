import UIKit
import MapKit

class FoodTruckDetailController: UIViewController {

    var selectedFoodTruck: FoodTruck?
    
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var avgCostLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = selectedFoodTruck?.title
        foodTypeLabel.text = selectedFoodTruck?.foodtype
        avgCostLabel.text = "\(String(describing: selectedFoodTruck!.avgCost))"
        
        mapView.addAnnotation(selectedFoodTruck!)
        centerMapOnLocation(location: CLLocation(latitude: selectedFoodTruck!.lat, longitude: selectedFoodTruck!.long))
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addReviewsSelected(_ sender: Any) {
    }
    
    @IBAction func seeReviewsSelected(_ sender: Any) {
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        if let foodtruck = selectedFoodTruck
        {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(foodtruck.coordinate, 1000, 1000)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowReviewsSegue"
        {
            if let destination = segue.destination as? ReviewsController
            {
                destination.selectedFoodTruck = self.selectedFoodTruck
            }
        }
        else if segue.identifier == "NewReviewSegue"
        {
            if let destination = segue.destination as? NewReviewController
            {
                destination.selectedFoodTruck = self.selectedFoodTruck
            }
        }
    }
}
