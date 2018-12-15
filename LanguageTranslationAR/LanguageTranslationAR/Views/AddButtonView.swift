//
//  AddButtonView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/13/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import CoreGraphics

class AddButtonView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Outer circle
        UIColor.red.setFill()
        let outerPath = UIBezierPath(ovalIn: rect)
        outerPath.fill()
        
        // Center circle
        UIColor.blue.setFill()
        let centerRect = rect.insetBy(dx: rect.width * 0.55 / 2, dy: rect.height * 0.55 / 2)
        let centerPath = UIBezierPath(ovalIn: centerRect)
        centerPath.fill()
    }
    
//    let backgroundView: UIView = {
//        let view = UIView()
//        //view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .white
//        view.layer.masksToBounds = true
//        view.isHidden = true
//        return view
//    }()
//
//    let plusButton: UIImageView = {
//        let view = UIImageView()
//        view.isUserInteractionEnabled = true
//        view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.masksToBounds = true
//        return view
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layer.masksToBounds = true
//        layer.cornerRadius = self.frame.height/2
//        setupInnerView()
//        setupPlusLayer()
//    }
//
//    private func setupInnerView() {
//        addSubview(backgroundView)
//        backgroundView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
//        backgroundView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
//        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//
////        addSubview(plusButton)
////        plusButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
////        plusButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
////        plusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
////        plusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//    }
//
//    private func setupPlusLayer() {
//
//        // create path
//
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: plusButton.frame.midX, y: plusButton.frame.midY-20))
//        path.addLine(to: CGPoint(x: plusButton.frame.midX, y: plusButton.frame.midY+20))
//
//        let path2 = UIBezierPath()
//        path.move(to: CGPoint(x: plusButton.frame.midX-20, y: plusButton.frame.midY))
//        path.addLine(to: CGPoint(x: plusButton.frame.midX+20, y: plusButton.frame.midY))
//
//
//        // Create a `CAShapeLayer` that uses that `UIBezierPath`:
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        shapeLayer.strokeColor = UIColor.clear.cgColor
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineWidth = 4
//
//        let shapeLayer2 = CAShapeLayer()
//        shapeLayer2.path = path2.cgPath
//        shapeLayer2.strokeColor = UIColor.clear.cgColor
//        shapeLayer2.fillColor = UIColor.clear.cgColor
//        shapeLayer2.lineWidth = 4
//
//        // Add that `CAShapeLayer` to your view's layer:
//
//        plusButton.layer.addSublayer(shapeLayer)
//        plusButton.layer.addSublayer(shapeLayer2)
//
//
////        CALayer *hLayer = [CALayer layer];//this is the left - right stroke
////        hLayer.frame = CGRectMake(0, CGRectGetMidY(self.bounds)-(height/2), width, height);
////        hLayer.cornerRadius = cornerRadius;
////
////        CALayer *vLayer = [CALayer layer];// this is the top - bottom stroke
////        vLayer.frame = CGRectMake(CGRectGetMidX(self.bounds) - (height/2), -3,height, width);
////        vLayer.cornerRadius = cornerRadius;
////
////        [self.layer addSublayer:hLayer];
////        [self.layer addSublayer:vLayer];
//
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
//            self.plusButton.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
//        }, completion: nil)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
//            self.plusButton.transform = .identity
//        }, completion: { _ in
//            let impact = UIImpactFeedbackGenerator()
//            impact.impactOccurred()
//        })
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.cornerRadius = frame.height/2
//        backgroundView.layer.cornerRadius = frame.height/2
//        plusButton.layer.cornerRadius = frame.height/2
//        setupPlusLayer()
//
//    }
//
}
