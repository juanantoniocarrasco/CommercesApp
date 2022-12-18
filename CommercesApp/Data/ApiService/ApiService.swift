import Foundation

final class ApiService: ApiServiceProtocol {
    
    func getCommerces(completion: @escaping (Result<[Commerce], Error>) -> Void) {
        
//        let stringURL = "https://waylet-web-export.s3.eu-west-1.amazonaws.com/commerces.json"
        let stringURL = "https://raw.githubusercontent.com/juanantoniocarrasco/CommercesApp/main/apijson.json"

        guard let url = URL(string: stringURL) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                completion(.failure(error))
                return
            }
        
            guard
                let response = response as? HTTPURLResponse,
                let data
            else {
                return
            }
                        
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Commerce].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask.resume()
    }
}
