import UIKit

class RecordVC: UIViewController {

    var recorder: SCRecorder!

    @IBOutlet weak var upload: UIStackView!
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
        recordButton.setImage(#imageLiteral(resourceName: "stop video"), for: .normal)
    }
    var player: SCPlayer!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        player.pause()
    }
}

extension RecordVC: SCRecorderDelegate {


    func recorder(_ recorder: SCRecorder, didComplete session: SCRecordSession) {
        print("did complete")
        player = SCPlayer()
        player.setItemBy(session.assetRepresentingSegments())
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.loopEnabled = true
        player.play()
        upload.isHidden = false
        view.bringSubview(toFront: upload)
        recordButton.isHidden = true
    }
}
