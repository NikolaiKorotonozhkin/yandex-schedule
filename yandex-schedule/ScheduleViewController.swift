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
    
    var localSchedule = [Segment]()
    
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
        
        let url = createURL(fromPointKey, toPointKey, transportTypeTitle, tripDate)
        let urlStr = url.absoluteString
        print(urlStr)
        fetchSchedule(urlStr)
        
    }
    
    func createURL(_ fromPointKey: String, _ toPointKey: String, _ transport: String, _ date: String) -> URL {
        var urlComponents = URLComponents(string: "https://api.rasp.yandex.net/v3.0/search/")!
        
        let apiKey = URLQueryItem(name: "apikey", value: NetworkConstants.ApiKey.rawValue)
//        let form = URLQueryItem(name: "format", value: "json")
        let from = URLQueryItem(name: "from", value: fromPointKey)
        let to = URLQueryItem(name: "to", value: toPointKey)
        let transportTypes = URLQueryItem(name: "transport_types", value: transport)
        let dateValue = URLQueryItem(name: "date", value: date)
        let limit = URLQueryItem(name: "limit", value: "50")
        
        urlComponents.queryItems = [apiKey, from, to, transportTypes, dateValue, limit]
        
        return urlComponents.url!
    }
    
    private func fetchSchedule(_ urlString: String) {
//        let urlString = "https://api.rasp.yandex.net/v3.0/search/?apikey=bca89ae3-7648-4682-a0dd-e8dfc5d8cef8&format=json&from=c213&to=c2&lang=ru_RU&date=2023-12-07&limit=8"
        
        NetworkDataFetch.shared.fetchScheduleBetweenStations(urlString: urlString) { schedule, error in
            if error == nil {
                guard let schedule = schedule else { return }
                
//                if schedule.segments != [] {
//                    self.localSchedule = schedule.segments
//                    print(self.localSchedule)
//                    self.tableView.reloadData()
//                } else {
//                    print("schedule not found.")
//                }
                
                if schedule.segments != nil {
                    self.localSchedule = schedule.segments!
                    print(self.localSchedule)
                    self.tableView.reloadData()
                } else {
                    print("schedule not found.")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
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
//        cell.textLabel?.text = localSchedule[indexPath.row].from?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

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
