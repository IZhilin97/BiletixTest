//
//  FlightDataModel.swift
//  BiletixTest
//
//  Created by Иван Жилин on 01.08.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import Foundation

struct FlightData {

}

typealias FlightsData = [FlightData]

extension FlightsData: ApiDataModel{
    var apiType: String{
        get{
            return "FlightData"
        }
    }
}
