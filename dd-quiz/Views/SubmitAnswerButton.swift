//
//  SubmitAnswerButton.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/5/21.
//

import UIKit

class SubmitAnswerButton: UIButton {
    open var canSubmit: Bool = false {
        didSet {
            // self.backgroundColor = canSubmit == true ? .orange : UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "MarkerFelt-Wide", size: 40.0) as Any,
                .foregroundColor: UIColor.white]

            if canSubmit {
                let newTitle = NSAttributedString(string: "Submit", attributes: textAttributes)
                self.setAttributedTitle(newTitle, for: .normal)
//                self.setTitle("Submit", for: .normal)
//                self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
            } else {
                let newTitle = NSAttributedString(string: "Next", attributes: textAttributes)
                self.setAttributedTitle(newTitle, for: .normal)
//                self.titleLabel?.font = UIFont(name:"Marker Felt",size:40.0)
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        super.draw(rect)
//        self.titleLabel?.font=UIFont(name:"Marker Felt",size:40)
//    }

}
