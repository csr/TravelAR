//
//  HistoryCell.swift
//  LanguageTranslationAR
//

import UIKit
import FunctionalTableData

public typealias HistoryCell = HostCell<HistoryView, HistoryState, LayoutMarginsTableItemLayout>

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
        view.detailTextLabel.text = state.translationItem.originalText
        view.setFlag(for: state.translationItem.targetLanguage)
    }
    
    public static func ==(lhs: HistoryState, rhs: HistoryState) -> Bool {
        return lhs.translationItem == rhs.translationItem
    }
}
