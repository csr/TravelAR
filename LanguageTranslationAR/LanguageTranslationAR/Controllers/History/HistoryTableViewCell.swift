//
//  PopoverTableViewCell.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData

public typealias HistoryTableViewCell = HostCell<HistoryView, HistoryState, LayoutMarginsTableItemLayout>

public struct HistoryState: Equatable {
    public let text: String
    public let font: UIFont
    public let color: UIColor
    
    public init(text: String, font: UIFont = UIFont.systemFont(ofSize: 17), color: UIColor = .black) {
        self.text = text
        self.font = font
        self.color = color
    }
    
    public static func updateView(_ view: HistoryView, state: HistoryState?) {
        guard let state = state else {
//            view.text = nil
//            view.font = UIFont.systemFont(ofSize: 17)
//            view.textColor = .black
            return
        }
        
//        view.text = state.text
//        view.font = state.font
//        view.textColor = state.color
    }
    
    public static func ==(lhs: HistoryState, rhs: HistoryState) -> Bool {
        return lhs.text == rhs.text && lhs.font == rhs.font && lhs.color == rhs.color
    }
}

public class HistoryView: UIView {

    var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        textLabel.text = "Test"
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
    }
    
    private func setupView() {
        heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.backgroundColor = .red
        stackView.addSubview(imageView)

//        soundImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
//        soundImageView.heightAnchor.constraint(equalToConstant: 13).isActive = true
//        soundImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 2).isActive = true
//        soundImageView.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 3).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
