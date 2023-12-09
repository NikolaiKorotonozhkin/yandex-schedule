//
//  ViewController.swift
//  yandex-schedule
//
//  Created by Nikolai  on 06.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var fromPointKey = ""
    var toPointKey = ""
    var FromlabelText = "From"
    var TolabelText = "To"
    var transportType = ""
    var tripDate = ""
    let currentDate = Date()
    
    private var FindButton = UIButton()
    private var Fromlabel = UILabel()
    private var Tolabel = UILabel()
    private var transportSegmentedControll = UISegmentedControl()
    private var dateSegmentedControll = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createUI()
        createButton()
        createSegmented()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("from = \(FromlabelText)")
        print("from KEY = \(fromPointKey)")
        print("to = \(TolabelText)")
        print("to KEY = \(toPointKey)")
        print("trip date = \(tripDate)")
        createUI()
        
    }
    
    func createSegmented() {
        transportSegmentedControll = UISegmentedControl(items: ["любой", "2", "3", "4", "5"])
        transportSegmentedControll.frame = CGRect(x: 50, y: 600, width: 300, height: 40)
        transportSegmentedControll.selectedSegmentIndex = 0
        transportSegmentedControll.setImage(UIImage(systemName: "airplane"), forSegmentAt: 1)
        transportSegmentedControll.setImage(UIImage(systemName: "train.side.front.car"), forSegmentAt: 2)
        transportSegmentedControll.setImage(UIImage(systemName: "tram.fill"), forSegmentAt: 3)
        transportSegmentedControll.setImage(UIImage(systemName: "bus.fill"), forSegmentAt: 4)
        view.addSubview(transportSegmentedControll)
        
        dateSegmentedControll = UISegmentedControl(items: ["Сегодня", "Завтра", "Дата"])
        dateSegmentedControll.frame = CGRect(x: 50, y: 540, width: 300, height: 40)
        dateSegmentedControll.selectedSegmentIndex = 0
        dateSegmentedControll.addTarget(self, action: #selector(dateSegmentedValueChange), for: .valueChanged)
        view.addSubview(dateSegmentedControll)
    }
    
    @objc func dateSegmentedValueChange() {
        switch dateSegmentedControll.selectedSegmentIndex {
        case 0: print("дата = сегодня")
            tripDate = currentDate.ISO8601Format()
            print("switch сегодна = \(tripDate)")
        case 1: print("дата = завтра")
            let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
            tripDate = tomorrowDate!.ISO8601Format()
            print("switch завтра = \(tripDate)")
        case 2: print("дата = дата")
            print("case 2")
            alerDate { date in
                print("результат дата = \(date)")
                self.tripDate = date.ISO8601Format()
                print("кастомная дата = \(self.tripDate)")
//                self.dateSegmentedControll.setTitle("55", forSegmentAt: 2)
            }
           print("case 2-2")
        default:
            print("дата = дефолт")
        }
    }
    
    func createUI(){
        Fromlabel.text = FromlabelText
        Fromlabel.backgroundColor = .lightGray
        Fromlabel.textColor = .green
        Fromlabel.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        Fromlabel.center = view.center
        Fromlabel.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FromlabelPressed))
        Fromlabel.addGestureRecognizer(guestureRecognizer)
        view.addSubview(Fromlabel)
        
        Tolabel.text = TolabelText
        Tolabel.backgroundColor = .lightGray
        Tolabel.textColor = .green
        Tolabel.frame = CGRect(x: 0, y: 450, width: 300, height: 40)
        Tolabel.center.x = view.center.x
        Tolabel.isUserInteractionEnabled = true
        let guestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(TolabelPressed))
        Tolabel.addGestureRecognizer(guestureRecognizer2)
        view.addSubview(Tolabel)
    }
    
    func createButton() {
        FindButton.frame = CGRect(x: 0, y: 700, width: 300, height: 40)
        FindButton.center.x = view.center.x
        FindButton.backgroundColor = .yellow
        FindButton.setTitle("Найти", for: .normal)
        FindButton.setTitleColor(.black, for: .normal)
        FindButton.addTarget(self, action: #selector(FindButtonPressed), for: .touchUpInside)
        view.addSubview(FindButton)
    }
    
    @objc func FindButtonPressed() {
        
        switch transportSegmentedControll.selectedSegmentIndex {
        case 0: transportType = ""
        case 1: transportType = "plane"
        case 2: transportType = "train"
        case 3: transportType = "suburban"
        case 4: transportType = "bus"
        default:
            print("ff")
        }
        
        print("transportType = \(transportType)")
        print("final date = \(tripDate)")
        
        let ScheduleVC = ScheduleViewController()
        ScheduleVC.fromTitle = FromlabelText
        ScheduleVC.toTitle = TolabelText
        ScheduleVC.fromPointKey = fromPointKey
        ScheduleVC.toPointKey = toPointKey
        ScheduleVC.transportTypeTitle = transportType
        ScheduleVC.tripDate = tripDate
        navigationController?.pushViewController(ScheduleVC, animated: true)
    }
    
    
    @objc func FromlabelPressed() {
        let FromVC = FromViewController()
//        present(secondVC, animated: true)
        navigationController?.pushViewController(FromVC, animated: true)
    }
    
    @objc func TolabelPressed() {
        let ToVC = ToViewController()
//        present(secondVC, animated: true)
        navigationController?.pushViewController(ToVC, animated: true)
    }
}

