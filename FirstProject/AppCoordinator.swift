import UIKit

class AppCoordinator {
    
    static let shared = AppCoordinator()
    private init() {}
    
    var tabBar: UITabBarController?
    
    var window: UIWindow? {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
        return window
    }
    
    var navigationController: UINavigationController?
    
    
    func start() {
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        
        let navigationController = UINavigationController(rootViewController: rootVC )
        self.navigationController = navigationController
        
        window?.rootViewController = navigationController
    }
    
    func showAlertWith(title: String, message: String, complition: @escaping () -> Void = {} ){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okey", style: .default) { _ in
            complition()
        }
        ac.addAction(action)
        
        navigationController?.viewControllers.last?.present(ac, animated: true)
    }
    
    func showLoadingScreen(text: String) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        vc.prompt = text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showGeneratedImageScreen(image: UIImage) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GenerateViewController") as! GenerateViewController
        vc.generatedImage = image
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func backToMain() {
        navigationController?.popViewController(animated: true)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
