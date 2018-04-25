import UIKit

public class TopView: UIView {
		
    let verticalOffset: CGFloat = 6
    
    var selectedLanguage: Language? {
        didSet {
            guard let language = selectedLanguage else { return }
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                languageLabel.text = language.getDescription()
            } else {
                languageLabel.text = String(language.emoji)
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
        label.text = "Scanning..."
		return label
	}()
    
    var languageLabel: UILabel = {
        let label = UILabel()
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        label.font = UIFont(name: "CircularStd-Book", size: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()
    
    let bookmarksButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon-bookmarks"), for: .normal)
        button.alpha = 0
        return button
    }()
    
    let translationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon-translation"), for: .normal)
        button.alpha = 0
        return button
    }()
    
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupDescriptionLabel()
        setupBookmarksButton()
        setupTranslationButton()
	}
	
    private func setupBookmarksButton() {
        addSubview(bookmarksButton)
        bookmarksButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: verticalOffset).isActive = true
        bookmarksButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        bookmarksButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        bookmarksButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupTranslationButton() {
        addSubview(translationButton)
        translationButton.centerYAnchor.constraint(equalTo: identifierLabel.centerYAnchor).isActive = true
        translationButton.rightAnchor.constraint(equalTo: bookmarksButton.leftAnchor, constant: -16.5).isActive = true
        translationButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        translationButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        addSubview(languageLabel)
        languageLabel.centerYAnchor.constraint(equalTo: identifierLabel.centerYAnchor).isActive = true
        languageLabel.rightAnchor.constraint(equalTo: translationButton.leftAnchor, constant: -20).isActive = true
    }
    
    public func showRightIcons() {
        UIView.animate(withDuration: 1) {
            self.bookmarksButton.alpha = 1
            self.translationButton.alpha = 1
            self.languageLabel.alpha = 1
        }
    }
    
	public func animateBookmarks() {
		bookmarksButton.boingAnimation()
	}
	
	private func setupView() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = #colorLiteral(red: 0.2769357264, green: 0.7137418389, blue: 0.9510393739, alpha: 1)
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

