//
//  Util.swift
//  dd-quiz
//
//  Created by Jack Wang on 11/4/21.
//

import Foundation

class Util
{
    class func getScore(a: Array<Int>,ra: Array<Int>) -> Int{
        var correctCount:Double=0.0
        for i in 0..<a.count{
            if (a[i]==ra[i]) {
                correctCount+=1
            }
        }
        let fmaxq=Double(MAXQNUM)
        let retVal=Int(correctCount / fmaxq * 100)
        return retVal
    }
    
    class func checkAllSelected(a: Array<Int>) -> Bool
    {
        for i in a
        {
            if i==0 {return false}
        }
        return true;
    }
    class func getRandomInList(start: Int, end: Int) -> [Int]
    {
        let scope=end-start
        var startArr=Array(1...scope)
        var resultArr=Array(repeating:0,count:scope)
        for i in 0..<startArr.count
        {
            let currentCount=UInt32(startArr.count-i)
            let index=Int(arc4random_uniform(currentCount))
            resultArr[i]=startArr[index]
            startArr[index]=startArr[Int(currentCount)-1]
        }
        return resultArr.map{$0+start}
    }
}
