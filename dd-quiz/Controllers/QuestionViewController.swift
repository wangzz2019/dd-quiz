//
//  QuestionViewController.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/1/21.
//

import Alamofire
import UIKit

class QuestionViewController: UIViewController {
    var questions = Array<Question>()
    var currentQNum: Int = 1
//    var MaxQNum: Int = 3
    var rightAnswers = Array<Int>(repeating: 0, count: MAXQNUM)
    var Answers = [0, 0, 0]
    var lblQs = Array<OptionLabel>()

    @IBOutlet var lblQuestions: UILabel!

    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var lblQ1: OptionLabel!
    @IBOutlet var lblQ2: OptionLabel!
    @IBOutlet var lblQ3: OptionLabel!
    @IBOutlet var lblQ4: OptionLabel!

    @IBOutlet var questionArea: UIView!
    @IBOutlet var btnNext: SubmitAnswerButton!
    @IBOutlet var btnBack: SubmitAnswerButton!

    @IBOutlet var pcv: ProgressCircleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // use Alamofire for getting data
        let parameters: [String: Int] = ["num": MAXQNUM]
//        let urlString: String = "http://localhost:8080/quiz"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-type": "application/json",
        ]
        print(parameters)
        AF.request(URLSTRING,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                // Change values to Question
                // set values to UI
                let qs = response.value as! Array<Dictionary<String, Any>>
//                print("value**: \(response.value)")
                var qNum: Int = 1
                for dict in qs {
                    print(dict)
                    var dictQuestion = dict
                    dictQuestion["sequence"] = qNum

                    let strAnswers: String = dict["answers"] as! String
                    let answersArray = strAnswers.components(separatedBy: ",")
                    dictQuestion["answers"] = answersArray

                    let intRight: Int = (dict["right"] as! NSString).integerValue
                    let rightArray: [Int] = [intRight]
                    dictQuestion["right"] = rightArray

                    if let strTags: String = dict["tags"] as? String {
                        let tagsArray = strTags.components(separatedBy: ",")
                        dictQuestion["tags"] = tagsArray
                    } else {
                        dictQuestion["tags"] = [""]
                    }
                    let jsonData = Data.toJSONString(dict: dictQuestion).data(using: String.Encoding.utf8.rawValue)
                    let decoder = JSONDecoder()
                    let q = try! decoder.decode(Question.self, from: jsonData!)
                    qNum = qNum + 1
                    self.questions.append(q)
                }
                self.showQuestion(question: self.questions[0])
                // fill rightAnswers
                self.fillRightAnswers(questions: self.questions)
            case let .failure(error):
                print(error)
            }
        }

        lblQs = [lblQ1, lblQ2, lblQ3, lblQ4]
//        let optionTap1=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))
//        let optionTap2=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))
//        let optionTap3=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))
//        let optionTap4=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))

//        let optionTap=UITapGestureRecognizer(target: self, action: #selector(optionTap(_:)))

        for i in 0 ..< lblQs.count {
            lblQs[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(optionTap(_:))))
            lblQs[i].Num = i + 1
        }
        btnNext.addTarget(self, action: #selector(buttonTapped(_:)), for: UIControl.Event.touchUpInside)
    }

    @objc func buttonTapped(_ button: UIButton) {
        if currentQNum < MAXQNUM {
            // next question
            currentQNum = currentQNum + 1
            showQuestion(question: questions[currentQNum - 1])
        } else {
            questionArea.isHidden = true
            pcv.updateSubView()
            pcv.isHidden = false
            pcv.alpha = 0
            let score = Util.getScore(a: Answers, ra: rightAnswers)
            pcv.setScore(score: score)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                self.pcv.alpha = 1.0
            }, completion: { (_) -> Void in
//                self.pcv.setProgress(value: CGFloat(100), animationDuration: 1.0)
            })
        }
        updateSubmitButtonStatus()
    }

    // MARK: response to Tap

    @objc func optionTap(_ gesture: UITapGestureRecognizer) {
        let label = gesture.view as! OptionLabel
        if !label.isActive {
            label.isActive = true
            Answers[currentQNum - 1] = label.Num
        } else {
            label.isActive = false
            Answers[currentQNum - 1] = 0
        }
        // for single selection
        for i in 0 ..< lblQs.count {
            if i != label.Num - 1 { lblQs[i].isActive = false }
        }
        updateSubmitButtonStatus()
    }

    func updateSubmitButtonStatus() {
        var canSubmit = false
        if currentQNum == MAXQNUM && Util.checkAllSelected(a: Answers) {
            canSubmit = true
        }
        btnNext.canSubmit = canSubmit

//        if canSubmit {
//            self.btnNext.setTitle("Submit", for: .normal)
//        }
//        else{
//            self.btnNext.setTitle("Next", for: .normal)
//        }
    }

    // MARK: -

    // MARK: show questions

    func fillRightAnswers(questions: Array<Question>) {
        for i in 0 ..< questions.count {
            rightAnswers[i] = questions[i].right[0]
        }
    }

    func showQuestion(question: Question) {
        lblQuestions.text = "Questions [\(currentQNum)/\(MAXQNUM)]"
        lblQuestion.text = question.question
        lblQ1.text = "A: \(question.answers[0])"
        lblQ2.text = "B: \(question.answers[1])"
        lblQ3.text = "C: \(question.answers[2])"
        lblQ4.text = "D: \(question.answers[3])"

        for i in 0 ..< lblQs.count {
            lblQs[i].isActive = false
        }
        if Answers[currentQNum - 1] != 0 {
            lblQs[Answers[currentQNum - 1] - 1].isActive = true
        }
    }

    @IBAction func backHandler(_ sender: Any) {
        if currentQNum == 1 { return }
        currentQNum -= 1
        showQuestion(question: questions[currentQNum - 1])
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
