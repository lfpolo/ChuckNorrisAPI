import RxCocoa
import RxSwift
import Foundation

class ChuckNorrisAPI {
    let defaultIcon = UIImage(named: "download")
    let url = "https://api.chucknorris.io/jokes/"
    
    func getCategoryListEndpoint() -> String {
        return self.url + "categories"
    }
    
    func getRandomJokeEndpoint(category: String) -> String {
        return self.url + "/random?category=" + category
    }

    func getCategoryList() -> Observable<[String]> {
        guard let url = URL(string: self.getCategoryListEndpoint()) else {
            return Observable.just([String]())
        }
        
        return URLRequest.loadData(url: url).asObservable()
            .map({ data -> [String] in
                return Decoder().decode(type: [String].self, data: data) ?? []
            })
    }
    
    func getJoke(category : String) -> Observable<Joke> {
        guard let url = URL(string: self.getRandomJokeEndpoint(category: category)) else {
            return Observable.just(Joke.empty)
        }
        
        return URLRequest.loadData(url: url).asObservable()
            .map({ data -> Joke in
                return Decoder().decode(type: Joke.self, data: data) ?? Joke.empty
            })
    }
}
