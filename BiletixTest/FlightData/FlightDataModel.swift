//
//  FlightDataModel.swift
//  BiletixTest
//
//  Created by Иван Жилин on 01.08.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import Foundation
import SWXMLHash

struct Flight: XMLIndexerDeserializable{
    var departureTime: String?
    var arrivalTime: String?
    var flightNumber: String?
    var duration: Int?
    var departureAirportCode: String?
    var arrivalAirportCode: String?
    
    static func deserialize(_ node: XMLIndexer) throws -> Flight {
        return try Flight(
            departureTime: node["segments"]["AirSegment"]["departure_date"].value(),
            arrivalTime: node["segments"]["AirSegment"]["arrival_date"].value(),
            flightNumber: node["segments"]["AirSegment"]["flight_number"].value(),
            duration: node["segments"]["AirSegment"]["duration"].value(),
            departureAirportCode: node["segments"]["AirSegment"]["departure_airport_code"].value(),
            arrivalAirportCode: node["segments"]["AirSegment"]["arrival_airport_code"].value()
        )
    }
}

struct Offer: XMLIndexerDeserializable {
    var company: String?
    var price: Int?
    var flights: [Flight]
    
    
    static func deserialize(_ node: XMLIndexer) throws -> Offer {
        return try Offer(
            company: node["ak"].value(),
            price: node["total_price"].value(),
            flights: node["directions"]["GetOptimalFaresDirection"]["flights"]["GetOptimalFaresFlight"].value()
        )
    }
}

struct Offers: XMLIndexerDeserializable, ApiDataModel{
    var offers: [Offer] = []
    
    static func deserialize(_ node: XMLIndexer) throws -> Offers {
        return try Offers(
            offers: node["GetOptimalFaresOffer"].value()
            //flights: node["segments"]["AirSegment"].value()
        )
    }
    
    var apiType: String {
        get{
            return "Offers"
        }
    }
}
