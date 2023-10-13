import Foundation
import UIKit
import Vision

class VisionRequester: ObservableObject{
    
  //  @Published var maskedImage: UIImage?
    //1 - @Published
    var faceRect: VNFaceObservation?
    
    func maskFaceUsingVisionRequest(inputImage: UIImage, completion: (UIImage?) -> Void){
        
        let request = VNDetectFaceRectanglesRequest{ (req, err) in
            if let err = err {
                print("Error in Pic", err)
                return
            }
            req.results?.forEach({ (res) in
            guard let faceObservation = res as? VNFaceObservation else {return}
            print(faceObservation.boundingBox)
            })
        }
        
        let handler = VNImageRequestHandler(cgImage: inputImage.cgImage!, options: [:])
   
            do{
                try handler.perform([request])
                
                guard let results = request.results else {return}
                faceRect = results.first //2
                guard let faceRect else {return}
                
                let box = getBoundingBoxes(rect: faceRect, on: inputImage.size)
                                
//                await MainActor.run{
//                    self.maskedImage = erase(region: box, from: inputImage)
//                }
                let image = erase(region: box, from: inputImage)
                completion(image)
                
            } catch {
                print(error)
            }
        
    }
    
    func getBoundingBoxes(rect : VNFaceObservation, on imageSize: CGSize) -> CGRect {
            
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -imageSize.height)
        let scale = CGAffineTransform.identity.scaledBy(x: imageSize.width, y: imageSize.height)

        let bounds = rect.boundingBox.applying(scale).applying(transform)
        
        return bounds
            
    }
    
    func erase(region: CGRect, from image: UIImage) -> UIImage? {
            UIGraphicsBeginImageContext(image.size)
            image.draw(at: CGPoint.zero)
            let context = UIGraphicsGetCurrentContext()!
            let bez = UIBezierPath(rect: region)
            context.addPath(bez.cgPath)
            context.clip()
            context.clear(CGRect(x:0,y:0,width: image.size.width,height: image.size.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
    }
    
    func detectFace(inputImage: UIImage, completion: @escaping (UIImage?) -> Void) {
        let faceRectanglesRequest = VNDetectFaceRectanglesRequest { (request, error) in
                    
                    // Handle the result back in the main thread.
                    DispatchQueue.main.async {
                        if error != nil {
                            completion(nil)
                        }
                        
                        // Iterate over the results array of detected faces.
                        guard let results = request.results else {return}
                        let faceRect = results.first as! VNFaceObservation
                      //  guard let faceRect else {return}
                        
                        let box = self.getBoundingBoxes(rect: faceRect, on: inputImage.size)
                                        
        //                await MainActor.run{
        //                    self.maskedImage = erase(region: box, from: inputImage)
        //                }
                        let image = self.erase(region: box, from: inputImage)
                        completion(image)
                    }
                }
        
#if targetEnvironment(simulator)
        faceRectanglesRequest.usesCPUOnly = true
#endif
        
        // Create a request handler for the image that you want to check for faces.
             guard let cgImage = inputImage.cgImage else { return }
             let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
             
             // Perform the face detection in an asynchronous thread.
             // The image will be displayed immediately and the detection results when they're finished.
             DispatchQueue.global(qos: .background).async {
                 do {
                     // Let the handler perform your request you've created above.
                     try imageRequestHandler.perform([faceRectanglesRequest])
                 } catch let error {
                     print("Request Handler Performance failed: ", error)
                 }
             }
         }
}



