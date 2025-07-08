//
//  UIImageExtension.swift
//  Spontaneous
//
//  Created by John Crawley on 06/02/2024.
//

//MARK: - Import List
import Foundation
import UIKit
//MARK: - UI Image Extension
extension UIImage
{
    //MARK: - Image rotated
    func rotated(by degrees: CGFloat) -> UIImage?
    {
          let radians = degrees * .pi / 180
          var newSize = CGRect(origin: CGPoint.zero, size: self.size)
                          .applying(CGAffineTransform(rotationAngle: radians)).integral.size

          newSize.width = floor(newSize.width)
          newSize.height = floor(newSize.height)

          UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
          guard let context = UIGraphicsGetCurrentContext() else { return nil }

          context.translateBy(x: newSize.width/2, y: newSize.height/2)
          context.rotate(by: radians)
          self.draw(in: CGRect(x: -self.size.width/2,
                               y: -self.size.height/2,
                               width: self.size.width,
                               height: self.size.height))

          let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return rotatedImage
      }
    
    
    //MARK: - image With Colour
    func imageWithColour(colour: UIColor) -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        guard let cgImage = cgImage else { return nil }
        let rect = CGRect(origin: .zero, size: size)
        // Draw the image with its original colors
        draw(in: rect)
        // Save the graphics state
        context.saveGState()
        // Flip the context
        context.translateBy(x: 0, y: rect.height)
        context.scaleBy(x: 1.0, y: -1.0)
        // Mask the context using the original image
        context.clip(to: rect, mask: cgImage)
        // Fill the context with the desired color only outside the masked area
        context.setFillColor(colour.cgColor)
        context.fill(rect)
        // Restore the graphics state
        context.restoreGState()
        // Create a new image from the context
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return coloredImage
    }
    
    
    
    
    
// MARK: - Rotate Image


    
    
    
    
    
    
    
    
    
    
    
}
