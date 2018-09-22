//
//  SnapShotMaker.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/19.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit


class SnapShotMaker {
    
    static func drawSnapshot(coordinate: CLLocationCoordinate2D, source: UIImageView, span: MKCoordinateSpan = MKCoordinateSpanMake(0.003, 0.003), pinColor: UIColor) {
        let options = MKMapSnapshotOptions()
        options.size = source.frame.size
        options.region = MKCoordinateRegion(center: coordinate, span: span)
        options.scale = UIScreen.main.scale
        options.mapType = .standard
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start(completionHandler: {(snapshot, error) in
            if let snapshot = snapshot {
                source.image = self.dropPin(snapshot: snapshot, coordinate: coordinate, pinColor: pinColor)
            }
        })
    }
    
    private static func dropPin(snapshot: MKMapSnapshot, coordinate: CLLocationCoordinate2D, pinColor:UIColor) -> UIImage {
        let annotationView = MKPinAnnotationView(annotation: nil, reuseIdentifier: "Pin")
        annotationView.pinTintColor = pinColor
        
        let pinImg = annotationView.image
        UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
        snapshot.image.draw(at: CGPoint(x: 0.0, y: 0.0))
        pinImg?.draw(at: self.centeringPoint(originPoint: snapshot.point(for: coordinate), annotation: annotationView))
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage!
    }
    
    private static func centeringPoint(originPoint: CGPoint, annotation: MKPinAnnotationView) -> CGPoint {
        let pinCenterOffset = annotation.centerOffset
        var _originPoint = originPoint
        _originPoint.x -= annotation.bounds.size.width / 2.0
        _originPoint.y -= annotation.bounds.size.height / 2.0
        _originPoint.x += pinCenterOffset.x
        _originPoint.y += pinCenterOffset.y
        return _originPoint
    }
    
}
