import UIKit
import RxSwift
import RxCocoa

class JokeViewController : UIViewController {
    var jokeViewModel : JokeViewModel
    let disposeBag = DisposeBag()
    var jokeView = JokeView(frame: UIScreen.main.bounds)
    
    init(jokeViewModel : JokeViewModel) {
        self.jokeViewModel = jokeViewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.jokeView
    }
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action:  #selector(didTapShareButton))
        self.jokeView.openWebViewButton.addTarget(self, action: #selector(didTapOpenWebView), for: .touchUpInside)
        
        self.bindToViewModel()
    }
    
    func bindToViewModel() {
        self.jokeViewModel.category
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.navigationItem.title = value.capitalized
            }).disposed(by: self.disposeBag)
        
        self.jokeViewModel.jokeIconBehaviorRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.jokeView.jokeIconImage.image = value
            }).disposed(by: self.disposeBag)

        self.jokeViewModel.jokeValue
            .bind(to: self.jokeView.jokeValueLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.jokeViewModel.requestStatusBehaviorRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.jokeView.openWebViewButton.isHidden = result != .success
                self?.jokeView.activityIndicatorView.updateActivityIndicator(requestStatus: result)
                if result == .fail {
                    self?.requestError()
                }
            }).disposed(by: self.disposeBag)
    }
    
    @objc func didTapOpenWebView() {
        if let jokeURL = self.jokeViewModel.jokeBehaviorRelay.value.url, let url = URL(string: jokeURL) {
            let viewController = JokeWebViewController(url: url)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func didTapShareButton() {
        let activityViewController = UIActivityViewController(activityItems: [self.jokeViewModel.jokeBehaviorRelay.value.value as Any], applicationActivities: [])

        if let popoverController = activityViewController.popoverPresentationController {
          popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
          popoverController.sourceView = self.view
          popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }

        self.present(activityViewController, animated: true)
    }
    
    func requestError() {
        let alertController = UIAlertController(title: "Erro", message: "Erro ao obter os dados.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
    }
}
