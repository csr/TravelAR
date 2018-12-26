//
//  SettingsCell.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/12/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData

public typealias LabelCell = HostCell<SettingsView, SettingsState, LayoutMarginsTableItemLayout>

/// A very simple state for a `UILabel` allowing a quick configuration of its text, font, and color values.
public struct SettingsState: Equatable {
    
    public let text: String
    public let imageName: String
    public let imageBgColor: UIColor
    public let detailText: String?
    public let selector: Selector
    
    public init(text: String, detailText: String? = nil, imageName: String, imageBgColor: UIColor, selector: Selector) {
        self.text = text
        self.detailText = detailText
        self.imageName = imageName
        self.imageBgColor = imageBgColor
        self.selector = selector
    }
    
    public static func updateView(_ view: SettingsView, state: SettingsState?) {
        guard let state = state else {
            return
        }
        
        view.textLabel.text = state.text
        view.detailTextLabel.text = state.detailText
        view.imageView.image = UIImage(named: state.imageName)?.withRenderingMode(.alwaysTemplate)
        view.imageView.tintColor = .white
        view.bgImageView.backgroundColor = state.imageBgColor
    }
    
    public static func ==(lhs: SettingsState, rhs: SettingsState) -> Bool {
        return lhs.text == rhs.text && lhs.imageName == rhs.imageName && lhs.detailText == rhs.detailText && lhs.imageBgColor == rhs.imageBgColor
    }
}
