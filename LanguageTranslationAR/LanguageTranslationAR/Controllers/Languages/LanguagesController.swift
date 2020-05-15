//
//  LanguagesController.swift
//  LanguageTranslationAR
//

import UIKit

class LanguagesController: UIViewController {
    
    var tableViewSource = [String: [Language]]()
    var tableViewHeaders = [String]()
    
    var didUpdateLanguageDelegate: DidUpdateLanguageDelegate?
    
    var activityIndicatorView = UIActivityIndicatorView()

    var selectedIndexPath: IndexPath?
    
    var selectedLanguage: Language? {
        didSet {
            guard let language = selectedLanguage else { return }
            LanguagePreferences.save(language: language)
            setButtonTitle()
            print("Saving language \(language.name), code: \(language.code)")
        }
    }
    
    let cellId = "reuseIdentifier"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let chooseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .black
        displayActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.isNavigationBarHidden = false
        getLanguages()
    }
    
    func getLanguages() {
        let languageCode = LanguagePreferences.getLocaleLanguageCode()
        
        GoogleTranslateAPI.shared.getAvailableLanguages(targetLanguage: languageCode) { result in
            switch result {
            case .success(let languages):
                (self.tableViewHeaders, self.tableViewSource) = self.createTableData(languagesList: languages)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicatorView.stopAnimating()
                }
            case .failure(let error):
                print("Error occurred while retrieving list of languages:", error.localizedDescription)
            }
        }
    }
    
    private func setupView() {
        setButtonTitle()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        title = "SETTINGS_TRANSLATE_TO".localized
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.reloadData()
        
        view.addSubview(tableView)
        tableView.fillToSuperview()

        
        if isModal {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveBarButtonItem))
        } else {
            chooseButton.isHidden = true
        }
        
        view.addSubview(chooseButton)
        chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        chooseButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        chooseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        chooseButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        displayActivityIndicator()
    }
    
    @objc private func dismissViewController() {
        if isModal {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapSaveBarButtonItem() {
        dismissViewController()
    }
    
    func displayActivityIndicator() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.style = .white
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.startAnimating()
    }
    
    private func setButtonTitle() {
        let language = LanguagePreferences.getCurrent()
        let buttonTitle = "SAVE_LANGUAGE_NAME".localizedString(with: [language.name])
        chooseButton.setTitle(buttonTitle, for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
