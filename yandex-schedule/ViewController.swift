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
    var FromlabelText = "Откуда"
    var TolabelText = "Куда"
    var transportType = ""
    let currentDate = Date()
    var tripDate = ""
    
    private var FindButton = UIButton()
    private var Fromlabel = UILabel()
    private var Tolabel = UILabel()
    private var transportSegmentedControll = UISegmentedControl()
    private var dateSegmentedControll = UISegmentedControl()
    private var reverseButton = UIButton()
    private var logoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createUI()
        tripDate = currentDate.ISO8601Format()
        createConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateLabels()
        isButtonVisible()
    }
    
    private func updateLabels() {
        Fromlabel.text = FromlabelText
        Tolabel.text = TolabelText
    }
    
    private func isButtonVisible() {
        if ((fromPointKey == "") || (toPointKey == "")) {
            FindButton.alpha = 0.5
            FindButton.isUserInteractionEnabled = false
        } else {
            FindButton.alpha = 1
            FindButton.isUserInteractionEnabled = true
        }
    }
    
    private func createUI(){
        navigationController?.navigationBar.prefersLargeTitles = true
        
        Fromlabel.text = FromlabelText
        Fromlabel.backgroundColor = .systemGray5
        Fromlabel.layer.cornerRadius = 5
        Fromlabel.clipsToBounds = true
        Fromlabel.textColor = .black
        Fromlabel.font = Fromlabel.font.withSize(20)
        Fromlabel.isUserInteractionEnabled = true
        Fromlabel.translatesAutoresizingMaskIntoConstraints = false
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FromlabelPressed))
        Fromlabel.addGestureRecognizer(guestureRecognizer)
        view.addSubview(Fromlabel)
        
        Tolabel.text = TolabelText
        Tolabel.backgroundColor = .systemGray5
        Tolabel.layer.cornerRadius = 5
        Tolabel.clipsToBounds = true
        Tolabel.textColor = .black
        Tolabel.font = Fromlabel.font.withSize(20)
        Tolabel.translatesAutoresizingMaskIntoConstraints = false
        Tolabel.isUserInteractionEnabled = true
        let guestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(TolabelPressed))
        Tolabel.addGestureRecognizer(guestureRecognizer2)
        view.addSubview(Tolabel)
        
        transportSegmentedControll = UISegmentedControl(items: ["любой", "2", "3", "4", "5"])
        transportSegmentedControll.selectedSegmentIndex = 0
        transportSegmentedControll.setImage(UIImage(systemName: "airplane"), forSegmentAt: 1)
        transportSegmentedControll.setImage(UIImage(systemName: "train.side.front.car"), forSegmentAt: 2)
        transportSegmentedControll.setImage(UIImage(systemName: "tram.fill"), forSegmentAt: 3)
        transportSegmentedControll.setImage(UIImage(systemName: "bus.fill"), forSegmentAt: 4)
        transportSegmentedControll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transportSegmentedControll)
        
        dateSegmentedControll = UISegmentedControl(items: ["Сегодня", "Завтра", "Дата"])
        dateSegmentedControll.selectedSegmentIndex = 0
        dateSegmentedControll.addTarget(self, action: #selector(dateSegmentedValueChange), for: .valueChanged)
        dateSegmentedControll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateSegmentedControll)
        
        FindButton.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
        FindButton.setTitle("Найти", for: .normal)
        FindButton.setTitleColor(.black, for: .normal)
        FindButton.layer.cornerRadius = 5
        FindButton.addTarget(self, action: #selector(FindButtonPressed), for: .touchUpInside)
        FindButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(FindButton)
        
        reverseButton.backgroundColor = .clear
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        reverseButton.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        reverseButton.tintColor = .black
        reverseButton.addTarget(self, action: #selector(reverseButtonPressed), for: .touchUpInside)
        view.addSubview(reverseButton)
        
        logoImageView.image = UIImage(named: "yandexLogo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
    }
    
//MARK: - Selectors
    @objc private func dateSegmentedValueChange() {
        switch dateSegmentedControll.selectedSegmentIndex {
        case 0:
            tripDate = currentDate.ISO8601Format()
        case 1:
            let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
            tripDate = tomorrowDate!.ISO8601Format()
        case 2:
            alerDate { date in
                self.tripDate = date.ISO8601Format()
            }
        default:
            print("default switch Date")
        }
    }
    
    @objc private func FromlabelPressed() {
        let FromVC = FromViewController()
        navigationController?.pushViewController(FromVC, animated: true)
    }
    
    @objc private func TolabelPressed() {
        let ToVC = ToViewController()
        navigationController?.pushViewController(ToVC, animated: true)
    }
    
    @objc private func reverseButtonPressed() {
        let fromStationKey = fromPointKey
        fromPointKey = toPointKey
        toPointKey = fromStationKey
        
        let fromStation = FromlabelText
        FromlabelText = TolabelText
        TolabelText = fromStation
        
        updateLabels()
    }
    
    @objc private func FindButtonPressed() {
        switch transportSegmentedControll.selectedSegmentIndex {
        case 0: transportType = ""
        case 1: transportType = "plane"
        case 2: transportType = "train"
        case 3: transportType = "suburban"
        case 4: transportType = "bus"
        default:
            print("default switch transport type")
        }
        
        let ScheduleVC = ScheduleViewController()
        ScheduleVC.fromTitle = FromlabelText
        ScheduleVC.toTitle = TolabelText
        ScheduleVC.fromPointKey = fromPointKey
        ScheduleVC.toPointKey = toPointKey
        ScheduleVC.transportTypeTitle = transportType
        ScheduleVC.tripDate = tripDate
        navigationController?.pushViewController(ScheduleVC, animated: true)
    }
}

//MARK: - Set constraints
extension ViewController {
    func createConstraints() {
        NSLayoutConstraint.activate([
            Fromlabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2.3),
            Fromlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            Fromlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            Fromlabel.heightAnchor.constraint(equalToConstant: 50),
            
            Tolabel.topAnchor.constraint(equalTo: Fromlabel.bottomAnchor, constant: 10),
            Tolabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            Tolabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            Tolabel.heightAnchor.constraint(equalToConstant: 50),
            
            dateSegmentedControll.topAnchor.constraint(equalTo: Tolabel.bottomAnchor, constant: 15),
            dateSegmentedControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            dateSegmentedControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            dateSegmentedControll.heightAnchor.constraint(equalToConstant: 50),
            
            transportSegmentedControll.topAnchor.constraint(equalTo: dateSegmentedControll.bottomAnchor, constant: 15),
            transportSegmentedControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            transportSegmentedControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            transportSegmentedControll.heightAnchor.constraint(equalToConstant: 50),
            
            FindButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            FindButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            FindButton.heightAnchor.constraint(equalToConstant: 50),
            FindButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            
            reverseButton.centerYAnchor.constraint(equalTo: Fromlabel.bottomAnchor, constant: 5),
            reverseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            reverseButton.heightAnchor.constraint(equalToConstant: 40),
            reverseButton.widthAnchor.constraint(equalToConstant: 40),
            
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
