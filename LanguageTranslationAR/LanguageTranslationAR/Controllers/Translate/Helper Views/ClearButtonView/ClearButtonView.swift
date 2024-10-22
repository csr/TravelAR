//
//  ClearButtonView.swift
//  LanguageTranslationAR
//

import UIKit

class ClearButtonView: UIVisualEffectView {
    override init(effect: UIVisualEffect?) {
        let blurEffect = UIBlurEffect(style: .prominent)
        super.init(effect: blurEffect)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "NAV_BAR_CLEAR".localized
        contentView.addSubview(label)
        label.fillToSuperview(constant: 13)
        
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layer.masksToBounds = true
        layer.cornerRadius = 15
        
        isUserInteractionEnabled = true
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
