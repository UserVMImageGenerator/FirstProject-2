import UIKit
//import JTMaterialSpinner

class LoadingViewController: UIViewController {
    
  //  @IBOutlet weak var spinnerView: JTMaterialSpinner!
    @IBOutlet weak var percentLabel: UILabel!
    
    var prompt: String = ""
    var image: UIImage?
    var apiService = APIServiceAI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        spinnerView.circleLayer.lineWidth = 2.0
//        spinnerView.circleLayer.strokeColor = UIColor(red: 0.31, green: 0.21, blue: 0.96, alpha: 1).cgColor
        if let image = image {
            if let resizedImage = image.resizeImage(targetSize: CGSize(width: 893, height: 1038)) {
                VisionRequester().detectFace(inputImage: resizedImage) { image in
                    if let decetedFaceImage = image {
                        APIServiceAI().generateEditedImage(from:  resizedImage, with: image!) { url in
                            if let url = url {
                                self.apiService.downloadImage(for: url) { image in
                    
                                    APIServiceAI().generateImageVariation(from: image!) { url in
                                        self.apiService.downloadImage(for: url!) { image  in
                                            //self.generateImageView.image
                                            AppCoordinator.shared.showGeneratedImageScreen(image: image!)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        AppCoordinator.shared.showAlertWith(title: "Face not detected", message: "Please choose photo with face")
                    }
                }
            }
        } else {
            loadImage(prompt: prompt)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        spinnerView.beginRefreshing()
//        if !UserDefaultsManager.shared.getIsAtemptEnable() && !UserDefaultsManager.shared.getIsAppRated() {
//            AppCoordinator.shared.showAppRate()
//        }
    }
    
    
    func loadImage(prompt: String) {
        apiService.fetchImageForPrompt(prompt) { [weak self] url in
            guard let self = self else {return}
            if let stringUrl = url {
                self.apiService.downloadImage(for: stringUrl) { image in
                    if let image = image {
                        AppCoordinator.shared.showGeneratedImageScreen(image: image)
                    }
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        AppCoordinator.shared.showAlertWith(title: title, message: message) {
            AppCoordinator.shared.backToMain()
        }
    }
}


