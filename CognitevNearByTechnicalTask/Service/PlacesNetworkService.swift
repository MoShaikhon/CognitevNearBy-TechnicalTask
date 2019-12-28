//
//  PlacesNetworkService.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/25/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import Foundation
import RxSwift
import RxCoreLocation
import CoreLocation
import RxRelay
//api.foursquare.com/v2/venues/search?ll=29.9770322,30.9442229&client_id=BJL3B5TJJVDXEDOYPVPV3CLNJINGTQWEOGIGSTV3DF53AEJ3&client_secret=J0SSCV54FU0W0EPESDXHWBVMAAZPYVFJHKYPMFSWR5DVYASI&v=20190609&radius=1000
// https://api.foursquare.com/v2/venues/43695300f964a5208c291fe3/photos?&client_id=BJL3B5TJJVDXEDOYPVPV3CLNJINGTQWEOGIGSTV3DF53AEJ3&client_secret=J0SSCV54FU0W0EPESDXHWBVMAAZPYVFJHKYPMFSWR5DVYASI&v=20191212

extension URLComponents {
    
    mutating func getPlacesURL( lat: String, lng: String, radius: String)-> URL {
        let url = constructPlacesEndPoint(lat: lat, lng: lng, radius: radius)
        return url
    }
    private mutating func constructPlacesEndPoint(lat: String, lng: String, radius: String)-> URL {
        let latLng = lat + "," + lng
        self.scheme = "https"
        self.host = "api.foursquare.com"
        self.path = "/v2/venues/search"
        let queryParams = ["client_id": "BJL3B5TJJVDXEDOYPVPV3CLNJINGTQWEOGIGSTV3DF53AEJ3", "client_secret": "J0SSCV54FU0W0EPESDXHWBVMAAZPYVFJHKYPMFSWR5DVYASI", "ll": latLng, "v": "20191212", "radius": radius]
        self.setQueryItems(with: queryParams)
        return self.url!
    }
    mutating func getPhotosURL(venueID: String)->URL {
        return constructPhotosEndPoint(venueID: venueID)
    }
    private mutating func constructPhotosEndPoint(venueID: String)-> URL {
          self.scheme = "https"
          self.host = "api.foursquare.com"
          self.path = "/v2/venues/" + venueID + "/photos"
          let queryParams = ["client_id": "BJL3B5TJJVDXEDOYPVPV3CLNJINGTQWEOGIGSTV3DF53AEJ3", "client_secret": "J0SSCV54FU0W0EPESDXHWBVMAAZPYVFJHKYPMFSWR5DVYASI"]
          self.setQueryItems(with: queryParams)
          return self.url!
      }
      private mutating func setQueryItems(with parameters: [String: String]) {
          self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
      }
      
}



protocol PlacesService {
    func fetchPlaces(lat: String, lng: String, radius: String)-> Observable<[Venue]>
    func fetchPhotos(venueID: String)-> Observable<Item>
    
}
class PlacesNetworkService: PlacesService {
    
    
    func fetchPhotos(venueID: String) -> Observable<Item> {
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
                let url = Bundle.main.url(forResource: "photos", withExtension: "json")!
        
//        var urlComponents = URLComponents()

//        let url = urlComponents.getPhotosURL(venueID: venueID)
        return Observable<Item>.create {[weak self] observer in
            
            dataTask = defaultSession.dataTask(with: url){ (data: Data?, response: URLResponse?, error: Error?) in
                
                if let error = error {
                    // Handle Error
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    // Handle Empty Data
                    return
                }
                
                do{
                    let photoResponse: PhotosAndMetaResponse = try JSONDecoder().decode(PhotosAndMetaResponse.self, from: data)
                    if let photos = photoResponse.response.photos {
                    observer.onNext(photos.items[0])
                    }else {
                        observer.onCompleted()

                    }
                    
                }catch let err {
                    observer.onError(err)
                }
                observer.onCompleted()
                
            }
            dataTask?.resume()
            return Disposables.create {
                dataTask?.cancel()
            }
        }
    }
    
    
    func fetchPlaces(lat: String, lng: String, radius: String)-> Observable<[Venue]> {
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        var urlComponents = URLComponents()
        
        let url = urlComponents.getPlacesURL(lat: lat, lng: lng, radius: radius)
        //        let url = Bundle.main.url(forResource: "places", withExtension: "json")!
        
        return Observable<[Venue]>.create {[weak self] observer in
            
            dataTask = defaultSession.dataTask(with: url){ (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    // Handle Error
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    // Handle Empty Data
                    return
                }
                
                do{
                    let place: Response = try JSONDecoder().decode(Response.self, from: data)
                    observer.onNext(place.response.venues)
                    
                }catch let err {
                    observer.onError(err)
                }
                observer.onCompleted()
                
                // Handle Decode Data into Model
            }
            dataTask?.resume()
            return Disposables.create {
                dataTask?.cancel()
            }
        }
    }
    
}
