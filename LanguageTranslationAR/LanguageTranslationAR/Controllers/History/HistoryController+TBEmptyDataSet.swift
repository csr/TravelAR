//
//  HistoryController+TBEmptyDataSet.swift
//  LanguageTranslationAR
//

import UIKit
import TBEmptyDataSet

extension HistoryController: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "EMPTY_STATE_TITLE".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func descriptionForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "EMPTY_STATE_DESCRIPTION".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return UIImage.emptyStateView
    }
    
    func verticalOffsetForEmptyDataSet(in scrollView: UIScrollView) -> CGFloat {
        return -100
    }
}
