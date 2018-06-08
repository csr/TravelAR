import UIKit

class ListController: BasePopUpController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var list = [Translation]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = NSLocalizedString("No items", comment: "No items")
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = list.isEmpty ? NSLocalizedString("History", comment: "New words") : NSLocalizedString("Tap to play", comment: "Tap item to play")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

