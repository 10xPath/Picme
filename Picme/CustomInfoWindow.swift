//
//  CustomInfoWindow.swift
//  Picme
//
//  Created by John Nguyen on 4/5/15.
//  Copyright (c) 2015 John Nguyen. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView {

    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventAttendees: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
