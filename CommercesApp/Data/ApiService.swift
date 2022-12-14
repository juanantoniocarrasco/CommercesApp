import Foundation

final class ApiService: ApiServiceProtocol {
    
    func getCommerces(completion: @escaping (Result<[Commerce], Error>) -> Void) {
        
        let stringURL = "https://waylet-web-export.s3.eu-west-1.amazonaws.com/commerces.json"

        guard let url = URL(string: stringURL) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data else {
                print("Empty Data")
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
