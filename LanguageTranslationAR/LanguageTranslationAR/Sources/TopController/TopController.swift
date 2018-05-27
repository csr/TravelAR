import UIKit

public class TopController: UIViewController {
    
    let kTopViewHeight: CGFloat = 95
    
    var topViewTopAnchor: NSLayoutConstraint?
    
    var shouldShowTopView = false {
        didSet {
            if shouldShowTopView {
                topView.alpha = 1
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction], animations: {
                    self.topViewTopAnchor?.constant = 0
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    let topView = TopView()
			
    public override func viewDidLoad() {
        super.viewDidLoad()
		setupTopView()
    }
	
    private func setupTopView() {
        view.addSubview(topView)
        topView.layer.zPosition = .greatestFiniteMagnitude
        topViewTopAnchor = topView.topAnchor.constraint(equalTo: view.topAnchor, constant: -kTopViewHeight)
        topViewTopAnchor?.isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: kTopViewHeight).isActive = true
    }
    
	public override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}
