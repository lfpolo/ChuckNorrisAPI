import RxSwift
import RxCocoa
import Foundation

extension URLRequest {
    static func loadData(url : URL) -> Observable<Data> {
        return Observable.just(url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: URLRequest(url: url))
            }.map { response, data -> Data in
                if 200..<300 ~= response.statusCode {
                    return data
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }.asObservable()
    }
}
