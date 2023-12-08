//
//  ScheduleCell.swift
//  yandex-schedule
//
//  Created by Nikolai  on 07.12.2023.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    static var identifier: String {
        "ScheduleCell"
    }
    
    private let transportTypeImageView = UIImageView()
    
    private let durationLabel = UILabel()
    
    private let FromLabel = UILabel()
    private let ToLabel = UILabel()
    private let carrierNameLabel = UILabel()
    private let vehicleLabel = UILabel()
    private let threadNumber = UILabel()
    private var fromToStackView = UIStackView()
    
    private var departureDayLabel = UILabel()
    private var departureTimeLabel = UILabel()
    private let departureTitle = UILabel()
    private var departureStackView = UIStackView()
    
    private var arrivalDayLabel = UILabel()
    private var arrivalTimeLabel = UILabel()
    private let arrivalTitle = UILabel()
    private var arrivalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        transportTypeImageView.backgroundColor = .red
        transportTypeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        FromLabel.font = .systemFont(ofSize: 16)
        FromLabel.textColor = .black
        
        ToLabel.font = .systemFont(ofSize: 16)
        ToLabel.textColor = .black
        
        carrierNameLabel.font = .systemFont(ofSize: 14)
        carrierNameLabel.textColor = .darkGray
        
        threadNumber.font = .systemFont(ofSize: 14)
        threadNumber.textColor = .darkGray
        
        vehicleLabel.font = .systemFont(ofSize: 14)
        vehicleLabel.textColor = .darkGray
        
        fromToStackView = UIStackView(arrangedSubviews: [FromLabel, ToLabel, carrierNameLabel, threadNumber, vehicleLabel])
        fromToStackView.axis = .vertical
        fromToStackView.spacing = 2
        fromToStackView.backgroundColor = .blue
        fromToStackView.alpha = 0.5
        fromToStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(fromToStackView)
        addSubview(transportTypeImageView)
        
        departureDayLabel.font = .systemFont(ofSize: 14)
        departureDayLabel.textColor = .darkGray
        
        departureTimeLabel.font = .boldSystemFont(ofSize: 16)
        departureTimeLabel.textColor = .black
        
        departureTitle.font = .systemFont(ofSize: 14)
        departureTitle.textColor = .darkGray
        departureTitle.numberOfLines = 0
//        departureTitle.lineBreakMode = .byWordWrapping
        
        departureStackView = UIStackView(arrangedSubviews: [departureDayLabel, departureTimeLabel, departureTitle])
        departureStackView.axis = .vertical
        departureStackView.spacing = 2
        departureStackView.backgroundColor = .green
        departureStackView.alpha = 0.5
        departureStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(departureStackView)
        
        arrivalDayLabel.font = .systemFont(ofSize: 14)
        arrivalDayLabel.textColor = .darkGray
        
        arrivalTimeLabel.font = .boldSystemFont(ofSize: 16)
        arrivalTimeLabel.textColor = .black
        
        arrivalTitle.font = .systemFont(ofSize: 14)
        arrivalTitle.textColor = .darkGray
        arrivalTitle.numberOfLines = 0
        
        arrivalStackView = UIStackView(arrangedSubviews: [arrivalDayLabel, arrivalTimeLabel, arrivalTitle])
        arrivalStackView.axis = .vertical
        arrivalStackView.spacing = 2
        arrivalStackView.backgroundColor = .red
        arrivalStackView.alpha = 0.5
        arrivalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrivalStackView)
        
        durationLabel.font = .systemFont(ofSize: 16)
        durationLabel.textColor = .darkGray
        durationLabel.numberOfLines = 0
        durationLabel.backgroundColor = .yellow
        durationLabel.alpha = 0.5
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(durationLabel)
        
        
        NSLayoutConstraint.activate([
            fromToStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            fromToStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            
            transportTypeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            transportTypeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            transportTypeImageView.heightAnchor.constraint(equalToConstant: 20),
            transportTypeImageView.widthAnchor.constraint(equalToConstant: 20),
            
            departureStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            departureStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 130),
            departureStackView.widthAnchor.constraint(equalToConstant: 100),
            
            arrivalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrivalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            arrivalStackView.widthAnchor.constraint(equalToConstant: 100),
            
            durationLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            durationLabel.leadingAnchor.constraint(equalTo: departureStackView.trailingAnchor, constant: 20),
            durationLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupCell(viewModel: ScheduleCellViewModel) {
        FromLabel.text = viewModel.fromTitle + " —"
        ToLabel.text = viewModel.toTitle
        carrierNameLabel.text = viewModel.carrierName
        vehicleLabel.text = viewModel.vehicle
        
        departureDayLabel.text = viewModel.departureDateText
        departureTimeLabel.text = viewModel.departureTimeText
        departureTitle.text = viewModel.departureTitle
        
        arrivalDayLabel.text = viewModel.arrivalDateText
        arrivalTimeLabel.text = viewModel.arrivalTimeText
        arrivalTitle.text = viewModel.arrivalTitle
        
        durationLabel.text = viewModel.durationText
        
//        print("transport = \(viewModel.transportType)")
//        switch viewModel.transportType {
//        case plane: transportTypeImageView.backgroundColor = .brown
//        case train: transportTypeImageView.backgroundColor = .purple
//        }
        
        print("transport = \(viewModel.transportType)")
        switch viewModel.transportType {
        case "plane": transportTypeImageView.image = UIImage(systemName: "airplane")
        case "train": transportTypeImageView.image = UIImage(systemName: "train.side.front.car")
        case "suburban": transportTypeImageView.image = UIImage(systemName: "tram.fill")
        case "bus": transportTypeImageView.image = UIImage(systemName: "bus.fill")
        default:
            print("сработал дефолт")
        }
        
        threadNumber.text = viewModel.threadNumber
    }
    
    
}

