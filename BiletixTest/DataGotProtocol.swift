//
//  DataGotProtocol.swift
//  BiletixTest
//
//  Created by Иван Жилин on 01.08.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import Foundation
protocol ApiDataModel {
    var apiType: String { get }
}

protocol DataReceiver {
    func sessionChanged(data: ApiDataModel)
}
