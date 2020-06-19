// Sasha Loghozinsky -- loghozinsky@gmail.com

import UIKit

extension UIViewController {}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupLayout()
    }
    
    private func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .gitHubBasicColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.gitHubWhiteColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.gitHubWhiteColor]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .gitHubBasicColor
            navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .gitHubWhiteColor
    }
    
}
