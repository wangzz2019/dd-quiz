//
//  Question.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/1/21.
//

import Foundation

struct Root:Codable{
    let questions: [Question]
}

struct Question:Codable{
    let sequence: Int
    let question: String
    let answers:Array<String>
    let right:Array<Int>
    let tags:Array<String>
}

