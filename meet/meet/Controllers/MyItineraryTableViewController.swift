//
//  MyItineraryTableViewController.swift
//  meet
//
//  Created by Vlad Daneliuc on 26/03/2018.
//  Copyright © 2018 AgileFreaks. All rights reserved.
//

import Alamofire
import UIKit
import Vox

private let refreshControls = UIRefreshControl()

struct Contacts {
    let name: String
    let image: String
}

struct Itinerarys {
    let startDate: String
    let endDate: String
    let city: String
    let country: String
    let contacts: [Contacts]
}

class MyItineraryTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "itineraryView"

        setupRefreshTable()
        getItinerary()
    }

    var itis = [
        Itinerarys(startDate: "30 Dec",
                   endDate: "31 Dec",
                   city: "Sibiu",
                   country: "Romania",
                   contacts: [Contacts(name: "Vlad", image: "Checked"), Contacts(name: "Mihai", image: "Checked"), Contacts(name: "Alin", image: "Checked")]),

        Itinerarys(startDate: "20 Jan",
                   endDate: "22 Jan",
                   city: "Cluj",
                   country: "Romania",
                   contacts: [Contacts(name: "Vlad", image: "Checked"), Contacts(name: "Mihai", image: "Checked")]),
    ]

    func setupRefreshTable() {
        tableView.refreshControl = refreshControls
        refreshControls.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControls.tintColor = UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 1.0)
        refreshControls.attributedTitle = NSAttributedString(string: "Magic ...", attributes: nil)
    }

    @objc private func refreshWeatherData(_: Any) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            refreshControls.endRefreshing()
        }
    }

//    lazy var refreshControls: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action:
//            #selector(MyItineraryTableViewController.handleRefresh(_:)),
//                                 for: UIControlEvents.valueChanged)
//        refreshControl.tintColor = UIColor.red
//
//        return refreshControl
//    }()
//
//    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
//
//        self.tableView.reloadData()
//        refreshControl.endRefreshing()
//    }

    private func getItinerary() {
        let baseURL = URL(string: "https://staging.apreet.com")!
        let client = JSONAPIClient.Alamofire(baseURL: baseURL)
//        let asd: HTTPHeaders = [
//            "Authorization": "Token token=87ef0701fea507a630ecc69ff4c57c85"
//        ]

        let dataSource = DataSource<Itinerary>(strategy: .path("/api/4/itinerary/now"), client: client)
        try! dataSource
            .fetch()
            .result({ (document: Document<[Itinerary]>) in
                let documents = document.data
                print(documents)
            }) { error in
                if let error = error as? JSONAPIError {
                    switch error {
                    case let .API(errors):
                        ()
                    default:
                        ()
                    }
                }
            }
    }
}

extension MyItineraryTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return itis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itinerary", for: indexPath) as! MyItineraryTableViewCell

        view.accessibilityIdentifier = "itineraryItemCell"
        cell.startDateLabel.text = itis[indexPath.row].startDate
        cell.endDateLabel.text = itis[indexPath.row].endDate
        cell.cityLabel.text = itis[indexPath.row].city
        cell.countryLabel.text = itis[indexPath.row].country
        cell.itis = itis[indexPath.row]

        return cell
    }
}
