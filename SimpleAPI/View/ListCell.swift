//
//  ListCell.swift
//  ComprendreLesAPI
//
//  Created by Mathieu @theunknowman_80 29/05/2023.



//This custom cell should give you a first glimpse of how to associate data from random profiles with objects present in a table view cell.

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!

    var user: User!
    
    func setup(_ newUser: User) {
        self.iv.image = UIImage(systemName: "person.circle.fill")
        user = newUser
        ImageDownloader.shared.fromUrlString(user.picture.medium) { data in
            self.iv.image = data == nil ? UIImage(systemName: "person.circle.fill") : UIImage(data: data!)
        }
        self.nameLbl.text = user.name.first + " " + user.name.last
        self.countryLbl.text = user.location.country
        self.iv.layer.cornerRadius = self.iv.frame.height / 2
    }

}
