import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet private var textAnswer: UITextField!
    
    private var structure: SettingsTableViewCellModel?
    var saveAnswer: [String] {
        return UserDefaults.standard.object(forKey:"savedAnswer") as? [String] ?? [String]()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func render(structure: SettingsTableViewCellModel) {
        self.structure = structure
        textAnswer.text = structure.text
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
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
