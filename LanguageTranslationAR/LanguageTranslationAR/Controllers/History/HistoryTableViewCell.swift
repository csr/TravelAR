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
    
    public let translationItem: Translation
    
    public init(translationItem: Translation) {
        self.translationItem = translationItem
    }
    
    public static func updateView(_ view: HistoryView, state: HistoryState?) {
        guard let state = state else {
            return
        }
        
        view.textLabel.text = state.translationItem.translatedText
        
        //view.imageView
        
//        view.text = state.text
//        view.font = state.font
//        view.textColor = state.color
    }
    
    public static func ==(lhs: HistoryState, rhs: HistoryState) -> Bool {
        return lhs.translationItem == rhs.translationItem
    }
}

public class HistoryView: UIView {

    var textLabel: UILabel = {
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
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.spacing = 15
        
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.backgroundColor = .red
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)

        // Audio image view
//        let soundImageView = UIImageView()
//        soundImageView.image = #imageLiteral(resourceName: "scanning-my-sketch.png")
//        soundImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
//        soundImageView.heightAnchor.constraint(equalToConstant: 13).isActive = true
//
//        stackView.addArrangedSubview(soundImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
