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
    public let descriptionText: String
    public let detailText: String
    
    public init(dict: [String : String]?) {
        guard let dict = dict else {
            self.descriptionText = "nil"
            self.detailText = "Select"
            return
        }
        self.descriptionText = dict["text"] ?? "nil"
        self.detailText = dict["detailText"] ?? "Select"
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
        view.textLabel.text = state.descriptionText
        view.detailTextLabel.text = state.detailText
    }
    
    public static func ==(lhs: LabelState, rhs: LabelState) -> Bool {
        return lhs.descriptionText == rhs.descriptionText && lhs.detailText == rhs.detailText
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
        setupLabels()
    }
    
    private func setupLabels() {
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
