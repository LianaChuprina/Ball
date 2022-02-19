import UIKit

final class SettingsTableViewCell: UITableViewCell {
    @IBOutlet private var textAnswer: UITextField!
    
    private var structure: SettingsTableViewCellModel?
    private var saveAnswer: [String] {
        return UserDefaults.standard.object(forKey:"savedAnswer") as? [String] ?? [String]()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    public func render(structure: SettingsTableViewCellModel) {
        self.structure = structure
        textAnswer.text = structure.text
    }
    
    @IBAction private func textChanged(_ sender: UITextField) {
        if let structure = structure {
            var currentAnswer = saveAnswer
            currentAnswer[structure.id] = sender.text ?? "Defolt"
            UserDefaults.standard.set(currentAnswer, forKey: "savedAnswer")
        }
    }
    
    func setup() {
        selectionStyle = .none
    }
}

struct SettingsTableViewCellModel {
    var text: String
    var id: Int
}
