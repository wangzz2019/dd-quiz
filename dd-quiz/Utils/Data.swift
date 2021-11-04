//
//  Data.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/2/21.
//

import Foundation

class Data
{
    class func toJSONString(dict:Dictionary<String, Any>!) -> NSString
    {
        do{
            let data=try JSONSerialization.data(withJSONObject: dict, options: .init(rawValue:0))
            let strJson=NSString(data:data,encoding: String.Encoding.utf8.rawValue)
            return strJson!
        }catch{
            return ""
        }
    }
    
    class func getRandomQuiz() -> Array<Question>{
        let plistPath = Bundle.main.path(forResource: "quiz", ofType: "plist")
        let plistData = NSMutableDictionary.init(contentsOfFile: plistPath!)!
        let pagesData = plistData as! Dictionary<String, Array<Dictionary<String, Any>>>
        let quizzes = pagesData["questions"]
        
        var result=Array<Question>()
        for num in 0..<3
        {
            var questionDic=quizzes![Int(num)]
            questionDic["sequence"]=num+1
            let jsonData=Data.toJSONString(dict:questionDic).data(using: String.Encoding.utf8.rawValue)
            let decoder=JSONDecoder()
            let q=try! decoder.decode(Question.self,from:jsonData!)
            result.append(q)
        }
        return result
    }
}
