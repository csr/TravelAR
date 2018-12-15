//
//  AddButtonView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/13/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class AddButtonView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height/2
        setupInnerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Outer circle
        UIColor.white.withAlphaComponent(0.5).setFill()
        let outerPath = UIBezierPath(ovalIn: rect)
        outerPath.fill()
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        context.setBlendMode(.destinationOut)
        
        // Center circle
        UIColor.blue.setFill()
        let centerRect = rect.insetBy(dx: rect.width * 0.55 / 2, dy: rect.height * 0.55 / 2)
        let centerPath = UIBezierPath(ovalIn: centerRect)
        centerPath.fill()
        
        context.restoreGState()
    }

    let plusButton: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        //view.isHidden = true
        return view
    }()

    private func setupPlusLayer() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: plusButton.frame.midX, y: plusButton.frame.midY-20))
        path.addLine(to: CGPoint(x: plusButton.frame.midX, y: plusButton.frame.midY+20))
        path.move(to: CGPoint(x: plusButton.frame.midX-20, y: plusButton.frame.midY))
        path.addLine(to: CGPoint(x: plusButton.frame.midX+20, y: plusButton.frame.midY))
        path.usesEvenOddFillRule = true

        let shapeLayer = CAShapeLayer()
        shapeLayer.fillRule = .evenOdd
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4

        plusButton.layer.addSublayer(shapeLayer)
    }

    private func setupInnerView() {
        addSubview(plusButton)
        plusButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            self.plusButton.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        }, completion: nil)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
            self.plusButton.transform = .identity
        }, completion: { _ in
            let impact = UIImpactFeedbackGenerator()
            impact.impactOccurred()
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        plusButton.layer.cornerRadius = frame.height/2
        setupPlusLayer()
    }
}
