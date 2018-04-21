import UIKit

class RecordVC: UIViewController {

    var recorder: SCRecorder!

    @IBOutlet weak var recordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        recorder = SCRecorder.shared()
        if !recorder.startRunning() {
        }
        recorder.session = SCRecordSession()
        recorder.previewView = view
    }

    @IBAction func recordTapped(_ sender: Any) {
        recorder.record()
        recordButton.isHidden = true
    }
}
