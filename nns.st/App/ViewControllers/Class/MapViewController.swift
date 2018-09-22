//
//  MapViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/18.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


protocol MapViewControllerDelegate {
    func mapView(_mapViewController: MapViewController, didSetDistance item: MapViewItem)
}

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapview: MKMapView!
    @IBInspectable var CRstrokeColor: UIColor = UIColor.white
    @IBInspectable var CRfillColor: UIColor = UIColor.clear
    @IBInspectable var CRlineWidth: CGFloat = 1.0
    
    var delegate: MapViewControllerDelegate? = nil

    private var locationManager: CLLocationManager? = nil
    private var resultSearchController:UISearchController? = nil
    private var bottomSheet: BottomSheetViewController!
    private var annotation: MKPointAnnotation = MKPointAnnotation()
    private var isSet: Bool = false
    private let delta: Double = 0.03
    
    // for circle
    private var circle: MKCircle = MKCircle()
    private var circleRenderer: MKCircleRenderer = MKCircleRenderer()
    private var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    private var circleRadius: Double = 1000.0
    
    
    
    static func instantiateViewController() -> MapViewController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addBottomSheetView()
        bottomSheet.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLocationManager()
        self.initMap()
        self.updateMap(coordinate: mapview.userLocation.coordinate, isDropPin: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension MapViewController {
    
    func addBottomSheetView() {
        bottomSheet = BottomSheetViewController.instantiateViewController()
        
        self.addChildViewController(bottomSheet)
        self.view.addSubview(bottomSheet.view)
        
        bottomSheet.didMove(toParentViewController: self)
        bottomSheet.view.frame.origin = CGPoint(x: 0.0, y: self.view.frame.maxY)
        bottomSheet.mapview = mapview
        bottomSheet.tableView.delegate = self
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
    }
    
    func initMap() {
        mapview.mapType = MKMapType.standard
        mapview.userTrackingMode = MKUserTrackingMode.follow
    }
    
    func updateMap(coordinate: CLLocationCoordinate2D, isDropPin: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        var center: CLLocationCoordinate2D = coordinate
        center.latitude -= 0.007
        let region = MKCoordinateRegion(center: center, span: span)
        mapview.region = region
        mapview.setRegion(region, animated: true)
        
        self.coordinate = coordinate
        updateCircle(radius: circleRadius)
        
        if isDropPin {
            mapview.removeAnnotation(annotation)
            annotation.coordinate = coordinate
            mapview.addAnnotation(annotation)
        }
    }
    
    func updateCircle(radius: CLLocationDistance) {
        mapview.removeOverlays(mapview.overlays)
        circle = MKCircle(center: coordinate, radius: radius)
        mapview.add(circle)
    }
    
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.strokeColor = CRstrokeColor
            circleRenderer.fillColor = CRfillColor
            circleRenderer.lineWidth = CRlineWidth
            return circleRenderer
        }
        return MKOverlayRenderer()
    }
    
}



extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if mapview.userLocation.location != nil && !isSet {
            self.updateMap(coordinate: mapview.userLocation.coordinate, isDropPin: false)
            isSet = true
        }
    }
    
}


extension MapViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: SearchResultCell = tableView.cellForRow(at: indexPath) as! SearchResultCell
        
        self.updateMap(coordinate: cell.placemark.coordinate, isDropPin: true)
        bottomSheet.searchBar.text = cell.name.text
        bottomSheet.searchBar.resignFirstResponder()
    }
    
}


extension MapViewController: BottomSheetDelegate {
    
    func bottomSheet(_ bottomSheet: BottomSheetViewController, didCanceled items: [MKMapItem]) {
        
    }
    
    func bottomSheet(_ bottomSheet: BottomSheetViewController, SearchButtonClicked items: [MKMapItem]) {
        if bottomSheet.searchBar.text == "" {
            mapview.removeAnnotation(annotation)
            self.updateMap(coordinate: mapview.userLocation.coordinate, isDropPin: false)
            bottomSheet.searchBar.resignFirstResponder()
            return
        }
        
        if let item = items.first {
            self.updateMap(coordinate: item.placemark.coordinate, isDropPin: true)
            bottomSheet.searchBar.text = item.name
        }
        bottomSheet.searchBar.resignFirstResponder()
    }
    
    func bottomSheet(_bottmSheet: BottomSheetViewController, didScrolledSlider slider: UISlider) {
        circleRadius = Double(slider.value * 1000)
        updateCircle(radius: circleRadius)
    }
    
    func bottomSheet(_bottmSheet: BottomSheetViewController, didSetDistance button: UIButton) {
        let title = (bottomSheet.searchBar.text != "") ? bottomSheet.searchBar.text : "現在地"
        if let title = title {
            let item = MapViewItem(coordinate: coordinate, title: title, distance: CGFloat(round(circleRadius/100)/10))
            delegate?.mapView(_mapViewController: self, didSetDistance: item)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
