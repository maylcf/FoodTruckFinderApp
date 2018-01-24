import Foundation

protocol DataServiceDelegate: class
{
    func trucksLoaded()
    func reviewsLoaded()
}

class DataService
{
    static let instace = DataService()
    
    weak var delegate: DataServiceDelegate?
    var foodTrucks = [FoodTruck]()
    var reviews = [FoodTruckReview]()
    
    // Get all food trucks
    func getAllFoodTrucks()
    {
        let sessionConfig = URLSessionConfiguration.default;
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: GET_ALL_FT_URL) else { return }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler:
        { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil)
            {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Sesson Task succeeded: HTPP \(statusCode)")
                if let data = data {
                    self.foodTrucks = FoodTruck.parseFoodTruckJSONData(data: data)
                    self.delegate?.trucksLoaded()
                }
            }
            else
            {
                print("URL Session Task Failed: \(error!.localizedDescription)")
            }
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    // Get all reviews
    func getAllReviews(foodtruck: FoodTruck)
    {
        let sessionConfig = URLSessionConfiguration.default;
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: "\(GET_ALL_FT_REVIEWS_URL)/\(foodtruck.id)") else { return }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler:
        { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil)
            {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Sesson Task succeeded: HTPP \(statusCode)")
                if let data = data {
                    self.reviews = FoodTruckReview.parseReviewJSONData(data: data)
                    self.delegate?.reviewsLoaded()
                }
            }
            else
            {
                print("URL Session Task Failed: \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    // POST add new FoodTruck
    func addNewFoodTruck(_ name: String, foodtype: String, avgcost: Double, latitude: Double, longitude: Double, completion: @escaping callback)
    {
        // Construct our JSON
        let json: [String: Any] = [
            "name": name,
            "foodtype": foodtype,
            "avgcost": avgcost,
            "geometry": [
                "coordinates":[
                    "lat":latitude,
                    "long": longitude
                ]
            ]
        ]
        
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default;
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: POST_ADD_NEW_FT_URL) else { return }
            
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
//            guard let token = AuthService.instance.authToken else {
//                completion(false)
//                return
//            }
            //request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler:
            { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil)
                {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL Sesson Task succeeded: HTPP \(statusCode)")
                    
                    if ( statusCode != 200)
                    {
                        completion(false)
                        return
                    }
                    else
                    {
                        self.getAllFoodTrucks()
                        completion(true)
                    }
                }
                else
                {
                    print("URL Session Task Failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
        }
        catch let err {
            print(err)
            completion(false)
        }
    }
    
    // POST add a new FoodTruckReview
    func addNewReview(_ foodtruckId: String, title: String, text: String, completion: @escaping callback)
    {
        let json: [String: Any] = [
            "title": title,
            "text": text,
            "foodtruck": foodtruckId
        ]
        
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default;
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: POST_ADD_NEW_REVIEW_URL + "/" + foodtruckId) else { return }
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            //            guard let token = AuthService.instance.authToken else {
            //                completion(false)
            //                return
            //            }
            
            //request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler:
            { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil)
                {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL Sesson Task succeeded: HTPP \(statusCode)")
                    
                    if ( statusCode != 200)
                    {
                        completion(false)
                        return
                    }
                    else
                    {
                        completion(true)
                    }
                }
                else
                {
                    print("URL Session Task Failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
        }
        catch let err
        {
            print(err)
            completion(false)
        }
    }
    
    
} // class
