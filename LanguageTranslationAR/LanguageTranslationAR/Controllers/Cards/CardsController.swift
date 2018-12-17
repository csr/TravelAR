//
//  CardsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/17/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import ZLSwipeableViewSwift

class CardsController: UIViewController {
    
    let swipeableView: ZLSwipeableView = {
        let cv = ZLSwipeableView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let arView: CustomView = {
        let arView = CustomView()
        arView.translatesAutoresizingMaskIntoConstraints = false
        return arView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(arView)

        arView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        arView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        setupCardsView()
    }
    
    private func setupCardsView() {
        view.addSubview(swipeableView)
        
        swipeableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swipeableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        swipeableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        swipeableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        swipeableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        swipeableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true

        swipeableView.numberOfActiveView = 3
        swipeableView.nextView = {
            let view = UIView()
            view.backgroundColor = .red
            return view
        }
        swipeableView.loadViews() // optional, automatically call after nextView is set

//        var swipeableView = ZLSwipeableView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
//        view.addSubview(swipeableView)

    }
}

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        layer.cornerRadius = 10.0;
    }
}
