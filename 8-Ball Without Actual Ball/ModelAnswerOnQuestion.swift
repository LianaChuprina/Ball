import Foundation

struct ModelAnswerOnQuestion: Codable {
    let magic: Answer
}

struct Answer: Codable {
    let question: String
    let answer: String
    let type: String
}
