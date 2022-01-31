import Foundation
import Alamofire

class MainPresenter {
    let model: MainModel
    var saveAnswer: [String] {
        return UserDefaults.standard.object(forKey:"savedAnswer") as? [String] ?? [String]()
    }
    
    init(model: MainModel) {
        self.model = model
    }
    
    func getAnswerOnQuestion(question: String, compl: @escaping (Answer) -> Void) {
        AF.request("https://8ball.delegator.com/magic/JSON/\(question)").responseDecodable(of: ModelAnswerOnQuestion.self) { response in
            switch response.result {
            case .success(_):
                guard let answer = response.value else { return }
                
                compl(answer.magic)
                
            case .failure(let encodingError):
                switch encodingError {
                case .sessionTaskFailed(_):
                    if !self.saveAnswer.isEmpty {
                        compl(Answer(question: question, answer: self.saveAnswer[Int.random(in: 0...self.saveAnswer.count - 1)], type: ""))
                    } else {
                        compl(Answer(question: question, answer: "qwertyuiop", type: ""))
                    }
                    
                default:
                    break
                }
            }
        }
    }
}
