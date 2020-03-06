
import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arr = [Film]()
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        
        self.title = "Films"
        
        fetchFilms()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? TableViewCell
        cell?.lblTitle.text = arr[indexPath.row].title
        cell?.lblSubtitle.text = arr[indexPath.row].releaseDate
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        newViewController.film = arr[indexPath.row]
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func fetchFilms() {
        let request = AF.request("https://swapi.co/api/films")
        request.responseDecodable(of: Films.self) { (response) in
            guard let films = response.value else { return }
            self.arr.append(contentsOf: films.all)
            self.tblView.reloadData()
        }
    }
}

struct Film: Decodable {
    let id: Int
    let title: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let starships: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case starships
    }
}

//extension Film: Displayable {
//  var titleLabelText: String {
//    title
//  }
//
//  var subtitleLabelText: String {
//    "Episode \(String(id))"
//  }
//
//  var item1: (label: String, value: String) {
//    ("DIRECTOR", director)
//  }
//
//  var item2: (label: String, value: String) {
//    ("PRODUCER", producer)
//  }
//
//  var item3: (label: String, value: String) {
//    ("RELEASE DATE", releaseDate)
//  }
//
//  var listTitle: String {
//    "STARSHIPS"
//  }
//
//  var listItems: [String] {
//    starships
//  }
//}

struct Films: Decodable {
    let count: Int
    let all: [Film]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}

