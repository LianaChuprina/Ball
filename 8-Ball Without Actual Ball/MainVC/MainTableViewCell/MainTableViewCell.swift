import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet var time: UILabel!
    @IBOutlet var labelAnswer: UILabel!
    @IBOutlet var labelQuestion: UILabel!
    
    private var structure: MainTableViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    
    func render(structure: MainTableViewModel) {
        self.structure = structure
        labelQuestion.text = structure.question
        labelAnswer.text = structure.answer
        time.text = structure.time
    }
    
    func setup() {
        selectionStyle = .none
    }
}
