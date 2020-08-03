//
//  SessionProcessor.swift
//  BiletixTest
//
//  Created by Иван Жилин on 31.07.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import Foundation
import SWXMLHash
import Alamofire

class SessionProcessor {
    private var session: Session?
    private let login: String = "[partner]||SOAPTEST"
    private let password: String = "[partner]||SOAPTEST"
    
    var delegate: DataReceiver
    
    init(delegate: DataReceiver){
        self.delegate = delegate
        initiateRequest()
    }
    
    func getSession() -> Session{
        return session ?? Session()
    }
    
    func initiateRequest(){
        let stringParams : String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
        "<v:Envelope xmlns:v=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:c=\"http://www.w3.org/2003/05/soap-encoding\" xmlns:d=\"http://www.w3.org/2001/XMLSchema\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\">" +
        "<v:Header />" +
        "<v:Body>" +
            "<StartSessionInput xmlns=\"http://www.tais.ru/\" id=\"o0\" c:root=\"1\">" +
            "<login i:type=\"d:string\">\(login)</login>" +
                "<password i:type=\"d:string\">\(password)</password>" +
                "<disable_hash i:type=\"d:string\">Y</disable_hash>" +
                "<hash i:type=\"d:string\"></hash>" +
            "</StartSessionInput>" +
        "</v:Body>" +
        "</v:Envelope>"
        
        let url = URL(string: API_URL)
        var xmlRequest = URLRequest(url: url!)
        xmlRequest.httpBody = stringParams.data(using: String.Encoding.utf8, allowLossyConversion: true)
        xmlRequest.httpMethod = "POST"
        xmlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        
        Alamofire.request(xmlRequest)
            .responseData { (response) in
                let stringResponse: String = (String(data: response.data!, encoding: String.Encoding.utf8)) ?? ""
                debugPrint(stringResponse)
                
                let xml = SWXMLHash.config { config in
                    config.shouldProcessNamespaces = true
                }.parse(response.data!)
                
                self.session = try! xml["Envelope"]["Body"]["StartSessionOutput"].value()
                self.delegate.dataChanged(data: (self.session ?? Session()) as ApiDataModel)
        }
    }
}
 
