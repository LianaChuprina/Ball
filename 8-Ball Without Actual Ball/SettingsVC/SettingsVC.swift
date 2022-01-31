import UIKit

class SettingsVC: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var addAnswerButton: UIButton!
    var presenter: SettingsPresenter?
    
    private var saveAnswer: [String] {
        return UserDefaults.standard.object(forKey:"savedAnswer") as? [String] ?? [String]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let cellNib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cellSettings")
    }
    
    init?(presenter: SettingsPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func tapAddAnswer(_ sender: UIButton) {
        var currentAnswer = saveAnswer
        currentAnswer.append("Defolt")
        UserDefaults.standard.set(currentAnswer, forKey: "savedAnswer")
        tableView.reloadData()
    }
    
}
extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettings",
                                                       for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        
        cell.render(
            structure: SettingsTableViewCellModel(text: saveAnswer[indexPath.row], id: indexPath.row )
        )
        
        return cell
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var currentAnswer = saveAnswer
            currentAnswer.remove(at: indexPath.row)
            UserDefaults.standard.set(currentAnswer, forKey: "savedAnswer")
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        saveAnswer.count
    }
}
