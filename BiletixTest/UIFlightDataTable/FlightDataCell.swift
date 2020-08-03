//
//  FlightDataCell.swift
//  BiletixTest
//
//  Created by Иван Жилин on 03.08.2020.
//  Copyright © 2020 Иван Жилин. All rights reserved.
//

import Foundation
import UIKit

struct FlightCellData{
    let flightNumber: [String]
    let price: String
    let arrivalDate: String
    let departureDate: String
    let duration: String
    let departureAirportCode: String
    let arrivalAirportCode: String
    
    init(data: Offer) {
        flightNumber = data.flights.compactMap({$0.flightNumber})
        price = "\(data.price ?? 0)"
        arrivalDate = data.flights[0].arrivalTime ?? "(нет данных)"
        departureDate = data.flights[data.flights.count - 1].departureTime ?? "(нет данных)"
        duration = "\((Double(data.flights[0].duration ?? 0) / 3600.0).rounded(to: 1)) часа(ов)"
        departureAirportCode = data.flights[0].departureAirportCode ?? "(нет данных)"
        arrivalAirportCode = data.flights[0].arrivalAirportCode ?? "(нет данных)"
    }
}

class FlightCell: UITableViewCell{
    let priceLabel: CellLabel = CellLabel()
    let flightNumberLabel: CellLabel = CellLabel()
    let arrivalLabel: CellLabel = CellLabel()
    let departureLabel: CellLabel = CellLabel()
    let durationLabel:CellLabel = CellLabel()
    let departureAirportLabel: CellLabel = CellLabel()
    let arrivalAirportLabel: CellLabel = CellLabel()
    
    init(data: FlightCellData){
        super.init(style: .default, reuseIdentifier: "FlightCell")
        
        var flightStr: String = ""
        for flightNum in data.flightNumber{
            flightStr += "\(flightNum), "
        }
        
        flightNumberLabel.text = ((flightStr.count == 1) ? "Номер рейса: \(flightStr)" : "Номера рейсов: \(flightStr)")
        addSubview(flightNumberLabel)
        flightNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        flightNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        
        priceLabel.text = "Цена: \(data.price) ₽"
        addSubview(priceLabel)
        priceLabel.leadingAnchor.constraint(equalTo: flightNumberLabel.leadingAnchor, constant: 0).isActive = true
        priceLabel.topAnchor.constraint(equalTo: flightNumberLabel.bottomAnchor, constant: 5).isActive = true
        
        arrivalLabel.text = "Дата прибытия: \(data.arrivalDate)"
        addSubview(arrivalLabel)
        arrivalLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 0).isActive = true
        arrivalLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        arrivalLabel.font = arrivalLabel.font.withSize(12)
        
        departureLabel.text = "Дата вылета: \(data.arrivalDate)"
        addSubview(departureLabel)
        departureLabel.topAnchor.constraint(equalTo: arrivalLabel.topAnchor, constant: 0).isActive = true
        departureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        departureLabel.font = departureLabel.font.withSize(12)
        
        durationLabel.text = "Длительность перелёта: \(data.duration)"
        addSubview(durationLabel)
        durationLabel.topAnchor.constraint(equalTo: arrivalLabel.bottomAnchor, constant: 5).isActive = true
        durationLabel.leadingAnchor.constraint(equalTo: arrivalLabel.leadingAnchor, constant: 0).isActive = true
        
        departureAirportLabel.text = "Аэропорт вылета: \(data.departureAirportCode)"
        addSubview(departureAirportLabel)
        departureAirportLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: 0).isActive = true
        departureAirportLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 5).isActive = true
        departureAirportLabel.font = departureAirportLabel.font.withSize(12)
        
        arrivalAirportLabel.text = "Аэропорт прилёта: \(data.arrivalAirportCode)"
        addSubview(arrivalAirportLabel)
        arrivalAirportLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        arrivalAirportLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 5).isActive = true
        arrivalAirportLabel.font = departureAirportLabel.font.withSize(12)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CellLabel: UILabel{
    init() {
        super.init(frame: CGRect())
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Double {
    func rounded(to places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
