protocol ApiServiceProtocol {
    func getCommerces(completion: @escaping (Result<[Commerce], Error>) -> Void)
}

