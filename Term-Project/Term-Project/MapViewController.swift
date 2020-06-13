//
//  MapViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/13.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var posts = NSMutableArray()
    
    // 현재 위도 경도를 담는 변수
    var currentlat : Double = 0
    var currentlon : Double = 0
    
    // 이 지역은 regionRadius의 거리에 따라 남북 동서에 걸쳐있을 것이다
    let regionRadius: CLLocationDistance = 15000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    var regions : [RegionMap] = []
    
    func loadInitialData() {
        for post in posts {
            let name = (post as AnyObject).value(forKey: "INST_NM") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "REFINE_ROADNM_ADDR") as! NSString as String
            //let telno = (post as AnyObject).value(forKey: "TELNO") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSString as String
            let lat = (XPos as NSString).doubleValue
            let lon = (YPos as NSString).doubleValue
            let region = RegionMap(title: name, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            
            if(lat != 0)
            {
                if(lon != 0)
                {
                    currentlat = lat
                    currentlon = lon
                    
                }
            }
            regions.append(region)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
           let location = view.annotation as! RegionMap
           let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
           location.mapItem().openInMaps(launchOptions: launchOptions)
       }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          guard let annotation = annotation as? RegionMap else {return nil}
          let identifier = "marker"
          var view: MKMarkerAnnotationView
          if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
              as? MKMarkerAnnotationView {
              dequeuedView.annotation = annotation
              view = dequeuedView
             
          } else {
              view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
              view.canShowCallout = true
              view.calloutOffset = CGPoint(x: -5, y: 5)
              view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
              
          }
          return view
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 메소드 호출
        loadInitialData()
        
        print("위도:\(currentlat),경도:\(currentlon)")
        let initialLocation = CLLocation(latitude: currentlat , longitude: currentlon)
        
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self;
        
        
        mapView.addAnnotations(regions)
    }
    

}
