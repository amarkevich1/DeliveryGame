import UIKit

final class StartViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func startButtonDidPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension StartViewController: GameViewControllerDelegate {
    func endGame(points: Double) {
        scoreLabel.text = String(format: "%.1f", points)
    }
}
