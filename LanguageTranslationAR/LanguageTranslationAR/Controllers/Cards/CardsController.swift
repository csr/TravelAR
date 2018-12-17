//
//  CardsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/17/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class CardsController: UIViewController {
    
    let arView: CustomView = {
        let arView = CustomView()
        arView.translatesAutoresizingMaskIntoConstraints = false
        return arView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(arView)
        //arView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        arView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        arView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
