//
//  NeverClearView.swift
//  LanguageTranslationAR
//
// Related SO question: https://stackoverflow.com/questions/6745919/uitableviewcell-subview-disappears-when-cell-is-selected

import UIKit

class NeverClearView: UIView {
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != nil && backgroundColor!.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }
}
