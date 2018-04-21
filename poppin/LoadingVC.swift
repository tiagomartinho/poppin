import UIKit
import NVActivityIndicatorView

class LoadingVC: UIViewController {

    @IBOutlet weak var indicatorView: NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.type = .lineScale
        indicatorView.startAnimating()
    }
}
