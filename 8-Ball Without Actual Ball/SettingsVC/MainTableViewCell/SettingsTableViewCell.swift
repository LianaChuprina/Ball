import UIKit

final class SettingsTableViewCell: UITableViewCell {
    @IBOutlet private var textAnswer: UITextField!
    
    private var structure: SettingsTableViewCellModel?
    private var block: ((Int, String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    public func render(structure: SettingsTableViewCellModel, block: @escaping ((Int, String) -> Void)) {
        self.structure = structure
        self.block = block
        textAnswer.text = structure.text
    }
    
    @IBAction private func textChanged(_ sender: UITextField) {
        guard let block = block, let structure = structure else { return }
        
        block(structure.id, sender.text ?? "defolt")
    }
    
    func setup() {
        selectionStyle = .none
    }
}

struct SettingsTableViewCellModel {
    var text: String
    var id: Int
}
