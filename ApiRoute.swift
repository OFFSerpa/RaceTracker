//
//  ApiRoute.swift
//  TimeChamps
//
//  Created by Vinicius Serpa on 25/05/25.
//

import Foundation
import CoreLocation

class ApiRoute {

    func postRoute(_ route: Route) {
        guard let url = URL(string: "https://springboot-api-routes.onrender.com/routes/upload") else {
            print("URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let postableRoute = RoutePost(from: route)

        do {
            let jsonData = try JSONEncoder().encode(postableRoute)
            request.httpBody = jsonData
        } catch {
            print("Erro ao serializar rota: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro ao enviar rota: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Sucess! Status: \(response.statusCode)")
            }
        }
    }
}

extension ApiRoute {
        func deleteRoute(named name: String) {
            guard let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                  let url = URL(string: "https://springboot-api-routes.onrender.com/routes/1") else {
                print("URL inválida para DELETE")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Erro ao deletar rota: \(error)")
                    return
                }

                if let response = response as? HTTPURLResponse {
                    print("DELETE executado. Status: \(response.statusCode)")
                }
            }
        }
}
