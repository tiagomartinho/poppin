import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!

    let pops:[Pop] = [ Pop(title: "El Dique", imageName: "pop2", coordinate: CLLocationCoordinate2D(latitude:  41.3793779, longitude:       2.1879071)),
                       Pop(title: "Brunch And Cake", imageName: "pop2", coordinate: CLLocationCoordinate2D(latitude: 41.3811055, longitude: 2.1871944)),
                       Pop(title: "The Green Spot", imageName: "pop3", coordinate: CLLocationCoordinate2D(latitude: 41.3818466, longitude: 2.1836384))]

    override func viewDidLoad() {
        super.viewDidLoad()
        determineCurrentLocation()
        mapView.delegate = self
        for pop in pops {
            mapView?.addAnnotation(pop)

        }
    }

    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}



class Pop: NSObject, MKAnnotation {
    let title: String?
    let imageName: String
    let coordinate: CLLocationCoordinate2D

    init(title: String, imageName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.imageName = imageName
        self.coordinate = coordinate

        super.init()
    }

    var subtitle: String? {
        return imageName
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Pop {
            let identifier = "pin"
            var view: MKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: 0, y: 5)
                view.image = UIImage(named: annotation.imageName)
                view.centerOffset = CGPoint(x: 0, y: -20)
            }

            return view
        }
        return nil
    }
}

