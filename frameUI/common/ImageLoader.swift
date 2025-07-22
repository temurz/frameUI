//
//  ImageLoader.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

public var imageCache = NSCache<NSString, UIImage>()
import PDFKit
import Foundation
import UIKit
class ImageLoader {
    func downloadImage(url: URL, completion: ((UIImage?) -> Void)? = nil) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion?(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil, data != nil else {
                    DispatchQueue.main.async {
                        completion?(nil)
                    }
                    return
                }
                func getUIImage(from page: PDFPage) -> UIImage {
                    let rect = page.bounds(for: PDFDisplayBox.mediaBox)
                    let renderer = UIGraphicsImageRenderer(size: rect.size)
                    let image = renderer.image(actions: { context in
                        let cgContext = context.cgContext
                        UIColor.clear.set()
                        cgContext.fill(rect)
                        cgContext.translateBy(x: 0, y: rect.size.height)
                        cgContext.scaleBy(x: 1, y: -1)
                        page.draw(with: PDFDisplayBox.mediaBox, to: cgContext)
                    })
                    return image
                }
                guard let image = UIImage(data: data!) else {
                    if let doc = PDFDocument(data: data!),
                       let thePage = doc.page(at: 0) {
                        DispatchQueue.main.async {
                            let img = getUIImage(from: thePage)
                            imageCache.setObject(img, forKey: url.absoluteString as NSString)
                            completion?(img)
                        }
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion?(image)
                }
            }
            dataTask.resume()
        }
    }
}
