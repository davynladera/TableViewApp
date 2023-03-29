//
//  ViewController.swift
//  TableStory
//
//  Created by Ladera, Davyn B on 3/22/23.
//

import UIKit

import MapKit

let data = [
    Item(name: "Starry Night", artist: "Vincent Van Gogh", desc: "Van Gogh's famous 'Starry Night' features an abstraction of the night's landscape. Layers of blue and yellow oil paint swirl into one another creating a mystical image of the night sky. Of Van Gogh's many works, this is considered his most infamous piece.", lat: 40.7794, long: 73.9632, imageName: "rest1"),
    Item(name: "Biscuits + Groovy", artist: "Hyde Park", desc: "Groovy little neighborhood truck serving up biscuits in a variety of styles.", lat: 30.313960, long: -97.719760, imageName: "rest2"),
    Item(name: "Veracruz All Natural", artist: "Mueller", desc: "This is one of many locations for the beloved taco mavens of Austin.", lat: 30.2962244, long: -97.7079799, imageName: "rest3"),
    Item(name: "Vaquero Taquero", artist: "UT", desc: "Delicious tacos with a convenient walk up window. ", lat: 30.295190, long: -97.736540, imageName: "rest4"),
    Item(name: "Uncle Nicky's", artist: "Hyde Park", desc: "Serving up Italian specialties and drinks.", lat: 30.304890, long: -97.726220, imageName: "rest5")
   
]

struct Item {
    var name: String
    var artist: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
      
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
                  let item = data[indexPath.row]
                  cell?.textLabel?.text = item.name

                  //Add image references
                  let image = UIImage(named: item.imageName)
                  cell?.imageView?.image = image
                  cell?.imageView?.layer.cornerRadius = 10
                  cell?.imageView?.layer.borderWidth = 5
                  cell?.imageView?.layer.borderColor = UIColor.white.cgColor
                  
                  return cell!
              }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
    
    override func viewDidLoad() {
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

