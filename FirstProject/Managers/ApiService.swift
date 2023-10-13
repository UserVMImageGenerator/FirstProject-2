//
//  ApiManager.swift
//  hh
//
//  Created by Софья Куликова on 02.10.2023.
//

import UIKit

struct ResponseAI: Decodable {
    let data: [ImageURL]
}

struct ImageURLAI: Decodable {
    let url: String
}

enum APIError: Error {
    case unableToCreateImageURL
    case unableToConvertDataIntoImage
    case unableToCreateURLForURLRequest
}

class APIServiceAI {
    
    let apiKey = "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"
    
    func fetchImageForPrompt(_ prompt: String, completion: @escaping (String?) -> Void) {
        let fetchImageURL = "https://api.openai.com/v1/images/generations"
        let urlRequest = createURLRequestFor(httpMethod: "POST", url: fetchImageURL, prompt: prompt)
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error)  in
            if let error = error {
                print(error)
            }
//            let decoder = JSONDecoder()
//            let results = try decoder.decode(Response.self, from: data!)
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(Response.self, from: data!)
                let url = results.data.first?.url
               completion(url!)
                
            } catch {
               
               // completion(.failure(error)) // тут error не опционален => можно использовать так как есть
            }
        }.resume()
    }

    
    private func createURLRequestFor(httpMethod: String, url: String, prompt: String) -> URLRequest {
        let url = URL(string: url)
        
        var urlRequest = URLRequest(url: url!)
        
        // Method
        urlRequest.httpMethod = httpMethod
        
        // Headers
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
        
        // Body
        let jsonBody: [String: Any] = [
            "prompt": "\(prompt)",
            "n": 1,
            "size": "1024x1024"
        ]
        
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: jsonBody)
        
        return urlRequest
    }
    
    func generateImageVariation(from image: UIImage, completion: @escaping (String?) -> Void) {
        guard let imageData = image.pngData() else{return}
        
        let formFields: [String: String] = [
            "size": "1024x1024"
        ]
        
        guard let url = URL(string: "https://api.openai.com/v1/images/variations") else {return}
        let multipart = MultipartFormDataRequest(url: url)
        multipart.addDataField(fieldName:  "image", fileName: "image.png", data: imageData, mimeType: "image/png")
        
        for (key, value) in formFields {
            multipart.addTextField(named: key, value: value)
        }

        var request = multipart.asURLRequest()
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, _, error)  in
            if let error = error {
                print(error)
            }
            
            let responseData = String(data: data!, encoding: .ascii)
            print(responseData as Any)
//            let decoder = JSONDecoder()
//            let results = try decoder.decode(Response.self, from: data!)
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(Response.self, from: data!)
                let url = results.data.first?.url
               completion(url!)
                
            } catch {
               print(error)
               // completion(.failure(error)) // тут error не опционален => можно использовать так как есть
            }
        }.resume()
        
    }
    
    func generateEditedImage(from image: UIImage, with mask: UIImage, completion: @escaping (String?) -> Void) {
        
        guard let imageData = image.pngData() else{return}
        guard let maskData = mask.pngData() else{return}
        
        let formFields: [String: String] = [
            "prompt": "The same face, but with anime style",
            "size": "1024x1024"
        ]
        
        guard let url = URL(string: "https://api.openai.com/v1/images/edits") else {return}
        let multipart = MultipartFormDataRequest(url: url)
        multipart.addDataField(fieldName:  "image", fileName: "image.png", data: imageData, mimeType: "image/png")
        multipart.addDataField(fieldName:  "mask", fileName: "mask.png", data: maskData, mimeType: "image/png")
        
        for (key, value) in formFields {
            multipart.addTextField(named: key, value: value)
        }

        var request = multipart.asURLRequest()
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, _, error)  in
            if let error = error {
                print(error)
            }
            
            let responseData = String(data: data!, encoding: .ascii)
            print(responseData)
//            let decoder = JSONDecoder()
//            let results = try decoder.decode(Response.self, from: data!)
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(Response.self, from: data!)
                let url = results.data.first?.url
               completion(url!)
                
            } catch {
               print(error)
               // completion(.failure(error)) // тут error не опционален => можно использовать так как есть
            }
        }.resume()
    }
    
    func downloadImage(for imageUrl: String, callback: @escaping (UIImage?)->()) {
        
        guard let url = URL(string: imageUrl) else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                callback(image)
            }
        }
        dataTask.resume()
    }
}
