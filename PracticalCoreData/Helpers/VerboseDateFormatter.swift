//
//  VerboseDateFormatter.swift
//  VerboseDateFormatter
//
//  Created by Russell Gordon on 2021-07-21.
//

import Foundation

class VerboseDateFormatter: DateFormatter, ObservableObject {
    
    override init() {
        super.init()
        self.dateStyle = .full
        self.timeStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
