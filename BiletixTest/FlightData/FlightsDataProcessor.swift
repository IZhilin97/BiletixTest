//
//  FlightDataProcessor.swift
//  BiletixTest
//
//  Created by Иван Жилин on 01.08.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class FlightsDataProcessor {
    private var flights: FlightsData?

    var delegate: DataReceiver
    
    init(delegate: DataReceiver){
        self.delegate = delegate
        initiateRequest()
    }

    func getSession() -> FlightsData{
        return flights ?? []
    }

    func initiateRequest(){
        let stringParams : String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
        "<v:Envelope xmlns:v=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:c=\"http://www.w3.org/2003/05/soap-encoding\" xmlns:d=\"http://www.w3.org/2001/XMLSchema\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\">" +
        "<v:Header />" +
        "<v:Body>" +
            "<GetOptimalFaresInput xmlns=\"http://www.tais.ru/\" id=\"o0\" c:root=\"1\">" +
               "<session_token i:type=\"d:string\">9u0jkggdb51aqtsci6h575ibn5</session_token>" +
               "<owrt i:type=\"d:string\">OW</owrt>" +
               "<departure_point i:type=\"d:string\">MOW</departure_point>" +
               "<arrival_point i:type=\"d:string\">LED</arrival_point>" +
               "<outbound_date i:type=\"d:string\">25.08.2020</outbound_date>" +
               "<return_date i:type=\"d:string\" />" +
               "<adult_count i:type=\"d:int\">1</adult_count>" +
               "<child_count i:type=\"d:int\">0</child_count>" +
               "<infant_count i:type=\"d:int\">0</infant_count>" +
               "<class i:type=\"d:string\">E</class>" +
               "<hash i:type=\"d:string\"></hash>" +
            "</GetOptimalFaresInput>" +
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

                //self.session = try! xml["Envelope"]["Body"]["StartSessionOutput"].value()
                self.delegate.sessionChanged(data: (self.flights ?? []) as ApiDataModel)
        }
    }
}
