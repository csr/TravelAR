import UIKit

public class DictionaryView: UIView {
	
    var item: Translation? {
        didSet {
            if let item = item {
                mainLabel.text = item.translatedText
                descriptionLabel.text = item.originalText
            }
        }
    }
    
	let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 5
		return stackView
	}()
	
	let mainLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "Title"
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
		label.font = UIFont(name: "CircularStd-Book", size: 25)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let descriptionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont(name: "CircularStd-Book", size: 16)
		label.translatesAutoresizingMaskIntoConstraints	= false
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupLabels()
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 3
        layer.borderColor = UIColor.deepBlue.cgColor
	}
	
	private func setupView() {
		backgroundColor = .white
		clipsToBounds = true
		layer.cornerRadius = 10
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupLabels() {
		addSubview(stackView)
		stackView.addArrangedSubview(mainLabel)
		stackView.addArrangedSubview(descriptionLabel)
		stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
		stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
		stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
