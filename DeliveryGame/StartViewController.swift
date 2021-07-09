import UIKit

final class StartViewController: UIViewController {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    private var userDefaults = UserDefaults.standard
    private let highScoreKey = "highScoreKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScoreLabel.text = String(format: "%.1f", highScore ?? 0)
        
    }
    @IBAction func startButtonDidPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }

    private var highScore: Double? {
        get{
            guard (userDefaults.object(forKey: highScoreKey) != nil) else { return nil }
            return userDefaults.double(forKey: highScoreKey)
        }
        set{
            guard highScore ?? 9999999 > newValue! else { return }
            userDefaults.set(newValue, forKey: highScoreKey)
        }
    }
}

extension StartViewController: GameViewControllerDelegate {
    func endGame(points: Double) {
        highScore = points
        highScoreLabel.text = String(format: "%.1f", highScore ?? 0)
    }
}
