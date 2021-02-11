@testable import ChuckNorrisJokes
import RxSwift
import RxCocoa

class ChuckNorrisAPIMockSuccess : ChuckNorrisAPI {
    override func getCategoryList() -> Observable<[String]> {
        return Observable.just(["food", "dev", "fashion"])
    }
    
    override func getJoke(category: String) -> Observable<Joke> {
        return Observable.just(Joke(icon_url: "iconURL", url: "URL", value: "joke...", categories: [category]))
    }
}

class ChuckNorrisAPIMockFailure : ChuckNorrisAPI {
    override func getCategoryList() -> Observable<[String]> {
        return Observable.create({ observer in
            observer.onError(RxCocoaURLError.httpRequestFailed(response: HTTPURLResponse(), data: Data()))
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    override func getJoke(category: String) -> Observable<Joke> {
        return Observable.create({ observer in
            observer.onError(RxCocoaURLError.httpRequestFailed(response: HTTPURLResponse(), data: Data()))
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
