//
//  ViewController.swift
//  GoogleMapCustomMarker
//
//  Created by Masam Mahmood on 20.12.2019.
//  Copyright © 2019 Masam Mahmood. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    var marker = GMSMarker()
    
    var coords = [[40.8045062,29.387417],[40.2215936,28.8922043],[41.029307, 29.043749],[38.630554, 27.422222], [37.910000, 40.240002], [40.766666, 29.916668],
    [36.884804, 30.704044], [40.731647, 31.589813], [37.783333, 29.094715], [37.874641, 32.493156], [38.734802, 35.467987], [41.002697, 39.716763],
    [40.652382, 35.828819]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
         
        let camera = GMSCameraPosition.camera(withLatitude: 38.9637, longitude: 35.2433, zoom: 5.0)   /// istanbul
         mapView.camera = camera
        
        
        for coord in coords {
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: coord[0], longitude: coord[1])
            marker.map = mapView
            marker.appearAnimation = GMSMarkerAnimation.pop
            marker.icon = drawImageWithProfilePic(pp: UIImage.init(imageLiteralResourceName: "user"), image: UIImage.init(imageLiteralResourceName: "markerCustom"))
            marker.title = "Turkey"
            self.mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
                        
        }
        
        
    }
    
    
    func drawImageWithProfilePic(pp: UIImage, image: UIImage) -> UIImage {

        let imgView = UIImageView(image: image)
        let picImgView = UIImageView(image: pp)
        
        imgView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        picImgView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
       
        imgView.addSubview(picImgView)
        
        picImgView.center.x = imgView.center.x
        picImgView.center.y = imgView.center.y - 4
        picImgView.layer.cornerRadius = picImgView.frame.width/2
        picImgView.clipsToBounds = true
        imgView.setNeedsLayout()
        picImgView.setNeedsLayout()
        

        let newImage = imageWithView(view: imgView)
        return newImage
    }
    
    func imageWithView(view: UIView) -> UIImage {
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image ?? UIImage()
    }


}

//MARK: - CLLocation Manager
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
                
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
       
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
           
        var speed: CLLocationSpeed = CLLocationSpeed()
        speed = locationManager.location!.speed
        print(speed)
        
       // let userLocationMarker = GMSMarker(position: location.coordinate)
        //userLocationMarker.icon = UIImage(named: "location")
        //userLocationMarker.map = mapView
        
        locationManager.stopUpdatingLocation()
    }
    
}
