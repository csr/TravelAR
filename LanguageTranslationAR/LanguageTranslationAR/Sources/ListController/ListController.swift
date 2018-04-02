import UIKit

class ListController: BasePopUpController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var list = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Nothing on the list yet.\nLet's scan an object get started!"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = list.isEmpty ? "New Words Go Here" : "Tap Item to Play"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

