              import UIKit

class FoodTruckCell: UITableViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var avgCostLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configureCell(foodtruck: FoodTruck)
    {
        nameLabel.text = foodtruck.name
        foodTypeLabel.text = foodtruck.foodtype
        avgCostLabel.text = "$\(foodtruck.avgCost)"
    }
}
