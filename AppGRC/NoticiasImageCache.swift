//
//  NoticiasImageCache.swift
//  AppGRC
//
//  Created by Crisoper on 18/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import Foundation
import UIKit

class NoticiasImageCache {
    
    static let sharedCache: NSCache = {
        let cache = NSCache()
        cache.name = "NoticiasImageCache"
        cache.countLimit = 20 // Máximo numero de images en caché.
        cache.totalCostLimit = 10*1024*1024 // Máximos 10Mb usados.
        return cache
    }()
}

extension NSURL {
    
    typealias ImageCacheCompletion = UIImage -> Void
    
    //Recuperamos imagen de caché o nil si no lo esta
    var cachedImage: UIImage? {
        return NoticiasImageCache.sharedCache.objectForKey(absoluteString) as? UIImage
    }
    
    //Cargamos imagenes desde la Red
    /// Stores it in the cache if successful.
    /// Only calls completion on successful image download.
    /// Completion is called on the main thread.
    func fetchImage(completion: ImageCacheCompletion) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(self) {
            data, response, error in
            if error == nil {
                if let  data = data,
                    image = UIImage(data: data) {
                    NoticiasImageCache.sharedCache.setObject(
                        image,
                        forKey: self.absoluteString,
                        cost: data.length)
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(image)
                    }
                }
            }
        }
        task.resume()
    }
    
}
