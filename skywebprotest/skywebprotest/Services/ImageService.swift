//
//  ImageService.swift
//  FinchTest
//
//  Created by vns on 13.02.2021.
//

import Foundation
import UIKit

final class ImageService: NSObject {
    
    //MARK: Private API methods
    
    private static func drawRectangle(with width:Int, height: Int) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))

        let img =  renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: width, height: height)

            ctx.cgContext.setFillColor(UIColor.random.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.random.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        return img
    }
    
    //MARK: Public API methods
    
    public static func generateRandomImage(with name: String, width: Int, height: Int) -> Void {
        
        let image: UIImage? = self.drawRectangle(with: width, height: height)
        saveImage(from: image, to: name)

    }
    
    static public func saveImage(from image: UIImage?, to filename: String) -> Void {
        
        guard let image = image else {return}
        let imageData = image.pngData()
        let filename = getDocumentsDirectory().appendingPathComponent("\(filename).png")
        try? imageData?.write(to: filename)
    }
    
    static public func saveTempImage(from image: UIImage?, to filename: String) -> Void {
        
        guard let image = image else {return}
        let imageData = image.pngData()
        let filename = getTempDirectory().appendingPathComponent("\(filename).png")
        try? imageData?.write(to: filename)
    }
    
    public static func generateTempImage(width: Int, height: Int, completion: @escaping (UIImage?) -> ()) -> String {
        let tempName  = NSUUID().uuidString.replacingOccurrences(of: "-", with: "")
        let image: UIImage? = self.drawRectangle(with: width, height: height)
        saveTempImage(from: image, to: tempName)
        completion(image)
        return tempName
    }
    
    public static func getImageFromDocuments(by name: String) ->UIImage? {
        
        let imagePath = getImageNameFromDocuments(by: name)
        let image    = UIImage(contentsOfFile: imagePath)
        
        return image
    }
    
    public static func getImageNameFromDocuments(by name: String) -> String {
        
        let documentPath = getDocumentsDirectory()
        let imageURL = URL(fileURLWithPath: documentPath.path).appendingPathComponent("\(name).png")
        return imageURL.path
    }
    
    public static func copyImageFromTemp(by name: String) -> Void {
        
        let documentPath = getDocumentsDirectory()
        let tempPath = getTempDirectory()
        let imageDestinationURL = URL(fileURLWithPath: documentPath.path).appendingPathComponent("\(name).png")
        let imageOriginURL = URL(fileURLWithPath: tempPath.path).appendingPathComponent("\(name).png")
        let fileExist = FileManager.default.fileExists(atPath: imageOriginURL.path)
        if fileExist {
            DispatchQueue.global().async {
                try? FileManager.default.copyItem(at: imageOriginURL, to: imageDestinationURL)
                try? FileManager.default.removeItem(atPath: imageOriginURL.path)
            }

        }

    }
}

extension ImageService {
    private static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private static func getTempDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: .random(in: 0...1))
    }
}
