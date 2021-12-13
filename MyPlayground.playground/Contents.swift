import UIKit
import Alamofire

let headers: HTTPHeaders = [
    "Accept": "application/json",
    "Content-type": "application/json",
]

AF.request("http://localhost:8080/quiz", method: .post,
                   parameters: ["num":3],
                   encoding: JSONEncoding.default,
           headers: headers).responseJSON { response in
    print("response: \(response)")
    switch response.result {
                case .success(let value):
                    print("value**: \(value)")
                    
                case .failure(let error):
                    print(error)
                }
    
}

var greeting = "Hello, playground"
print (greeting)
