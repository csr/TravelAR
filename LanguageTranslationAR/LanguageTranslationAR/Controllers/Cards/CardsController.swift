//
//  CardsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/17/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import ZLSwipeableViewSwift

class CardsController: ZLSwipeableViewController {
}

class ZLSwipeableViewController: UIViewController {
    
    var swipeableView: ZLSwipeableView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        view.clipsToBounds = true
        
        swipeableView = ZLSwipeableView()
        view.addSubview(swipeableView)
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view")
        }
        
        view.addSubview(swipeableView)
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        swipeableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        swipeableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50).isActive = true
        swipeableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50).isActive = true
        swipeableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
        setupCustomAnimation()
    }
    
    private func setupCustomAnimation() {
        func toRadian(_ degree: CGFloat) -> CGFloat {
            return degree * CGFloat(M_PI/180)
        }
        func rotateAndTranslateView(_ view: UIView, forDegree degree: CGFloat, translation: CGPoint, duration: TimeInterval, offsetFromCenter offset: CGPoint, swipeableView: ZLSwipeableView) {
            UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                view.center = swipeableView.convert(swipeableView.center, from: swipeableView.superview)
                var transform = CGAffineTransform(translationX: offset.x, y: offset.y)
                transform = transform.rotated(by: toRadian(degree))
                transform = transform.translatedBy(x: -offset.x, y: -offset.y)
                transform = transform.translatedBy(x: translation.x, y: translation.y)
                view.transform = transform
            }, completion: nil)
        }
        swipeableView.numberOfActiveView = 10
        swipeableView.animateView = {(view: UIView, index: Int, views: [UIView], swipeableView: ZLSwipeableView) in
            let degree = CGFloat(sin(0.5*Double(index)))
            let offset = CGPoint(x: 0, y: swipeableView.bounds.height*0.3)
            let translation = CGPoint(x: degree*10, y: CGFloat(-index*5))
            let duration = 0.4
            rotateAndTranslateView(view, forDegree: degree, translation: translation, duration: duration, offsetFromCenter: offset, swipeableView: swipeableView)
        }

    }
    
    // MARK: - Actions
    
    // MARK: ()
    func nextCardView() -> UIView? {
        let cardView = CardView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        swipeableView.addSubview(cardView)
        cardView.heightAnchor.constraint(equalTo: swipeableView.heightAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: swipeableView.widthAnchor).isActive = true
        cardView.backgroundColor = .red
        return cardView
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
