import UIKit

final class SettingsVC: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var addAnswerButton: UIButton!
    
    private var presenter: SettingsPresenter?
    
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
    
    // Реагируем на нажатие кнопки "добавить"
    @IBAction private func tapAddAnswer(_ sender: UIButton) {
        presenter?.addNewAnswer { self.tableView.reloadData() }
    }
}

extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettings",
                                                       for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        
        cell.render(
            structure: SettingsTableViewCellModel(text: presenter?.saveAnswer[indexPath.row] ?? "error", id: indexPath.row )
        )
        
        return cell
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.removeAnswer(complited: {
                tableView.reloadData()
            }, index: indexPath.row)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.saveAnswer.count ?? 0
    }
}
