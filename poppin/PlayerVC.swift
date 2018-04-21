import UIKit

class PlayerVC: UIViewController {

    @IBOutlet weak var takeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let player = SCPlayer()
        
        guard let path = Bundle.main.path(forResource: "video", ofType:"MOV") else {
            debugPrint("video.m4v not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        player.setItemBy(url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.loopEnabled = true
        player.play()
        view.bringSubview(toFront: takeButton)
    }
    @IBAction func fdskjhfsdjkh(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
