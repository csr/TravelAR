//
//  ARDetailView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/18/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import SceneKit.SCNNode

class ARDetailView: UIView, NibView {
    
    var node: SCNNode?
    var delegate: ARDetailViewDelegate?
    
    var customConstraints: [NSLayoutConstraint] = []
    
    var translation: Translation? {
        didSet {
            if let translation = translation {
                labelTranslatedText.text = translation.translatedText
                labelOriginalText.text = translation.originalText
            }
        }
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTranslatedText: UILabel!
    @IBOutlet weak var labelOriginalText: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var reproduceButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 18
        
        
        buttonClose.setTitle("MENU_ACTION_CLOSE".localized(), for: .normal)
        reproduceButton.setTitle("MENU_ACTION_REPRODUCE".localized(), for: .normal)
        labelTitle.text = "TRANSLATION".localized()

    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @IBAction func didTapReproduceButton(_ sender: UIButton) {
        guard let translation = translation else { return }
        self.delegate?.didTapReproduce(translation: translation)
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.delegate?.didTapClose()
        }
    }
    
    func show() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        customConstraints = [centerXAnchor.constraint(equalTo: view.centerXAnchor),
                             centerYAnchor.constraint(equalTo: view.centerYAnchor),
                             widthAnchor.constraint(equalToConstant: 350)]
        NSLayoutConstraint.activate(customConstraints)
        
        UIView.animate(withDuration: 0.2,  delay: 0, options: [.curveEaseOut], animations: {
            view.layoutIfNeeded()
        })
    }
}
