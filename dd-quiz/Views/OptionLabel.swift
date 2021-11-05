//
//  OptionLabel.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/5/21.
//

import UIKit

class OptionLabel: UILabel {
    open var isActive: Bool{
        didSet{
            self.textColor=isActive==true ? .orange : UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
        }
    }
    open var Num: Int
    
    override init(frame: CGRect){
        self.isActive=false
        self.Num=0
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.isActive=false
        self.Num=0
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
