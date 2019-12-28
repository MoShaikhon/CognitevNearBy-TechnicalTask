//
//  Location.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/25/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import Foundation
import CoreLocation
import RxCoreLocation
import RxSwift
protocol LocationService {
    func requestLocationUpdates()-> Observable<CLLocation?>
    func requestLocationOnce()-> Observable<CLLocation?>

}
class PlacesLocationService: NSObject, CLLocationManagerDelegate,LocationService {
    
    var locationManager: CLLocationManager?
    
    fileprivate func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
              locationManager?.delegate = self
              locationManager?.requestAlwaysAuthorization()
    }
    func requestLocationUpdates()-> Observable<CLLocation?> {
//        setupLocationManager()
        locationManager?.startUpdatingLocation()
        return locationManager!.rx.location.share(replay: 1)

    }
    func requestLocationOnce()-> Observable<CLLocation?> {
//        setupLocationManager()

        locationManager?.stopUpdatingLocation()
        locationManager?.startUpdatingLocation()
        return locationManager!.rx.location.share(replay: 1)


    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
        }
    }
}
