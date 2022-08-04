//
//  ImageManager.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/25/21.
//

import Foundation
import FirebaseStorage //holds images and videos

let imageCache = NSCache<AnyObject, UIImage>()

class ImageManager {
    
    // MARK: PROPERTIES
    
    static let instance = ImageManager()
    private var REF_STOR = Storage.storage()
    
    // MARK: PUBLIC FUNCTIONS
    // Functions we call from other places in the app
    func uploadProfileImage(userID: String, image: UIImage) {
        
        // Get the path where we will save the image
        let path = getProfileImagePath(userID: userID)
        
        
        // Save image to path
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { (_) in} //it's on main thread, now move to background thread
        }
        
    }
    
    func uploadPostImage(postID: String, image: UIImage, handler: @escaping (_ success: Bool) -> ()) {
        // Get the path where we will save the image
        let path = getPostImagePath(postID: postID)
        
        // Save image to path
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { (success) in
                DispatchQueue.main.async {
                    handler(success)
                }
            }
        }

        
        
    }
    
    func downloadProfileImage(userID: String, handler: @escaping (_ image: UIImage?) -> ()) {
        
        //Get the path where the image is saved
        let path = getProfileImagePath(userID: userID)
        
        // Download the image from path
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) { (returnedImage) in
                DispatchQueue.main.async {
                    handler(returnedImage)
                }
            }
        }
        
    }
    
    
    func downloadPostImage(postID: String, handler: @escaping (_ image: UIImage?) -> ()) {
        
        // Get the path where the image is saved
        let path = getPostImagePath(postID: postID)
        
        // Download the image from path
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) { (returnedImage) in
                DispatchQueue.main.async {
                    handler(returnedImage)
                }
            }
        }
        
    }
    
    // MARK: PRIVATE FUNCTIONS
    // Functions we call from this file only
    
    private func getProfileImagePath(userID: String) -> StorageReference {
        
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func getPostImagePath(postID: String) -> StorageReference {
        let postPath = "posts\(postID)/1"
        let storagePath = REF_STOR.reference(withPath: postPath)
        return storagePath
    }
    
    
    private func uploadImage(path: StorageReference, image: UIImage, handler: @escaping (_ success: Bool) -> ()) {
        var compression: CGFloat = 0.1 // compress the amount for data. loops down by 0.05
        let maxFileSize: Int = 240 * 240 // Maximum file ize that we want to save
        let maxCompression: CGFloat = 0.05 // Maximum compression we ever allow
        
        
        //get image data
        guard var originalData = image.jpegData(compressionQuality: compression) else { // compress the amount for data
            print("Error getting data from image")
            handler(false)
            return
        }
        //Check maximum file size
        while originalData.count > maxFileSize && compression > maxCompression{
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression) {
                originalData = compressedData
            }
            print(compression)
        }
        
        
        //get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else { // compress the amount for data
            print("Error getting data from image")
            handler(false)
            return
        }
        
        // Get photo metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        path.putData(finalData, metadata: metadata) { (_, error)  in
            if let error = error {
                print("Error uploading image. \(error)")
                handler(false)
                return
            } else {
                //Success
                print("Success uploading image")
                handler(true)
                return
            }
        }
    }
    
    private func downloadImage(path: StorageReference, handler: @escaping (_ image: UIImage?) -> ()) {
        // if already doanloaded, then dont need to download again
        if let cachedImage = imageCache.object(forKey: path) {
            print("Image found in cache")
            handler(cachedImage)
            return
        } else {
            //max size can be put into database 27*1024*1024
            path.getData(maxSize: 27 * 1024 * 1024) { (returnedImageData, error) in
                
                if let data = returnedImageData, let image = UIImage(data: data) {
                    // Success getting image data
                    imageCache.setObject(image, forKey: path) //won't download image twice
                    handler(image)
                    return
                } else {
                    print ("Error getting data from path for image")
                    handler(nil)
                    return
                }
            }
        }
    }
}
