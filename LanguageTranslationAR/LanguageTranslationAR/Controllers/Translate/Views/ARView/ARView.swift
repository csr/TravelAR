//
//  ARView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/16/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

//https://stackoverflow.com/a/51273002/1135714

//class ARView: UIView, XibLoadable {
//    
//   // @IBOutlet weak var textLabel: UILabel!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////        addSubview(view)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//

protocol XibLoadable {
    associatedtype CustomViewType
    static func loadFromXib() -> CustomViewType
}

extension XibLoadable where Self: UIView {
    static func loadFromXib() -> Self {
        let nib = UINib(nibName: "\(self)", bundle: Bundle(for: self))
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            // your app should crash if the xib doesn't exist
            preconditionFailure("Couldn't load xib for view: \(self)")
        }
        return customView
    }
}
