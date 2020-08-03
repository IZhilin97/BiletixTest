//
//  ViewController.swift
//  BiletixTest
//
//  Created by Иван Жилин on 29.07.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
//MARK: - TEST
class ViewController:UIViewController, DataReceiver {
    
    var sessionProcessor: SessionProcessor?
    var flightsProcessor: FlightsDataProcessor?
    var sessionToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sessionProcessor = SessionProcessor(delegate: self)
    }
    
    func dataChanged(data: ApiDataModel) {
        switch data.apiType {
        case "Session":
            sessionToken = (data as! Session).token ?? ""
            print("got token: " + sessionToken)
            flightsProcessor = FlightsDataProcessor(token: sessionToken, delegate: self)
            break
        case "Offers":
            
            break
        default:
            break
        }
    }
}
