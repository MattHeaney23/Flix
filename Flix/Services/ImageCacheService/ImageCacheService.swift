//
//  ImageCacheService.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import UIKit

class ImageCacheService {
    //MARK: - Init
    private init() {}
    static let Shared = ImageCacheService()
    
    //MARK: - Properties
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    ///Load the image from cache. Returns nil if it doesn't exist in cache.
    func loadImageFromCacheIfAvailable(url: URL) -> UIImage? {
        let cacheKey = url.absoluteString as NSString
        
        if let imageFromCache = imageCache.object(forKey: cacheKey) as? UIImage {
            return imageFromCache
        } else {
            return nil
        }
    }
    
    ///Stores the image cache, using the url as the key
    func storeImageInCache(image: UIImage?, url: URL) {
        guard let image = image else { return }
        let cacheKey = url.absoluteString as NSString
        self.imageCache.setObject(image, forKey: cacheKey)
    }
}
