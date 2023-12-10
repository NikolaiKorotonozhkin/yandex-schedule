//
//  FromViewController.swift
//  yandex-schedule
//
//  Created by Nikolai  on 06.12.2023.
//

import UIKit

class FromViewController: UIViewController {
    
    var buttonTest = UIButton()
    var station = [Item]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstraints()
        setNavigationBar()
        setupSearchController()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Откуда"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Откуда"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func fetchStation(StationName: String) {
        
        let urlString = "https://suggests.rasp.yandex.net/all_suggests?format=new&part=\(StationName)"
        
        NetworkDataFetch.shared.fetchStations(urlString: urlString) { station, error in
            if error == nil {
                guard let station = station else { return }
                
                if station.items != [] {
                    self.station = station.items
                    self.tableView.reloadData()
                } else {
//                    self.alertOk(title: "Error", message: "Stations not found. Add some words")
                    print("Station not found. Add some words")
                }
                
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }
}


//MARK: - UITableViewDataSource

extension FromViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        station.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = station[indexPath.row].fullTitle
        return cell
    }
}

//MARK: - UITableViewDelegate

extension FromViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainVC = self.navigationController?.viewControllers[0] as? ViewController
        mainVC?.FromlabelText = station[indexPath.row].title
        mainVC?.fromPointKey = station[indexPath.row].pointKey
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - UISearchBarDelegate

extension FromViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print(text!)
        self.fetchStation(StationName: text!)
    }
}

//MARK: - SetConstraints

extension FromViewController {

    private func setConstraints() {

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
