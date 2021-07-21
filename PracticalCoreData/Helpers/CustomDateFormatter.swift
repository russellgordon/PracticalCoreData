//
//  CustomDateFormatter.swift
//  CustomDateFormatter
//
//  Created by Russell Gordon on 2021-07-21.
//

import Foundation

class CustomDateFormatter: DateFormatter, ObservableObject {
    
    override init() {
        super.init()
        self.dateFormat = "dd/MM/yyyy"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
