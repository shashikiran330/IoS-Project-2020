
import UIKit

class DetailViewController: UIViewController {

    var film: Film!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblPro: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        self.title = film.title
        
        self.lblDate.text = film.releaseDate
        self.lblName.text = film.title
        self.lblPro.text = film.producer
        self.lblDirector.text = film.director
    }
}
