import UIKit
import NVActivityIndicatorView

class LoadingVC: UIViewController {

    @IBOutlet weak var indicatorView: NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.type = .lineScale
        indicatorView.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (_) in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
