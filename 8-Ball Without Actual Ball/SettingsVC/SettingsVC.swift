import UIKit

class SettingsVC: UIViewController {
    var presenter: SettingsPresenter?
   
   override func viewDidLoad() {
       super.viewDidLoad()

   }
   
   init?(presenter: SettingsPresenter) {
       self.presenter = presenter
       
       super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
