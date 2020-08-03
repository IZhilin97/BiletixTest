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
    
    private var sessionProcessor: SessionProcessor?
    private var flightsProcessor: FlightsDataProcessor?
    private var sessionToken: String = ""
    private var table: FlightDataTable?
    private let loader: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loader.startAnimating()
        loader.isHidden = false
        loader.color = .black
        
        self.view.addSubview(loader)
        loader.center = self.view.center
        
        sessionProcessor = SessionProcessor(delegate: self)
        table = FlightDataTable(data: [], frame: self.view.bounds)
        table?.isHidden = true
        self.view.addSubview(table!)
    }
    
    func dataChanged(data: ApiDataModel) {
        switch data.apiType {
        case "Session":
            sessionToken = (data as! Session).token ?? ""
            print("got token: " + sessionToken)
            flightsProcessor = FlightsDataProcessor(token: sessionToken, delegate: self)
            break
        case "Offers":
            table?.updateDate(data: (flightsProcessor?.getOffer().offers.filter({$0.company == "S7"}).map({FlightCellData(data: $0)}) ?? []))
            table?.isHidden = false
            loader.removeFromSuperview()
            break
        default:
            break
        }
    }
}
