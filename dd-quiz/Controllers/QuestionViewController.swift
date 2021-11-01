//
//  QuestionViewController.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/1/21.
//

import UIKit

class QuestionViewController: UIViewController {

    var questions=Array<Question>()
    
    @IBOutlet weak var lblQuestion: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url=Bundle.main.url(forResource: "quiz", withExtension: "plist")!
        do {
            let data=try Data(contentsOf: url)
            let result=try PropertyListDecoder().decode(Root.self, from: data)
            self.questions=result.questions
            print(self.questions[0].sequence)
            lblQuestion.text=self.questions[0].question
        } catch {print(error)}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
