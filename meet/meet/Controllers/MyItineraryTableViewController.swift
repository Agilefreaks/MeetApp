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

class MyItineraryTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "itineraryView"

        getItinerary()
    }

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
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itinerary", for: indexPath) as! MyItineraryTableViewCell

        view.accessibilityIdentifier = "itineraryItemCell"
        cell.startDateLabel.text = "30 Dec"
        cell.endDateLabel.text = "32 Dec"
        cell.cityLabel.text = "Sibiu"
        cell.countryLabel.text = "Romania"

        return cell
    }
}
