//
//  LanguagesController.swift
//  LanguageTranslationAR
//

import UIKit

struct Section {
    let letter: String
    let languages: [Language]
}

class LanguagesController: UIViewController {
    
    var languages = [Language]()
    var sections = [Section]()

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
        getLanguages()
        displayActivityIndicator()
    }
        
    func getLanguages() {
        let languageCode = LanguagePreferences.getLocaleLanguageCode()
        
        GoogleTranslateAPI.shared.getAvailableLanguages(targetLanguage: languageCode) { result in
            switch result {
            case .success(let languages):
                self.setupDataSource(with: languages)
            case .failure(let error):
                print("Error occurred while retrieving list of languages:", error.localizedDescription)
            }
        }
    }
    
    private func setupDataSource(with languages: [Language]) {
        self.languages = languages
        
        // Group the array to ["N": ["Nancy"], "S": ["Sue", "Sam"], "J": ["John", "James", "Jenna"], "E": ["Eric"]]
        let groupedDictionary = Dictionary(grouping: languages, by: {String($0.name.prefix(1))})
        
        // Get the keys and sort them
        let keys = groupedDictionary.keys.sorted()
        
        // Map the sorted keys to a struct
        self.sections = keys.map { Section(letter: $0, languages: groupedDictionary[$0]!.sorted()) }
        
        DispatchQueue.main.async {
            self.setupView()
        }
    }
    
    private func setupView() {
        self.setupTableView()
        self.tableView.reloadData()
        self.activityIndicatorView.stopAnimating()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveBarButtonItem))
        
        view.backgroundColor = .black
        // Make space for the choose language button at the bottom
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        
        setupChooseLanguageButton()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        title = "SETTINGS_TRANSLATE_TO".localized
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        
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
    
    func setupCell(cell: UITableViewCell, language: Language, indexPath: IndexPath) {
        cell.textLabel?.text = language.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.cell
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.selectedCell
        cell.selectedBackgroundView = bgColorView
        
        if LanguagePreferences.getCurrent() == language {
            selectedIndexPath = indexPath
        }
        
        cell.accessoryType = indexPath == selectedIndexPath ? .checkmark : .none
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension LanguagesController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let section = sections[indexPath.section]
        let language = section.languages[indexPath.row]
        setupCell(cell: cell, language: language, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = sections[section].languages.count
        return numberOfRowsInSection
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .black
            view.tintColor = UIColor.selectedCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let section = sections[indexPath.section]
        let language = section.languages[indexPath.row]
        self.selectedLanguage = language
        
        // First, delesect previous cell
        if let oldIndexPath = selectedIndexPath {
            let oldCell = tableView.cellForRow(at: oldIndexPath)
            oldCell?.accessoryType = .none
        }
        
        // Then, select current cell
        let newCell = tableView.cellForRow(at: indexPath)
        newCell?.accessoryType = .checkmark
        
        self.selectedIndexPath = indexPath
    }
}
