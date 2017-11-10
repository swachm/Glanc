//
//  contactTableViewCell.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-05-30.
//  Copyright © 2016 Swach. All rights reserved.
//

import UIKit

class contactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userThumb: UIImageView!
    @IBOutlet weak var contactFullname: UILabel!
    @IBOutlet weak var requestStatus: UIButton!
    @IBOutlet weak var phoneNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setcell(_ contactFullname: String, userThumb: UIImage, phoneNumber: String){
        //self.userThumb.image = userThumbnail
        self.contactFullname.text = contactFullname
        self.userThumb.image = userThumb
        self.userThumb.contentMode = .scaleAspectFit
        self.phoneNumber.text = phoneNumber
    }
}
