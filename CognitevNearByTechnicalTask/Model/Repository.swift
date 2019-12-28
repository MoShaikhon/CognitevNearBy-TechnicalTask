//
//  Repository.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/28/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
import CoreLocation

class Repository {
    
    var locationService: LocationService
    var placesService: PlacesService
    var presentableModel: BehaviorRelay<[PresentingCellDataSource]>
    var photoURL: BehaviorRelay<String>
    var placesModel: [Venue]?
    var photoModel: Item?
    var previousLocation: CLLocation?
    var currentRecordedLocation: CLLocation?
    var bag = DisposeBag()
    
    init(placesService: PlacesService, locationService: LocationService) {
        self.locationService = locationService
        self.placesService = placesService
        presentableModel = BehaviorRelay(value: [])
        photoURL = BehaviorRelay(value: "")
    }
    
    func getLocationUpdates(frequency: LocationUpdateFrequency) {
        bag = DisposeBag()
        var locationObservable: Observable<CLLocation?>
        if frequency == .continuous {
            locationObservable = locationService.requestLocationUpdates()
            locationObservable.share().debug().subscribe(onNext: { location in
                guard let location = location else {return}
                let hasMoved500mOrMore = self.checkDistanceValidity(location: location)
                if hasMoved500mOrMore {
                    self.getPlaces(lat: String(location.coordinate.latitude), lng: String(location.coordinate.longitude))
                }
                })
                .disposed(by: bag)
        }else {
            locationObservable = locationService.requestLocationOnce()

            locationObservable.share().subscribe(onNext: { location in
                guard let location = location else {return}
               print(location)
                    self.getPlaces(lat: String(location.coordinate.latitude), lng: String(location.coordinate.longitude))
                
            })
                .dispose()
        }
        
        
    }
    fileprivate func checkDistanceValidity(location: CLLocation)-> Bool {
        if previousLocation == nil {
            previousLocation = location
            return true
        }else {
            print(location.distance(from: previousLocation!))
            
            let distance = location.distance(from: previousLocation!)
            if Double(distance) >= 500 {
                previousLocation = location
                return true
            }
        }
        return false
    }
    
    func getPlaces(lat: String, lng: String, radius: String = "1000"){
        placesService.fetchPlaces(lat: lat, lng: lng, radius: radius)
            .subscribe(onNext: { places in
                self.placesModel = places
                self.mapFromModelToPresentableModel()
            }, onError: { error in
                print(error)
            }).disposed(by: bag)
    }
    func getPresentableModel()-> BehaviorRelay<[PresentingCellDataSource]> {
        
        return presentableModel
    }
    func getPlacesPhotos(forVenueID: String) {
        placesService.fetchPhotos(venueID: forVenueID)
                  .subscribe(onNext: { photo in
                        
                      self.photoModel = photo
                      self.mapFromModelToPresentableModel()
                  }, onError: { error in
                      print(error)
            }).disposed(by: bag)
    }
    func getPhotoURL(forVenueID: String)->BehaviorRelay<String> {
        getPlacesPhotos(forVenueID: forVenueID)
        return photoURL
    }
    func mapPhotoModelIntoURL() {
        photoURL.accept(photoModel!.prefix + "100x100" + photoModel!.suffix)
    }
    func mapFromModelToPresentableModel() {
        guard let places = placesModel else {
            return
        }
        presentableModel.accept([])
        var temp: [PresentingCellDataSource] = []
        places.forEach { place in
            temp.append(PresentedCellDataSource(id: place.id, placeName: place.name, placeAddress: place.location.address ?? "Unknown address", placePhoto: ""))
        }
        presentableModel.accept(temp)
    }
    
}
