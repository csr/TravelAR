//
//  SettingsCell.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/12/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData

public typealias LabelCell = HostCell<SettingsView, LabelState, LayoutMarginsTableItemLayout>

/// A very simple state for a `UILabel` allowing a quick configuration of its text, font, and color values.
public struct LabelState: Equatable {
    public let text: String
    public let font: UIFont
    public let color: UIColor
    
    public init(text: String, font: UIFont = UIFont.systemFont(ofSize: 17), color: UIColor = .black) {
        self.text = text
        self.font = font
        self.color = color
    }
    
    /// Update the view with the contents of the state.
    ///
    /// - Parameters:
    ///   - view: `UIView` that responds to this state.
    ///   - state: data to update the view with. If `nil` the view is being reused by the tableview.
    public static func updateView(_ view: SettingsView, state: LabelState?) {
        guard let state = state else {
            return
        }
        
        view.textLabel.text = state.text
    }
    
    public static func ==(lhs: LabelState, rhs: LabelState) -> Bool {
        return lhs.text == rhs.text && lhs.font == rhs.font && lhs.color == rhs.color
    }
}

public class SettingsView: UIView {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.addArrangedSubview(textLabel)
        heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
