//
//  Itinerary.swift
//  meet
//
//  Created by Vlad Daneliuc on 29/03/2018.
//  Copyright © 2018 AgileFreaks. All rights reserved.
//

import Foundation
import Vox

class Itinerary: Resource {
    @objc dynamic
    var startDate: String?

    @objc dynamic
    var endDate: String?

    @objc dynamic
    var areaName: String?

    @objc dynamic
    var countryName: String?

    /*------------- Relationships -------------*/

    @objc dynamic
    var picture_url: [Contact]?

    /*------------- Resource type -------------*/

    // resource type must be defined
    override class var resourceType: String {
        return "itinerary"
    }

    /*------------- Custom coding -------------*/

//    override class var codingKeys: [String : String] {
//        return [
//            "descriptionText": "description"
//        ]
//    }
}

class Contact: Resource {
    @objc dynamic var name: String?

    override class var resourceType: String {
        return "contact"
    }
}
