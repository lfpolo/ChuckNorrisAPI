import Foundation

class Decoder {
    func decode<T : Decodable>(type: T.Type, data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Erro ao decodificar os dados para o tipo:", type)
            return nil
        }
    }
}
   
