import RxSwift
import RxCocoa

class CategoryListViewModel {
    
    var categoryListBehaviorRelay = BehaviorRelay<[String]>(value: [])
    var requestStatusBehaviorRelay = BehaviorRelay<RequestResult>(value: .none)
    let disposeBag = DisposeBag()
    var chuckNorrisAPI : ChuckNorrisAPI
    
    init(chuckNorrisAPI : ChuckNorrisAPI) {
        self.chuckNorrisAPI = chuckNorrisAPI
    }
    
    func getCategoryList() {
        self.requestStatusBehaviorRelay.accept(.waiting)
        self.chuckNorrisAPI.getCategoryList()
            .subscribe(onNext: { response in
                self.requestStatusBehaviorRelay.accept(.success)
                self.categoryListBehaviorRelay.accept(response)
            }, onError: { error in
                self.requestStatusBehaviorRelay.accept(.fail)
            }).disposed(by: self.disposeBag)
    }
}
