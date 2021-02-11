struct Joke : Decodable {
    let icon_url : String?
    let url : String?
    let value : String?
    let categories : [String]?
}

extension Joke {
    static var empty : Joke {
        return Joke(icon_url: nil, url: nil, value: nil, categories: nil)
    }
}
