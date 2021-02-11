import UIKit

extension UIImage {
    static var imageCache = NSCache<NSString, UIImage>()
    
    static func loadImageFromCache(imageIdentifier : String?) -> UIImage? {
        guard let id = imageIdentifier else {
            return nil
        }
        
        return self.imageCache.object(forKey: id as NSString)
    }
    
    static func saveImageOnCache(imageIdentifier : String?, image : UIImage) {
        guard let id = imageIdentifier else {
            return
        }
        
        self.imageCache.setObject(image, forKey: id as NSString)
    }
}
