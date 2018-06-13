import UIKit

public class TopView: UIView {
		
    let verticalOffset: CGFloat = 6
    
    var selectedLanguage: Language? {
        didSet {
            if let language = selectedLanguage {
                translationLabel.text = language.name
            } else {
                print("Selected language is nil")
            }
        }
    }
    
	var identifierLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
		label.font = UIFont(name: "CircularStd-Book", size: 24)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
        label.text = NSLocalizedString("Scanning", comment: "Scanning environment")
		return label
	}()
    
    let translateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alpha = 0
        return stackView
    }()
    
    let translationLabel: UILabel = {
        let label = UILabel()
        label.text = "Languages"
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        label.font = UIFont(name: "CircularStd-Book", size: 13)
        return label
    }()
    
    let bookmarksStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alpha = 0
        return stackView
    }()
    
    let bookmarksButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon-bookmarks"), for: UIControlState.normal)
        return button
    }()
    
    let translationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon-translation"), for: UIControlState.normal)
        return button
    }()
    
    let leftStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupDescriptionLabel()
        setupBookmarksButton()
        setupTranslationButton()
        setupStackViews()
	}
    
    private func setupStackViews() {
        let rightStackView = UIStackView()
        rightStackView.spacing = 15
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightStackView)
        rightStackView.addArrangedSubview(translateStackView)
        rightStackView.addArrangedSubview(bookmarksStackView)
        rightStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: verticalOffset).isActive = true
        rightStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
    }
	
    private func setupBookmarksButton() {
        addSubview(bookmarksStackView)
        bookmarksStackView.addArrangedSubview(bookmarksButton)
        bookmarksButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        bookmarksButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let label = UILabel()
        addSubview(label)
        label.text = NSLocalizedString("Translations", comment: "")
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        label.font = UIFont(name: "CircularStd-Book", size: 13)
        addSubview(label)
        bookmarksStackView.addArrangedSubview(label)
    }
    
    private func setupTranslationButton() {
        addSubview(translateStackView)
        translateStackView.addArrangedSubview(translationButton)
        translationButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        translationButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        translateStackView.addArrangedSubview(translationLabel)
    }
    
    
    public func showRightIcons() {
        UIView.animate(withDuration: 1) {
            self.bookmarksStackView.alpha = 1
            self.translateStackView.alpha = 1
        }
    }
    
	public func animateBookmarks() {
		bookmarksButton.boingAnimation()
	}
	
	private func setupView() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .deepBlue
        layer.shadowOpacity = 0.2 // opacity, 20%
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2 // HALF of blur
        layer.shadowOffset = CGSize(width: 0, height: 2) // Spread x, y
	}
		
	private func setupDescriptionLabel() {
		let parentView = UIView()
		parentView.clipsToBounds = true
		parentView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(parentView)
		parentView.addSubview(identifierLabel)
		
		parentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		parentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		parentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.5).isActive = true
		parentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
		
		identifierLabel.rightAnchor.constraint(equalTo: parentView.rightAnchor).isActive = true
		identifierLabel.leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 1.2).isActive = true
        identifierLabel.centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: verticalOffset).isActive = true
    }
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

