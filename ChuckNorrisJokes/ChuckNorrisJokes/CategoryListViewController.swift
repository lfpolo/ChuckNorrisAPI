import UIKit
import RxSwift

class CategoryListViewController: UIViewController, UIScrollViewDelegate {
    let disposeBag = DisposeBag()
    var categoryList = [String]()
    var categoryListViewModel = CategoryListViewModel(chuckNorrisAPI: ChuckNorrisAPI())
    var categoryListView = CategoryListView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        self.view = categoryListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Categorias"
        self.categoryListViewModel.getCategoryList()
        self.bindToViewModel()
    }
    
    func bindToViewModel() {
        self.categoryListView.categoryListTableView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
                    
        self.categoryListViewModel.categoryListBehaviorRelay.asObservable()
            .bind(to: categoryListView.categoryListTableView.rx.items(cellIdentifier: "CategoryCell", cellType: CategoryTableViewCell.self)) { index, element, cell in
                cell.textLabel?.text = element.capitalized
            }.disposed(by: self.disposeBag)
        
        self.categoryListView.categoryListTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            let category : String? = (try? self?.categoryListView.categoryListTableView.rx.model(at: indexPath))
            if let category = category {
                let viewController = JokeViewController(jokeViewModel: JokeViewModel(chuckNorrisAPI: ChuckNorrisAPI(), category: category))
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }).disposed(by: self.disposeBag)
        
        self.categoryListViewModel.requestStatusBehaviorRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.categoryListView.activityIndicatorView.updateActivityIndicator(requestStatus: result)
                if result == .fail {
                    self?.requestError()
                }
            }).disposed(by: self.disposeBag)
    }

    func requestError() {
        let alertController = UIAlertController(title: "Erro", message: "Erro ao obter os dados.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
    }
}
