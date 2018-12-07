//
//  PopoverTableViewCell.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

//public typealias HistoryTableViewCell = HostCell<UILabel, LabelState, LayoutMarginsTableItemLayout>
//
//public struct LabelState: Equatable {
//    public let text: String
//    public let font: UIFont
//    public let color: UIColor
//    
//    public init(text: String, font: UIFont = UIFont.systemFont(ofSize: 17), color: UIColor = .black) {
//        self.text = text
//        self.font = font
//        self.color = color
//    }
//    
//    /// Update the view with the contents of the state.
//    ///
//    /// - Parameters:
//    ///   - view: `UIView` that responds to this state.
//    ///   - state: data to update the view with. If `nil` the view is being reused by the tableview.
//    public static func updateView(_ view: UILabel, state: LabelState?) {
//        guard let state = state else {
//            view.text = nil
//            view.font = UIFont.systemFont(ofSize: 17)
//            view.textColor = .black
//            return
//        }
//        
//        view.text = state.text
//        view.font = state.font
//        view.textColor = state.color
//    }
//    
//    public static func ==(lhs: LabelState, rhs: LabelState) -> Bool {
//        return lhs.text == rhs.text && lhs.font == rhs.font && lhs.color == rhs.color
//    }
//}

//class HistoryTableViewCell: UITableViewCell {
//
//    static let identifier = "PopoverTableViewCell"
//
//    var item: Translation? {
//        didSet {
//            guard let item = item else { return }
//            textLabel?.text = item.translatedText
//            detailTextLabel?.text = item.originalText
//        }
//    }
//
//    var soundImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = UIImage(named: "sound")
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFit
//        return iv
//    }()
//
//    let objectImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        return iv
//    }()
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: .subtitle, reuseIdentifier: HistoryTableViewCell.identifier)
//        setupLabels()
//        setupImageView()
//        setupObjectImageView()
//    }
//
//    private func setupObjectImageView() {
//        addSubview(objectImageView)
//        objectImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        objectImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        objectImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        objectImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
//    }
//
//    private func setupLabels() {
//        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
//        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
//        textLabel?.font = UIFont(name: "CircularStd-Book", size: 25)
//        textLabel?.numberOfLines = 0
//        detailTextLabel?.font = UIFont(name: "CircularStd-Book", size: 14)
//        detailTextLabel?.numberOfLines = 0
//    }
//
//    private func setupImageView() {
//        addSubview(soundImageView)
//        if let label = textLabel {
//            soundImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
//            soundImageView.heightAnchor.constraint(equalToConstant: 13).isActive = true
//            soundImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 2).isActive = true
//            soundImageView.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 3).isActive = true
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
