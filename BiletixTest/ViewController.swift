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

class ViewController: UIViewController, SessionDelegate {
    
    var sessionProcessor: SessionProcessor?
    var sessionToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sessionProcessor = SessionProcessor(delegate: self)
    }
    
    func sessionChanged(session: Session) {
        sessionToken = session.token ?? ""
        print("got token: " + sessionToken)
    }
}
