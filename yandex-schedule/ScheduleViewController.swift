//
//  ScheduleViewController.swift
//  yandex-schedule
//
//  Created by Nikolai  on 07.12.2023.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    var fromPointKey = ""
    var toPointKey = ""
    var fromTitle = "Откуда"
    var toTitle = "Куда"
    var transportTypeTitle = ""
    var tripDate = "2023-12-08T01:00:00+03:00"
    
    private var localSchedule = [Segment]()
    private var activityIndicator = UIActivityIndicatorView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Расписание"
        
        view.addSubview(tableView)
        setConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        let url = createURL(fromPointKey, toPointKey, transportTypeTitle, tripDate)
        let urlStr = url.absoluteString
        fetchSchedule(urlStr)
        createActivityIndicator()
    }
    
    private func createURL(_ fromPointKey: String, _ toPointKey: String, _ transport: String, _ date: String) -> URL {
        var urlComponents = URLComponents(string: "https://api.rasp.yandex.net/v3.0/search/")!
        
        let apiKey = URLQueryItem(name: "apikey", value: NetworkConstants.ApiKey.rawValue)
        let from = URLQueryItem(name: "from", value: fromPointKey)
        let to = URLQueryItem(name: "to", value: toPointKey)
        let transportTypes = URLQueryItem(name: "transport_types", value: transport)
        let dateValue = URLQueryItem(name: "date", value: date)
//        let limit = URLQueryItem(name: "limit", value: "50")
        
        urlComponents.queryItems = [apiKey, from, to, transportTypes, dateValue]
        return urlComponents.url!
    }
    
    private func fetchSchedule(_ urlString: String) {
        NetworkDataFetch.shared.fetchScheduleBetweenStations(urlString: urlString) { schedule, error in
            if error == nil {
                guard let schedule = schedule else { return }
                if schedule.segments != nil {
                    self.localSchedule = schedule.segments!
                    
                    if self.localSchedule.count <= 0 {
                        self.showErrorAlert()
                    }
                    
                    self.tableView.reloadData()
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                } else {
                    print("schedule not found.")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    private func createActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.style = .large
        activityIndicator.color = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
        view.addSubview(activityIndicator)
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Ошиюка", message: "Веберите другой тип транспорта или пункт назначения", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}


//MARK: - UITableViewDataSource

extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        localSchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.identifier, for: indexPath) as? ScheduleCell else {
            return UITableViewCell()
        }
        let scheduleCellViewModel = ScheduleCellViewModel(fromTitle: fromTitle, toTitle: toTitle, localSchedule[indexPath.row])
        cell.setupCell(viewModel: scheduleCellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

//MARK: - SetConstraints

extension ScheduleViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
