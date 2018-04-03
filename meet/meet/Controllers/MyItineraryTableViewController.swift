//
//  MyItineraryTableViewController.swift
//  meet
//
//  Created by Vlad Daneliuc on 26/03/2018.
//  Copyright © 2018 AgileFreaks. All rights reserved.
//

import Alamofire
import Spine
import UIKit

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

public struct FormatterMeet: KeyFormatter {
    public func format(_ name: String) -> String {
        return name
    }

    public func format(field: Field) -> String {
        return field.serializedName
    }
}

class MyItineraryTableViewController: UITableViewController {
    var spine: Spine!
    var httpClient: HTTPClient!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "itineraryView"

        setupRefreshTable()
        setupSpine()
    }

    var itis = [
        Itinerarys(startDate: "26 Dec",
                   endDate: "28 Dec",
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
        refreshControls.addTarget(self, action: #selector(refreshItineraryTable(_:)), for: .valueChanged)
        refreshControls.tintColor = UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 1.0)
        refreshControls.attributedTitle = NSAttributedString(string: "Magic ...", attributes: nil)
    }

    @objc private func refreshItineraryTable(_: Any) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            refreshControls.endRefreshing()
        }
    }

    func setupSpine() {
        httpClient = HTTPClient()
        httpClient.setHeader("Authorization", to: "Token token=87ef0701fea507a630ecc69ff4c57c85")
        spine = Spine(baseURL: URL(string: "https://staging.apreet.com/api/4")!, networkClient: httpClient)
        spine.registerResource(Itinerary.self)
        spine.registerResource(ItineraryItem.self)
        spine.keyFormatter = FormatterMeet()

        Spine.setLogLevel(.info, forDomain: .spine)
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
        let item = itis[indexPath.row]
        cell.startDateLabel.text = item.startDate
        cell.endDateLabel.text = item.endDate
        cell.cityLabel.text = item.city
        cell.countryLabel.text = item.country
        cell.itis = item

        return cell
    }
}
