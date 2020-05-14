//
//  HistoryController+TBEmptyDataSet.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 5/14/20.
//  Copyright © 2020 Cesare de Cal. All rights reserved.
//

import UIKit
import TBEmptyDataSet

extension HistoryController: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: "EMPTY_STATE_TITLE".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return attributedString
    }
    
    func descriptionForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: "EMPTY_STATE_DESCRIPTION".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return attributedString
    }
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return #imageLiteral(resourceName: "empty-state-view")
    }
    
    func verticalOffsetForEmptyDataSet(in scrollView: UIScrollView) -> CGFloat {
        return -100
    }
}
