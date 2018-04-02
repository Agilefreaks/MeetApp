//
//  MyItineraryTableViewCell.swift
//  meet
//
//  Created by Vlad Daneliuc on 26/03/2018.
//  Copyright © 2018 AgileFreaks. All rights reserved.
//

import UIKit

class MyItineraryTableViewCell: UITableViewCell {
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var contactsCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MyItineraryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topFive", for: indexPath) as! TopFiveCollectionViewCell
        cell.personImageView.image = UIImage(named: "Checked")
        cell.personName.text = "Me"
        return cell
    }
}
