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
    public let detailText: String
    
    public init(dict: [String : String]?, font: UIFont = UIFont.systemFont(ofSize: 17), color: UIColor = .black) {
        if let dict = dict, let text = dict["text"] {
            self.text = text
        } else {
            self.text = "nil"
        }
        
        
        if let dict = dict, let detailText = dict["detailText"] {
            self.detailText = detailText
        } else {
            self.detailText = "Select"
        }
        
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
        
        view.detailTextLabel.text = state.detailText
        view.textLabel.text = state.text
    }
    
    public static func ==(lhs: LabelState, rhs: LabelState) -> Bool {
        return lhs.text == rhs.text
    }
}

public class SettingsView: UIView {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        return label
    }()
    
    let detailTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Test"
        label.textColor = .gray
        return label
    }()


    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black

        let stackView = UIStackView()
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(detailTextLabel)
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
