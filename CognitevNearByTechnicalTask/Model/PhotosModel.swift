//
//  PhotosModel.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/28/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import Foundation

struct PhotosAndMetaResponse: Codable {
    let response: PhotosResponse
}
struct PhotosResponse: Codable {
    let photos: Photos?
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let prefix: String
    let suffix: String
    let width, height: Int
    
}

