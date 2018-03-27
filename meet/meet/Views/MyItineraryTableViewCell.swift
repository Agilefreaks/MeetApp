//
//  MyItineraryTableViewCell.swift
//  meet
//
//  Created by Vlad Daneliuc on 26/03/2018.
//  Copyright © 2018 AgileFreaks. All rights reserved.
//

import UIKit

class MyItineraryTableViewCell: UITableViewCell {
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var contactsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MyItineraryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topFive", for: indexPath) as! TopFiveCollectionViewCell
//        cell.personImageView.image = UIImage(named: "")
        cell.personName.text = "Me"
        return cell
    }
    
    
}
