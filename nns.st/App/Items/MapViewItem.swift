//
//  MapViewItem.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/19.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import MapKit

class MapViewItem: NSObject {
    
    let coordinate: CLLocationCoordinate2D
    let title: String
    let distance: CGFloat
    
    init(coordinate: CLLocationCoordinate2D, title: String, distance: CGFloat) {
        self.coordinate = coordinate
        self.title = title
        self.distance = distance
    }
    
    deinit { }
    
}

