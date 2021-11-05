//
//  QuestionViewController.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/1/21.
//

import UIKit

class QuestionViewController: UIViewController {

    var questions=Array<Question>()
    var currentQNum:Int=1
    var MaxQNum:Int=3
    var rightAnswers=[1,2,3]
    var Answers=[0,0,0]
    var lblQs=Array<OptionLabel>()
    
    @IBOutlet weak var lblQuestions: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblQ1: OptionLabel!
    @IBOutlet weak var lblQ2: OptionLabel!
    @IBOutlet weak var lblQ3: OptionLabel!
    @IBOutlet weak var lblQ4: OptionLabel!
    
    @IBOutlet weak var btnNext: SubmitAnswerButton!
    @IBOutlet weak var btnBack: SubmitAnswerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questions=Data.getRandomQuiz()
        //print(questions.count)
        
        showQuestion(question: questions[0])
        
        lblQs=[lblQ1,lblQ2,lblQ3,lblQ4]
//        let optionTap1=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))
//        let optionTap2=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))
//        let optionTap3=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))
//        let optionTap4=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))
        
//        let optionTap=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))
        
        for i in 0..<lblQs.count {
            self.lblQs[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(optionTap(_:))))
            self.lblQs[i].Num=i+1
        }
        btnNext.addTarget(self, action: #selector(buttonTapped(_:)), for: UIControl.Event.touchUpInside)
    }

    @objc func buttonTapped(_ button: UIButton) {
        if currentQNum < MaxQNum {
            // next question
            currentQNum = currentQNum + 1
            showQuestion(question: self.questions[currentQNum - 1])
        }
        updateSubmitButtonStatus()

    }
    
    //MARK: response to Tap
    @objc func optionTap(_ gesture:UITapGestureRecognizer)
    {
        let label = gesture.view as! OptionLabel
        if !label.isActive
        {
            label.isActive = true
            Answers[self.currentQNum-1]=label.Num
        }
        else
        {
            label.isActive = false
            Answers[self.currentQNum-1]=0
        }
        //for single selection
        for i in 0..<self.lblQs.count {
            if i != label.Num-1 {lblQs[i].isActive=false}
        }
        updateSubmitButtonStatus()
    }
    
    func updateSubmitButtonStatus()
    {
        var canSubmit=false
        if self.currentQNum==self.MaxQNum && Util.checkAllSelected(a: self.Answers)
        {
            canSubmit=true
        }
        self.btnNext.canSubmit=canSubmit
        
//        if canSubmit {
//            self.btnNext.setTitle("Submit", for: .normal)
//        }
//        else{
//            self.btnNext.setTitle("Next", for: .normal)
//        }
        
    }
    
    
    //MARK: -
    //MARK: show questions
    func showQuestion(question:Question){
        self.lblQuestions.text="Questions [\(currentQNum)/10]"
        self.lblQuestion.text=question.question
        self.lblQ1.text="A: \(question.answers[0])"
        self.lblQ2.text="B: \(question.answers[1])"
        self.lblQ3.text="C: \(question.answers[2])"
        self.lblQ4.text="D: \(question.answers[3])"
        
        for i in 0..<lblQs.count {
            lblQs[i].isActive=false
        }
        if Answers[self.currentQNum-1] != 0{
            lblQs[Answers[self.currentQNum-1]-1].isActive=true
        }
    }
    
    
    @IBAction func backHandler(_ sender: Any) {
        if currentQNum == 1 {return}
        currentQNum-=1
        showQuestion(question: self.questions[currentQNum-1])
        updateSubmitButtonStatus()
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
