//
//  PlacesViewModel.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/24/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
enum LocationUpdateFrequency {
    case continuous
    case once
}
protocol PlacesViewModellable {

//    func getPhotoURL()->
    func getDataSource(locatioUpdateFrequency: LocationUpdateFrequency)-> BehaviorRelay<[PresentingCellDataSource]>
    func getPhotoURL(forVenueID: String)-> BehaviorRelay<String>

}
class PlacesViewModel: PlacesViewModellable {
    func getPhotoURL(forVenueID: String) -> BehaviorRelay<String> {
        return repo.getPhotoURL(forVenueID: forVenueID)
    }
    
    var repo: Repository
    
    var dataSource: Observable<[PresentingCellDataSource]>?
    init(repo: Repository) {
        self.repo = repo
    }
    func getPlaces(locatioUpdateFrequency: LocationUpdateFrequency) {
        repo.getLocationUpdates(frequency: locatioUpdateFrequency)
    }
    func getDataSource(locatioUpdateFrequency: LocationUpdateFrequency)-> BehaviorRelay<[PresentingCellDataSource]> {
        
        getPlaces(locatioUpdateFrequency: locatioUpdateFrequency)
        return repo.getPresentableModel()
        
    }
    
    deinit {
        print("deinit")
    }
}
