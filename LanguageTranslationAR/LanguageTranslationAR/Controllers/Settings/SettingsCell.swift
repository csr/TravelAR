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
        view.detailTextLabel.text = state.detailText
        view.imageView.image = UIImage(named: state.imageName)?.withRenderingMode(.alwaysTemplate)
        view.imageView.tintColor = .white
        view.bgImageView.backgroundColor = state.imageBgColor
    }
    
    public static func ==(lhs: LabelState, rhs: LabelState) -> Bool {
        return lhs.text == rhs.text && lhs.imageName == rhs.imageName && lhs.detailText == rhs.detailText && lhs.imageBgColor == rhs.imageBgColor
    }
}

public class SettingsView: UIView {
    
    let bgImageView: NeverClearView = {
        let view = NeverClearView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "translate")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        return label
    }()
    
    let detailTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Test"
        label.textColor = .gray
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupView()
    }
    
    private func setupImageView() {
        bgImageView.widthAnchor.constraint(equalToConstant: 27).isActive = true
        bgImageView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        bgImageView.addSubview(imageView)
        bgImageView.backgroundColor = .white
        
        imageView.centerXAnchor.constraint(equalTo: bgImageView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: bgImageView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: bgImageView.widthAnchor, multiplier: 0.6).isActive = true
        imageView.heightAnchor.constraint(equalTo: bgImageView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func setupView() {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.fillToSuperview()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.addArrangedSubview(bgImageView)
        stackView.addArrangedSubview(getLabelsStackView())
    }
    
    private func getLabelsStackView() -> UIStackView {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(textLabel)
        textLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        stackView.addArrangedSubview(detailTextLabel)
        return stackView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
