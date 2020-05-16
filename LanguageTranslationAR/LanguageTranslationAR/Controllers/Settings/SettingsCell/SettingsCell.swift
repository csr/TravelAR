//
//  SettingsCell.swift
//  LanguageTranslationAR
//

import UIKit
import FunctionalTableData

public typealias LabelCell = HostCell<SettingsView, SettingsState, LayoutMarginsTableItemLayout>

/// A very simple state for a `UILabel` allowing a quick configuration of its text, font, and color values.
public struct SettingsState: Equatable {
    
    public let text: String
    public let imageBgColor: UIColor
    public let detailText: String?
    public let image: UIImage?
    public let selector: Selector
    
    public init(text: String, detailText: String? = nil, image: UIImage?, imageBgColor: UIColor, selector: Selector) {
        self.text = text
        self.detailText = detailText
        self.image = image
        self.imageBgColor = imageBgColor
        self.selector = selector
    }
    
    public static func updateView(_ view: SettingsView, state: SettingsState?) {
        guard let state = state else {
            return
        }
        
        view.textLabel.text = state.text
        view.detailTextLabel.text = state.detailText
        view.imageView.image = state.image?.withRenderingMode(.alwaysTemplate)
        view.imageView.tintColor = .white
        view.bgImageView.backgroundColor = state.imageBgColor
    }
    
    public static func ==(lhs: SettingsState, rhs: SettingsState) -> Bool {
        return lhs.text == rhs.text && lhs.detailText == rhs.detailText && lhs.imageBgColor == rhs.imageBgColor
    }
}
