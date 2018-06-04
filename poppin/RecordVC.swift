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
        view.addAndPin(view: buildPlayerView(playerLayer: playerLayer))
        player.loopEnabled = true
        player.play()
        upload.isHidden = false
        view.bringSubview(toFront: upload)
        recordButton.isHidden = true
    }

    private func buildPlayerView(playerLayer: AVPlayerLayer) -> PlayerView {
        let playerView = PlayerView()
        playerView.playerLayer = playerLayer
        playerLayer.videoGravity = .resizeAspectFill
        playerView.layer.addSublayer(playerLayer)
        return playerView
    }
}

class PlayerView: UIView {

    var playerLayer: CALayer?

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        playerLayer?.frame = bounds
    }
}

extension UIView {
    func addAndPin(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
