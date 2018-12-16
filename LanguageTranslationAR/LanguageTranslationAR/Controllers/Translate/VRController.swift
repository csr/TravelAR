//
//  VRController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/16/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

import UIKit

class VRMenuController: UIViewController {

    let arView: ARView = {
        let view = ARView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(arView)
        
        arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        arView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        arView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }    
}
