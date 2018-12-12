//
//  PopoverTableViewCell.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData
import Flags

public typealias HistoryCell = HostCell<HistoryView, HistoryState, LayoutMarginsTableItemLayout>

public struct HistoryState: Equatable {
    
    public let translationItem: Translation
    
    public init(translationItem: Translation) {
        self.translationItem = translationItem
    }
    
    /// Update the view with the contents of the state.
    ///
    /// - Parameters:
    ///   - view: `UIView` that responds to this state.
    ///   - state: data to update the view with. If `nil` the view is being reused by the tableview.
    public static func updateView(_ view: HistoryView, state: HistoryState?) {
        guard let state = state else {
            return
        }
        
        view.textLabel.text = state.translationItem.translatedText
        view.detailTextLabel.text = state.translationItem.originalText
        view.setFlag(for: state.translationItem.targetLanguage)
    }
    
    public static func ==(lhs: HistoryState, rhs: HistoryState) -> Bool {
        return lhs.translationItem == rhs.translationItem
    }
}

public class HistoryView: UIView {

    var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .orange
        textLabel.text = "Test"
        textLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        return textLabel
    }()
    
    var detailTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        textLabel.text = "Test"
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return textLabel
    }()

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .black
    }
    
    private func setupView() {
        heightAnchor.constraint(equalToConstant: 77).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.spacing = 20
        
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(setupLabelsStackView())
    }
    
    private func setupLabelsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        textLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(detailTextLabel)
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return stackView
    }
    
    func setFlag(for countryCode: String?) {
        guard let countryCode = countryCode?.uppercased(), let flag = Flag(countryCode: countryCode) else { return }
        imageView.image = flag.image(size: CGSize(width: 50, height: 50), color: .black)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Flag {
    public func image(size: CGSize, color: UIColor = UIColor.white) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        emoji.draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: size.height)])
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}