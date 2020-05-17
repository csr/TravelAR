//
//  LanguagesController.swift
//  LanguageTranslationAR
//

import UIKit

class LanguagesController: UIViewController {
    
    var tableViewHeaders = [String]()
    var tableViewSource = [String: [Language]]()
    var activityIndicatorView = UIActivityIndicatorView()
    var selectedIndexPath: IndexPath?
    
    var selectedLanguage: Language? {
        didSet {
            guard let language = selectedLanguage else { return }
            LanguagePreferences.save(language: language)
            updateChooseLanguageButtonTitle()
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
    
    let chooseLanguageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveBarButtonItem))
        
        view.backgroundColor = .black
        // Make space for the choose language button at the bottom
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        
        setupTableView()
        setupChooseLanguageButton()
        displayActivityIndicator()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        title = "SETTINGS_TRANSLATE_TO".localized
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.reloadData()
        
        view.addSubview(tableView)
        tableView.fillToSuperview()
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
    
    private func setupChooseLanguageButton() {
        view.addSubview(chooseLanguageButton)
        chooseLanguageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        chooseLanguageButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        chooseLanguageButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        chooseLanguageButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        updateChooseLanguageButtonTitle()
    }
    
    private func updateChooseLanguageButtonTitle() {
        let language = LanguagePreferences.getCurrent()
        let buttonTitle = "SAVE_LANGUAGE_NAME".localizedString(with: [language.name])
        chooseLanguageButton.setTitle(buttonTitle, for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
