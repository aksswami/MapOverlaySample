//
//  ViewController.swift
//  MapOverlaySample
//
//  Created by Amit Kumar Swami on 3/2/19.
//  Copyright © 2019 aks. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit

class ViewController: UIViewController {

    var mapView: GMSMapView?
    var index = 1
    var overlay: GMSOverlay?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mapView = GMSMapView()
        view.addSubview(mapView!)
        
        let removeOverlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        removeOverlayButton.setTitle("Remove Overlay", for: .normal)
        removeOverlayButton.addTarget(self, action: #selector(removeOverlay), for: .touchUpInside)
        removeOverlayButton.backgroundColor = .gray
        
        let addOverlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        addOverlayButton.setTitle("Add Overlay", for: .normal)
        addOverlayButton.addTarget(self, action: #selector(addOverlay), for: .touchUpInside)
        addOverlayButton.backgroundColor = .gray
        
        let stackview = UIStackView(arrangedSubviews: [addOverlayButton, removeOverlayButton])
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        
        view.addSubview(stackview)
        stackview.snp.makeConstraints { make in
            make.trailing.top.leading.equalToSuperview()
            make.height.equalTo(50)
        }
        
        mapView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        let overlayBound = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: 29.82, longitude: -113.06), coordinate: CLLocationCoordinate2D(latitude: 33.95, longitude: -109.195))
        overlay = GMSGroundOverlay(bounds: overlayBound, icon: UIImage(named: "overlay1"))
        overlay?.map = mapView
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.765, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    @objc func updateTime() {
        index += 1
        if index > 7 {
            index = 1
        }
        let overlayBound = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: 29.82, longitude: -113.06), coordinate: CLLocationCoordinate2D(latitude: 33.95, longitude: -109.195))
        overlay?.map = nil
        overlay = nil
        overlay = GMSGroundOverlay(bounds: overlayBound, icon: UIImage(named: "overlay\(index)"))
        overlay?.map = mapView
    }

    @objc func removeOverlay() {
        timer?.invalidate()
        overlay?.map = nil
        overlay = nil
    }
    
    @objc func addOverlay() {
        timer = Timer.scheduledTimer(timeInterval: 0.765, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        timer?.fire()
    }

}

