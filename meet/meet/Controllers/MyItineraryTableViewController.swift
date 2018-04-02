//
//  MyItineraryTableViewController.swift
//  meet
//
//  Created by Vlad Daneliuc on 26/03/2018.
//  Copyright © 2018 AgileFreaks. All rights reserved.
//

import UIKit
import Vox
import Alamofire

class MyItineraryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.getItinerary()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        }) { (error) in
            if let error = error as? JSONAPIError {
                switch error {
                case .API(let errors):
                    ()
                default:
                    ()
                }
        }
    }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyItineraryTableViewController {
        // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itinerary", for: indexPath) as! MyItineraryTableViewCell
        
        cell.startDateLabel.text = "30 Dec"
        cell.endDateLabel.text = "32 Dec"
        cell.cityLabel.text = "Sibiu"
        cell.countryLabel.text = "Romania"
        
        return cell
    }
}
