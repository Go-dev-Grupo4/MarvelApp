//
//  EventListService.swift
//  Marvel
//
//  Created by Matheus Lenke on 30/03/22.
//

import Foundation

class EventListService: EventListServiceProtocol {
  
    let session = URLSession.shared
    
    func execute(heroId: Int, handler: @escaping (Result<Hero, HeroError>) -> Void) {
        let request: Request = .events
        
        if var baseUrl = URLComponents(string: "\(request.baseURL)/\(heroId)/\(request.path)") {
           
            baseUrl.query = request.queryParams
            
            guard let url = baseUrl.url else { return }
            
            var requestUrl = URLRequest(url: url)
            requestUrl.httpMethod = request.method.name
            
            let dataTask = session.dataTask(with: requestUrl) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                if httpResponse.statusCode == 200 {
                    
                    do {
                        guard let jsonData = data else { return handler(.failure(.noProcessData)) }
                        
                        let decoder = JSONDecoder()
                        
                        let responseData = try decoder.decode(Hero.self, from: jsonData)
                        
                        handler(.success(responseData))
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                    
                } else if httpResponse.statusCode == 409 {
                    handler(.failure(.urlInvalid))
                }
            }
            
            dataTask.resume()
        }
    }
}
