import UIKit

class NewReviewController: UIViewController
{
    var selectedFoodTruck: FoodTruck?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var reviewField: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let foodTruck = selectedFoodTruck
        {
            self.title = foodTruck.name
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveReviewTapped(_ sender: Any)
    {
        guard let foodtruck = selectedFoodTruck else {
            showAlert(title: "Error", message: "Could not find FoodTruck")
            return
        }
        
        guard let title = self.titleField.text, self.titleField.text != "" else
        {
            showAlert(title: "Error", message: "Please, enter a title for your review")
            return
        }
        
        guard let text = self.reviewField.text, self.reviewField.text != "" else
        {
            showAlert(title: "Error", message: "Please, enter your review")
            return
        }
        DataService.instace.addNewReview(foodtruck.id, title: title, text: text, completion: { Success in
            if Success {
                print("Review saved.")
                DataService.instace.getAllReviews(foodtruck: foodtruck)
                self.dismissViewController()
            }
            else
            {
                self.showAlert(title: "Error", message: "An error occurred saving the new review.")
            }
        })
    }
    
    @IBAction func cancelTapped(_ sender: Any)
    {
        self.dismissViewController()
    }
    
    func dismissViewController()
    {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(title: String?, message: String?)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
