//
//  CompositionRoot.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/24/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import Foundation
import UIKit

class CompositionRoot {
    
    func compose(window: UIWindow) {
        
        window.rootViewController = UINavigationController(rootViewController: PlacesViewController(placesViewModel: PlacesViewModel(repo: Repository(placesService: PlacesNetworkService(), locationService: PlacesLocationService()))))
        
    }
}
