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
        transportTypeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        FromLabel.font = .boldSystemFont(ofSize: 14)
        FromLabel.textAlignment = .left
        FromLabel.textColor = .black
        
        ToLabel.font = .boldSystemFont(ofSize: 14)
        ToLabel.textAlignment = .left
        ToLabel.textColor = .black
        
        carrierNameLabel.font = .systemFont(ofSize: 12)
        carrierNameLabel.textAlignment = .left
        carrierNameLabel.textColor = .darkGray
        
        threadNumber.font = .systemFont(ofSize: 12)
        threadNumber.textAlignment = .left
        threadNumber.textColor = .darkGray
        
        vehicleLabel.font = .systemFont(ofSize: 12)
        vehicleLabel.textAlignment = .left
        vehicleLabel.textColor = .darkGray
        
        fromToStackView = UIStackView(arrangedSubviews: [FromLabel, ToLabel, carrierNameLabel, threadNumber, vehicleLabel])
        fromToStackView.axis = .vertical
        fromToStackView.spacing = 2
//        fromToStackView.backgroundColor = .blue
//        fromToStackView.alpha = 0.5
        fromToStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(fromToStackView)
        addSubview(transportTypeImageView)
        
        departureDayLabel.font = .systemFont(ofSize: 12)
        departureDayLabel.textColor = .darkGray
        
        departureTimeLabel.font = .boldSystemFont(ofSize: 14)
        departureTimeLabel.textColor = .black
        
        departureTitle.font = .systemFont(ofSize: 12)
        departureTitle.textColor = .darkGray
        departureTitle.numberOfLines = 0
        
        departureStackView = UIStackView(arrangedSubviews: [departureDayLabel, departureTimeLabel, departureTitle])
        departureStackView.axis = .vertical
        departureStackView.spacing = 2
//        departureStackView.backgroundColor = .green
//        departureStackView.alpha = 0.5
        departureStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(departureStackView)
        
        arrivalDayLabel.font = .systemFont(ofSize: 12)
        arrivalDayLabel.textAlignment = .right
        arrivalDayLabel.textColor = .darkGray
        
        arrivalTimeLabel.font = .boldSystemFont(ofSize: 14)
        arrivalTimeLabel.textAlignment = .right
        arrivalTimeLabel.textColor = .black
        
        arrivalTitle.font = .systemFont(ofSize: 12)
        arrivalTitle.textAlignment = .right
        arrivalTitle.numberOfLines = 0
        arrivalTitle.textColor = .darkGray
        arrivalTitle.numberOfLines = 0
        
        arrivalStackView = UIStackView(arrangedSubviews: [arrivalDayLabel, arrivalTimeLabel, arrivalTitle])
        arrivalStackView.axis = .vertical
        arrivalStackView.spacing = 2
//        arrivalStackView.backgroundColor = .red
//        arrivalStackView.alpha = 0.5
        arrivalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrivalStackView)
        
        durationLabel.font = .systemFont(ofSize: 12)
        durationLabel.textColor = .darkGray
        durationLabel.numberOfLines = 0
//        durationLabel.backgroundColor = .yellow
//        durationLabel.alpha = 0.5
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(durationLabel)
        
        
        NSLayoutConstraint.activate([
            arrivalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            arrivalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            arrivalStackView.widthAnchor.constraint(equalToConstant: 90),
            
            durationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            durationLabel.trailingAnchor.constraint(equalTo: arrivalStackView.leadingAnchor, constant: -5),
            durationLabel.widthAnchor.constraint(equalToConstant: 24),
            
            departureStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            departureStackView.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: -5),
            departureStackView.widthAnchor.constraint(equalToConstant: 90),
            
            transportTypeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            transportTypeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            transportTypeImageView.heightAnchor.constraint(equalToConstant: 20),
            transportTypeImageView.widthAnchor.constraint(equalToConstant: 20),
            
            fromToStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            fromToStackView.leadingAnchor.constraint(equalTo: transportTypeImageView.trailingAnchor, constant: 5),
            fromToStackView.widthAnchor.constraint(equalToConstant: 140)
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
            transportTypeImageView.tintColor = .systemBlue
        case "train": transportTypeImageView.image = UIImage(systemName: "train.side.front.car")
            transportTypeImageView.tintColor = .red
        case "suburban": transportTypeImageView.image = UIImage(systemName: "tram.fill")
            transportTypeImageView.tintColor = .systemGreen
        case "bus": transportTypeImageView.image = UIImage(systemName: "bus.fill")
            transportTypeImageView.tintColor = .orange
        default:
            print("сработал дефолт")
        }
        
        threadNumber.text = viewModel.threadNumber
    }
    
    
}

