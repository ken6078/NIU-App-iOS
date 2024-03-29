//
//  ImageWithColor.swift
//  NIU App
//
//  Created by Jacky Ben on 2023/9/19.
//

import UIKit

extension UIImage {
    
    // MARK: init
    convenience init?(imageName: String) {
        self.init(named: imageName)
        accessibilityIdentifier = imageName
    }
    
    // MARK: imageWithColor
    // https://stackoverflow.com/a/40177870/4488252
    func imageWithColor (newColor: UIColor?) -> UIImage? {

        if let newColor = newColor {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)

            let context = UIGraphicsGetCurrentContext()!
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.normal)

            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context.clip(to: rect, mask: cgImage!)

            newColor.setFill()
            context.fill(rect)

            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            newImage.accessibilityIdentifier = accessibilityIdentifier
            return newImage
        }
        
        if let accessibilityIdentifier = accessibilityIdentifier {
            return UIImage(imageName: accessibilityIdentifier)
        }

        return self
    }
}
