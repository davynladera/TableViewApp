//
//  ViewController.swift
//  TableStory
//
//  Created by Ladera, Davyn B on 3/22/23.
//

import UIKit

import MapKit

let data = [
    Item(name: "Starry Night", artist: "Vincent Van Gogh", desc: "Van Gogh's famous 'Starry Night' features an abstraction of the night's landscape. Layers of blue and yellow oil paint swirl into one another creating a mystical image of the night sky. Of Van Gogh's many works, this is considered his most infamous piece.", lat: 40.7614, long: -73.9776, imageName: "starry", medium: "Oil paint on canvas", year: "1889", museum: "MoMa (Museum of Modern Art)"),
    Item(name: "Hang Onto the Wind and Trust", artist: "Don Reitz", desc: "Reitz focuses on pushing narrative as each of his pieces tells a story. He utilizes the surface of each piece exentuating tears and groves to create highly textured and decorated works. Even the firing process altered the clay's form through wood firing.", lat: 34.0612, long: -117.7508, imageName: "hang", medium: "Vitreous Engobes, Clay", year: "1984", museum: "AMOCA (The American Museum of Ceramic Art)"),
    Item(name: "Horse's Skull with Pink Rose", artist: "Georgia O'Keefe", desc: "Georgia O'Keefe is well-known for her use of skeletal or floral subjects in her paintings. 'Horse Skull with Rose'  is known as one of her most mystiying pieces.While, critics saw a morbid fascination for death, O'Keefe always insisted on her work acting as a celebration of life.", lat: 34.0639, long: -118.3592, imageName: "okeefe", medium: "Oil paint on canvas", year: "1931", museum: "LACMA (Los Angeles County Museum of Art)"),
    Item(name: "Back of the Neck", artist: "Jean-Michel Basquiat", desc: "Back of the Neck' is one of Basquiat's few screenprints. It features Basquiat's trademarked three-point crown and his intrigue into anatomy. It also alludes to his love of Leonardo de Vinci as if creating a study of anatomical arms in his own right.", lat: 40.7830, long: -73.9590, imageName: "neck", medium: "Screen print with hand-coloring on paper", year: "1983", museum: "The Guggenheim Museum"),
    Item(name: "Medea's Hypostases lll", artist: "Geta Brătescu", desc: "Geta Brătescu was a Romanian artist that utilized various mediums throughout her career and was awarded an honorary doctorate for her contributions to Romanian conteporary art. Many of her works criticized the censorship of her society and eventually focused on topics of self-identity and dematerialisation as well. It was in the 1980's that she began her textile work where she would 'draw with a sewing machine.'", lat: 40.7614, long: -73.9776, imageName: "geta", medium: "Drawing with sewing machine on textile", year: "1980", museum: "MoMa (Museum of Modern Art)")
   
]

struct Item {
    var name: String
    var artist: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
    var medium: String
    var year: String
    var museum: String
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
        let coordinate = CLLocationCoordinate2D(latitude: 40.0, longitude: -97.7444)
        let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 30.0, longitudeDelta: 30.0))
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

