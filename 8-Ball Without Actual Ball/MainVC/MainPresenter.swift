import Foundation
import Alamofire

final class MainPresenter {
    let model: MainModel
    var saveAnswers: [String] {
        return UserDefaults.standard.object(forKey:"savedAnswer") as? [String] ?? [String]()
    }
    var answerOnQuestions = [SaveAnswer]()
    
    init(model: MainModel) {
        self.model = model
    }
    
    // Отправляем вопрос пользователя в виде строки в теле запроса
    // Получаем параметры
    // question: String - вопрос пользователя
    // answer: String - ответ на вопрос пользователя
    // type: String - тип вопроса пользователя
    
    func getAnswerOnQuestion(question: String, completed: @escaping (Answer) -> Void) {
        AF.request("https://8ball.delegator.com/magic/JSON/\(question)").responseDecodable(of: ModelAnswerOnQuestion.self) { response in
            switch response.result {
            case .success(_):
                guard let answer = response.value else { return }
                
                completed(answer.magic)
                
            case .failure(let encodingError):
                switch encodingError {
                case .sessionTaskFailed(_):
                    if !self.saveAnswers.isEmpty {
                        completed(Answer(question: question,
                                         answer: self.saveAnswers[Int.random(in: 0...self.saveAnswers.count - 1)],
                                         type: ""))
                    } else {
                        // при отсутствии интернета и локально сохраненных запрограмированных ответов
                        completed(Answer(question: question, answer: "Mabe", type: ""))
                    }
                    
                default:
                    break
                }
            }
        }
    }
}
