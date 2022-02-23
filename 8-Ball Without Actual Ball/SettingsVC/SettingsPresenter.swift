import Foundation

final class SettingsPresenter {
    let model: SettingsModel

    var saveAnswer: [String] {
        return UserDefaults.standard.object(forKey:"savedAnswer") as? [String] ?? [String]()
    }
    
    init(model: SettingsModel) {
        self.model = model
    }
    
    
     func addNewAnswer(complited: @escaping (() -> Void)) {
        var currentAnswer = saveAnswer
        currentAnswer.append("Defolt")
        UserDefaults.standard.set(currentAnswer, forKey: "savedAnswer")
         complited()
    }
    
     func removeAnswer(complited: @escaping (() -> Void), index: Int) {
        var currentAnswer = saveAnswer
        currentAnswer.remove(at: index)
        UserDefaults.standard.set(currentAnswer, forKey: "savedAnswer")
        complited()
    }
    
    func changeAnswer(index: Int, text: String) {
        var currentAnswer = saveAnswer
        currentAnswer[index] = text
        UserDefaults.standard.set(currentAnswer, forKey: "savedAnswer")
    }
}
