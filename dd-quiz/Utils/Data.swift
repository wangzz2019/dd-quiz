//
//  Data.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/2/21.
//

import Alamofire
import Foundation

class Data {
    class func toJSONString(dict: Dictionary<String, Any>!) -> NSString {
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: .init(rawValue: 0))
            let strJson = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            return strJson!
        } catch {
            return ""
        }
    }

    class func getQuizJson() {
        let maxNum = 3
        let parameters: [String: Int] = ["num": maxNum]

        let urlString: String = "http://localhost:8080/quiz"

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-type": "application/json",
        ]
        print(parameters)
        AF.request(urlString, method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON { response in
//            print("response: \(response)")
            switch response.result {
            case let .success(value):
                print("value**: \(value)")

            case let .failure(error):
                print(error)
            }
        }
    }

    class func getRandomQuiz() -> Array<Question> {
        var result = Array<Question>()

        // get data from web service by Alamofire
        var parameters: [String: Int]
        let maxNum = 3
        let urlString: String = "http://localhost:8080/quiz"
        parameters = ["num": maxNum]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-type": "application/json",
        ]
        AF.request(urlString, method: .post, parameters: parameters,
                   encoder: JSONParameterEncoder.prettyPrinted,
                   headers: headers).responseJSON { response in
//            print("response: \(response)")
            switch response.result {
            case .success:
                var qs = response.value as! Array<Dictionary<String, Any>>
//                print("value**: \(response.value)")
                var qNum:Int = 1
                for dict in qs {
                    print(dict)
                    var dictQuestion=dict
                    dictQuestion["sequence"]=qNum
                    
                    let strAnswers:String=dict["answers"] as! String
                    let answersArray=strAnswers.components(separatedBy: ",")
                    dictQuestion["answers"]=answersArray
                    
                    let intRight:Int=(dict["right"] as! NSString).integerValue
                    let rightArray:[Int]=[intRight]
                    dictQuestion["right"]=rightArray
                    
                    if let strTags:String=dict["tags"] as? String {
                        let tagsArray=strTags.components(separatedBy: ",")
                        dictQuestion["tags"]=tagsArray
                    }
                    else{
                        dictQuestion["tags"]=[""]
                    }
                    let jsonData=Data.toJSONString(dict:dictQuestion).data(using: String.Encoding.utf8.rawValue)
                    let decoder=JSONDecoder()
                    let q=try! decoder.decode(Question.self,from:jsonData!)
                    
//                    let question=Question()
//                    question.sequence=qNum
//                    question.question=dict["question"]
//                    question.answers=dict["answers"]
//                    question.right=dict["right"]
//                    question.id=dict["id"]
                    qNum=qNum+1
                    result.append(q)
                }
                //return result
            case let .failure(error):
                print(error)
            }
        }
//        self.getQuizJson()

        return result
    }

    // get data from web service by URLSession
//        let urlString: String = "http://localhost:8080/quiz"
//        let url: URL! = URL(string: urlString)
//        let maxNum = 3
//        var request: URLRequest = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let json: [String: Any] = ["num": maxNum]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//        request.httpBody = jsonData
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        var questionJsonString: String
//
//        let session = URLSession.shared
//
//
//        let semaphore = DispatchSemaphore(value: 0)
//        let task=session.dataTask(with: request) {(data,response,error) in
//            do {
//                let r=try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Array<Dictionary<String, Any>>
//                print (r)
//            }catch {
//                return
//            }
//        }
//        task.resume()
//
//        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                DispatchQueue.main.async {
//                    print(response as Any)
//                    let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                    print (jsonString as Any)
//                    self.questionJsonString = jsonString as String?
//                }
//
//            }
//            semaphore.signal()
//        })
//
//        dataTask.resume()
//        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
//        print (questionJsonString)
//        var result = Array<Question>()
//        for num in 0 ..< maxNum {
//            let decoder = JSONDecoder()
//        }
//        return result

    // get data from local quiz files
//        let plistPath = Bundle.main.path(forResource: "quiz", ofType: "plist")
//        let plistData = NSMutableDictionary.init(contentsOfFile: plistPath!)!
//        let pagesData = plistData as! Dictionary<String, Array<Dictionary<String, Any>>>
//        let quizzes = pagesData["questions"]
//
//        var result=Array<Question>()
//        for num in 0..<3
//        {
//            var questionDic=quizzes![Int(num)]
//            questionDic["sequence"]=num+1
//            let jsonData=Data.toJSONString(dict:questionDic).data(using: String.Encoding.utf8.rawValue)
//            let decoder=JSONDecoder()
//            let q=try! decoder.decode(Question.self,from:jsonData!)
//            result.append(q)
//        }
//        return result
//    }
    // }
}
