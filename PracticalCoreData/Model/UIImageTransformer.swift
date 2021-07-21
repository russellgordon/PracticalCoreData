//
//  UIImageTransformer.swift
//  UIImageTransformer
//
//  Created by Russell Gordon on 2021-07-21.
//

import Foundation
import SwiftUI

class UIImageTransformer: ValueTransformer {
   
    /*
     UIImage to Data
     
     “In this method, we check that the Any? that was provided as input is a UIImage and return nil if it’s not. Next, the image is converted to Data using NSKeyedArchiver”
     */
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else {
            return nil
        }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    /* Data to UIImage */
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        
        do {
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
            return image
        } catch {
            return nil
        }
    }
    
}
