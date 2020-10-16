//
//  NetworkService.swift
//  ivr-project
//
//  Created by Kim Irina on 11.10.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//
import Foundation

final class NetworkSerivce {
    private static let devkey = "dc7c3c00e5d4e49e4a3135b2cf1073e7"
    private static let vendor = "hselyceum"
    private static var token: String?
    private static var schedule: String?

    static func logIn(login: String, password: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        // TODO: Сделать через queryItems
        guard let url = URL(string: "https://api.eljur.ru/api/auth?login=\(login)&password=\(password)&vendor=\(vendor)&devkey=\(devkey)&out_format=json") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("http error", error?.localizedDescription)
                completionHandler(.failure(error!))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("http status code", httpResponse.statusCode)
            }

            guard let data = data else {
                print("data error")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let response = json["response"] as? [String: Any] {
                        if let result = response["result"] as? [String: Any] {
                            if let token = result["token"] as? String {
                                print("ТОКЕН", token)
                                self.token = token
                                completionHandler(.success(token))
                            }
                        }
                    }
                }
            }
            catch {
                print("JSON Serialization error!")
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    static func schedule(login: String, password: String, student: String, days: String, clas: String, rings: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        // TODO: Сделать через queryItems
        guard let url = URL(string: "https://api.eljur.ru/api/getschedule?student=\(student)&days=\(days)&class=\(clas)&rings=\(rings)&vendor=\(vendor)&devkey=\(devkey)&login=\(login)&password=\(password)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("http error", error?.localizedDescription)
                completionHandler(.failure(error!))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("http status code", httpResponse.statusCode)
            }

            guard let data = data else {
                print("data error")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let response = json["response"] as? [String: Any] {
                        if let result = response["result"] as? [String: Any] {
                            if let schedule = result["schedule"] as? String {
                                print("Расписание", schedule)
                                self.schedule = schedule
                                completionHandler(.success(schedule))
                            }
                        }
                    }
                }
            }
            catch {
                print("JSON Serialization error!")
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    static func assesments(login: String, password: String, student: String, days: String,  completionHandler: @escaping (Result<String, Error>) -> Void) {
        // TODO: Сделать через queryItems
        guard let url = URL(string: "https://api.eljur.ru/api/getassessments?student=\(student)&days=\(days)&vendor=\(vendor)&devkey=\(devkey)&login=\(login)&password=\(password)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("http error", error?.localizedDescription)
                completionHandler(.failure(error!))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("http status code", httpResponse.statusCode)
            }

            guard let data = data else {
                print("data error")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let response = json["response"] as? [String: Any] {
                        if let result = response["result"] as? [String: Any] {
                            if let assesments = result["assesments"] as? String {
                                print("Оценки", assesments)
                                self.assesments = assesments
                                completionHandler(.success(assesments))
                            }
                        }
                    }
                }
            }
            catch {
                print("JSON Serialization error!")
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    

}

