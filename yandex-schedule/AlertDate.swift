//
//  AlertDate.swift
//  yandex-schedule
//
//  Created by Nikolai  on 09.12.2023.
//

import UIKit

extension UIViewController {
    
    func alerDate(completionHandler: @escaping (Date) -> Void) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.tintColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
        datePicker.preferredDatePickerStyle = .inline
        
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "ok", style: .default) { (action) in
            completionHandler(datePicker.date)
        }
        
        alert.addAction(ok)
        
        alert.view.heightAnchor.constraint(equalToConstant: 460).isActive = true
        
        NSLayoutConstraint.activate([
            datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor),
            datePicker.heightAnchor.constraint(equalTo: alert.view.widthAnchor),
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20)
        ])
        
        print("selected date2 = \(datePicker.date)")
        present(alert, animated: true)
    }
}

