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
        let questions=Data.getRandomQuiz()
        print(questions.count)
        
    }
    
    //MARK: -
    //MARK: show questions
    func showQuestion(question:Question){
        
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
