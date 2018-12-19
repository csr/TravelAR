//
//  ZLSwipeableViewController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import ZLSwipeableViewSwift
import RandomColor

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
        view.backgroundColor = .black
        view.clipsToBounds = true
        
        swipeableView = ZLSwipeableView()
        view.addSubview(swipeableView)
        swipeableView.didStart = {view, location in
        }
        swipeableView.swiping = {view, location, translation in
        }
        swipeableView.didEnd = {view, location in
        }
        swipeableView.didSwipe = {view, direction, vector in
        }
        swipeableView.didCancel = {view in
        }
        swipeableView.didTap = {view, location in
        }
        swipeableView.didDisappear = { view in
        }
        
        setupSwipeableView()
    }
    
    private func setupSwipeableView() {
        view.addSubview(swipeableView)
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        swipeableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        swipeableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50).isActive = true
        swipeableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50).isActive = true
        swipeableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        setupCustomAnimation()
    }
    
    private func setupCustomAnimation() {
        func toRadian(_ degree: CGFloat) -> CGFloat {
            return degree * CGFloat(Double.pi/180)
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
        
        
        
        let hello = randomColor(hue: .random, luminosity: .dark)
        cardView.backgroundColor = hello

        return cardView
    }
}
