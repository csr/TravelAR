//
//  HeaderCell.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 25/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation
import FunctionalTableData

public typealias HeaderCell = HostCell<HeaderView, HeaderState, LayoutMarginsTableItemLayout>


public struct HeaderState: Equatable {
    let height: CGFloat
    
    public init(height: CGFloat) {
        self.height = height
    }
    
    public static func updateView(_ view: HeaderView, state: HeaderState?) {}
    
    public static func ==(lhs: HeaderState, rhs: HeaderState) -> Bool {
        return false
    }
}
