//
//  MultipartFormDataRequest.swift
//  FirstProject
//
//  Created by Софья Куликова on 03.10.2023.
//



import Foundation

struct MultipartFormDataRequest {
    
    private let boundaryString: String = "Boundary-\(UUID().uuidString)"
    var httpBody = NSMutableData()
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }
    
    private func textFormField(named name: String, value: String) -> Data {
        var fieldString = Data("--\(boundaryString)\r\n".utf8)
        fieldString += Data("Content-Disposition: form-data; name=\"\(name)\"\r\n".utf8)
        fieldString += Data("Content-Type: text/plain; charset=ISO-8859-1\r\n".utf8)
        fieldString += Data("\r\n".utf8)
        fieldString += Data("\(value)\r\n".utf8)
        
        return fieldString
    }
    
    
    func addDataField(fieldName: String, fileName: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(fieldName: fieldName,fileName:fileName,data: data, mimeType: mimeType))
    }
    
    private func dataFormField(fieldName: String,
                               fileName: String,
                               data: Data,
                               mimeType: String) -> Data {
        
        var fieldData = Data("--\(boundaryString)\r\n".utf8)
        
        fieldData += Data("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n".utf8)
        fieldData += Data("Content-Type: \(mimeType)\r\n".utf8)
        fieldData += Data("\r\n".utf8)
        fieldData += data
        fieldData += Data("\r\n".utf8)
        return fieldData
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundaryString)", forHTTPHeaderField: "Content-Type")
        
        httpBody.append(Data("--\(boundaryString)--".utf8))
        request.httpBody = httpBody as Data
        return request
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
