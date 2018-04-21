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
        recorder.maxRecordDuration = CMTime(seconds: 3, preferredTimescale: 1)
        recorder.delegate = self
    }

    @IBAction func recordTapped(_ sender: Any) {
        recorder.record()
        recordButton.isHidden = true
    }
}

extension RecordVC: SCRecorderDelegate {

    func recorder(_ recorder: SCRecorder, didComplete session: SCRecordSession) {
        print("did complete")
        let player = SCPlayer()
        player.setItemBy(session.assetRepresentingSegments())
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.loopEnabled = true
        player.play()
    }
}
