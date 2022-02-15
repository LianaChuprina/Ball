import UIKit

final class MainVC: UIViewController {
    @IBOutlet private var questionTextView: UITextView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var informationLabel: UILabel!
    private var answerOnQuestion = [SaveAnswer]()
    
    var presenter: MainPresenter?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    init?(presenter: MainPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        tableView.dataSource = self
        questionTextView.layer.cornerRadius = 8
        tableView.layer.cornerRadius = 8
        questionTextView.delegate = self
        let cellNib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        switchStateInformationLabel(.default)
    }
    
    func switchStateInformationLabel(_ state: StateInformation) {
        switch state {
        case .default:
            informationLabel.text = "Start typing a message"
            
        case .inputText:
            informationLabel.text = "We are waiting for you to finish :)"
            
        case .getAnswer(let answer):
            informationLabel.text = "Your answer - \(answer)"
            
        case .needShake:
            informationLabel.text = "You have to shake your phone to see the answer"
            
        case .expectAnswer:
            informationLabel.text = "Waiting for a response from the great ball"
            
        case .noOnlyLetters:
            informationLabel.text = "Only Latin alphabet allowed"
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switchStateInformationLabel(.getAnswer(answer: answerOnQuestion.last?.answer.answer ?? ""))
        tableView.reloadData()
    }
}

extension MainVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard !textView.text.isEmpty else {
            switchStateInformationLabel(.default)
            return
        }
        
        switchStateInformationLabel(.inputText)
        debounce(seconds: 0.5) {
            self.switchStateInformationLabel(.expectAnswer)
            if let check = self.containsOnlyLetters(input: textView.text) {
                if check {
                    self.presenter?.getAnswerOnQuestion(question: textView.text, compl: { answer in
                        self.answerOnQuestion.append(SaveAnswer(answer: answer, date: Date()))
                        self.switchStateInformationLabel(.needShake)
                    })
                } else {
                    self.switchStateInformationLabel(.noOnlyLetters)
                }
            } else {
                self.switchStateInformationLabel(.default)
            }
        }
    }
    
    func debounce(seconds: TimeInterval, function: @escaping () -> Swift.Void ) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: seconds,
                                     repeats: false,
                                     block: { _ in
            function()
        })
    }
    
    func containsOnlyLetters(input: String) -> Bool? {
        guard !input.isEmpty else { return nil }
        
        for chr in input {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        
        return true
    }
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        let model = MainTableViewModel(
            question: answerOnQuestion.reversed()[indexPath.row].answer.question,
            answer: answerOnQuestion.reversed()[indexPath.row].answer.answer,
            time:answerOnQuestion.reversed()[indexPath.row].date.description
        )
        
        cell.render(
            structure: model
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answerOnQuestion.count
    }
}

struct SaveAnswer {
    let answer: Answer
    let date: Date
}

enum StateInformation {
    case `default`
    case inputText
    case getAnswer(answer: String)
    case expectAnswer
    case needShake
    case noOnlyLetters
}
