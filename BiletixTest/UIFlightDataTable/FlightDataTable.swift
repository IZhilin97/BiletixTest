//
//  FlightDataTable.swift
//  BiletixTest
//
//  Created by Иван Жилин on 03.08.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import Foundation
import UIKit

class FlightDataTable: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    private var rowCount = 0
    private var data: [FlightCellData] = []
    
    init(data: [FlightCellData], frame: CGRect){
        super.init(frame: frame, style: .plain)
        delegate = self
        dataSource = self
        
        self.allowsSelection = false
        
        self.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateDate(data: [FlightCellData]){
        self.data = data
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return FlightCell(data: data[indexPath.row])
    }
}
