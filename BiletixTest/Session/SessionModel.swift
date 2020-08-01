//
//  SessionModel.swift
//  BiletixTest
//
//  Created by Иван Жилин on 31.07.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import Foundation
import SWXMLHash

struct Session: XMLIndexerDeserializable, ApiDataModel{
    var apiType: String{
        get{
            return "Session"
        }
    }
    
    var token: String?
    
    static func deserialize(_ node: XMLIndexer) throws -> Session {
        return try Session(
            token: node["session_token"].value()
        )
    }
}
