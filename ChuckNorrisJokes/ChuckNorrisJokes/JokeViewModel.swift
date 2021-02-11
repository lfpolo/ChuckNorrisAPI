import RxSwift
import RxCocoa
import Foundation

class JokeViewModel {
    
    var jokeBehaviorRelay = BehaviorRelay<Joke>(value: Joke.empty)
    let jokeIconBehaviorRelay = BehaviorRelay<UIImage?>(value: nil)
    var requestStatusBehaviorRelay = BehaviorRelay<RequestResult>(value: .none)
    let disposeBag = DisposeBag()
    let chuckNorrisAPI : ChuckNorrisAPI
    
    var jokeValue : Observable<String>
    var category : BehaviorRelay<String>
    
    init(chuckNorrisAPI: ChuckNorrisAPI, category : String) {
        self.chuckNorrisAPI = chuckNorrisAPI
        self.category = BehaviorRelay<String>(value: category)
        self.jokeValue = jokeBehaviorRelay.map { ($0.value ?? "") }
        self.getJoke()
    }
    
    func getJoke() {
        self.requestStatusBehaviorRelay.accept(.waiting)
        self.chuckNorrisAPI.getJoke(category: self.category.value)
            .subscribe(onNext: { response in
                self.requestStatusBehaviorRelay.accept(.success)
                self.jokeBehaviorRelay.accept(response)
                self.getJokeIcon(iconURL: response.icon_url)
            }, onError: { error in
                self.requestStatusBehaviorRelay.accept(.fail)
            }).disposed(by: self.disposeBag)
    }
    
    func getJokeIcon(iconURL : String?) {
        if let image = UIImage.loadImageFromCache(imageIdentifier: iconURL) {
            self.jokeIconBehaviorRelay.accept(image)
        } else if let imageUrl = URL(string: iconURL ?? "") {
            URLRequest.loadData(url: imageUrl)
                .subscribe(onNext: { data in
                    if let image = UIImage(data: data) {
                        UIImage.saveImageOnCache(imageIdentifier: iconURL, image: image)
                        self.jokeIconBehaviorRelay.accept(image)
                    } else {
                        self.jokeIconBehaviorRelay.accept(self.chuckNorrisAPI.defaultIcon)
                    }
                }, onError: { _ in
                    self.jokeIconBehaviorRelay.accept(self.chuckNorrisAPI.defaultIcon)
                }).disposed(by: self.disposeBag)
        }
    }
}
