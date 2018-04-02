//
//  Itinerary.swift
//  meet
//
//  Created by Vlad Daneliuc on 29/03/2018.
//  Copyright © 2018 AgileFreaks. All rights reserved.
//

import Foundation
import Spine

class Itinerary: Resource {
    /*------------- Relationships -------------*/

    var itineraryItems: LinkedResourceCollection?

    /*------------- Resource type -------------*/

    override class var resourceType: ResourceType {
        return "itinerary"
    }

    override class var fields: [Field] {
        return fieldsFromDictionary([
            "itineraryItems": ToManyRelationship(ItineraryItem.self),
        ])
    }
}

class ItineraryItem: Resource {
    @objc dynamic
    var startDate: String?

    @objc dynamic
    var endDate: String?

    @objc dynamic
    var areaName: String?

    @objc dynamic
    var countryName: String?

    override class var resourceType: ResourceType {
        return "itineraryItem"
    }
}

class Contact: Resource {
    @objc dynamic var name: String?

    override class var resourceType: ResourceType {
        return "contact"
    }
}
