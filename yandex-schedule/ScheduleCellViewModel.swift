//
//  ScheduleCellViewModel.swift
//  yandex-schedule
//
//  Created by Nikolai  on 07.12.2023.
//

import Foundation

class ScheduleCellViewModel {
    var fromTitle: String
    var toTitle: String
    var carrierName: String
    var vehicle: String
    var departureTitle: String
    var arrivalTitle: String
    var departureTimeText: String
    var arrivalTimeText: String
    var durationText: String
    var departureDateText: String
    var arrivalDateText: String
//    var transportType: String
    
    init(fromTitle: String, toTitle: String, _ schedule: Segment) {
        self.fromTitle = fromTitle
        self.toTitle = toTitle
        self.carrierName = (schedule.thread?.carrier?.title)!
        self.vehicle = (schedule.thread?.vehicle) ?? "нет"
        self.departureTitle = schedule.from?.title ?? "нет данных"
        self.arrivalTitle = schedule.to?.title ?? "нет данных"
        
        var time = schedule.arrival ?? ""
        var from = time.index(time.startIndex, offsetBy: 11)
        var to = time.index(time.endIndex, offsetBy: -10)
        time = String(time[from...to])
        arrivalTimeText = time
        
        time = schedule.departure ?? ""
        from = time.index(time.startIndex, offsetBy: 11)
        to = time.index(time.endIndex, offsetBy: -10)
        time = String(time[from...to])
        departureTimeText = time
        
        let durationTimeInMinutes = (Int(schedule.duration! / 60))
        let durationHours = durationTimeInMinutes / 60
        let durationMinutes = durationTimeInMinutes % 60
        durationText = "\(durationHours)" + " ч " + "\(durationMinutes)" + " мин"
        
        let dateFormatter = ISO8601DateFormatter()
        
        let dateFormatterRu = DateFormatter()
        dateFormatterRu.locale = Locale(identifier: "ru_RU")
        dateFormatterRu.dateFormat = "dd MMMM"
        
        let dateDepatrute = dateFormatter.date(from: schedule.departure!)
        departureDateText = dateFormatterRu.string(from: dateDepatrute!)
        
        let dateArrival = dateFormatter.date(from: schedule.arrival!)
        arrivalDateText = dateFormatterRu.string(from: dateArrival!)
        
//        transportType = (schedule.from?.transportType!.rawValue)!
    }
    
}
