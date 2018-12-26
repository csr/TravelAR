//
//  CardsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import ZLSwipeableViewSwift
import RandomColor

class CardsController: UIViewController {
    
    var swipeableView: ZLSwipeableView = {
        let swipeableView = ZLSwipeableView()
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        return swipeableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.addSubview(swipeableView)
        setupSwipeableView()
    }
    
    private func setupSwipeableView() {
        view.addSubview(swipeableView)
        swipeableView.fillToSuperview(constant: 50)
    }
    
    func nextCardView() -> UIView? {
        let cardView = CardView(frame: swipeableView.bounds)
        let randomTranslation = TranslationItems.shared.getRandomItem()
        cardView.translation = randomTranslation
        
        let hello = randomColor(hue: .random, luminosity: .dark)
        cardView.backgroundColor = hello
        return cardView
    }
}
