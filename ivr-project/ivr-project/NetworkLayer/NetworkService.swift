//
//  NetworkService.swift
//  ivr-project
//
//  Created by Kim Irina on 11.10.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//
import Foundation

// 5 уровней доступа
// open
// public
// internal
// private
// fileprivate
private struct httpError: Error {
    
}

final class NetworkSerivce {
    private static let devkey = "dc7c3c00e5d4e49e4a3135b2cf1073e7"
    private static let vendor = "hselyceum"
    private static var schedule: String?
    private static var assesments: String?
    static var token: String?
    static var id: String?

    static func logIn(login: String, password: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        //TODO: Подумать как сделать без force unwrap
        var urlComponents = URLComponents(string: "https://api.eljur.ru/api/auth")!

        let items = [
            URLQueryItem(name: "login", value: login),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "vendor", value: vendor),
            URLQueryItem(name: "devKey", value: devkey),
            URLQueryItem(name: "out_format", value: "json")
        ]
        urlComponents.queryItems = items

        guard let url = urlComponents.url else {
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
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                    let error = httpError()
                    completionHandler(.failure(error))
                }
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

    static func schedule(student: String, days: String, rings: String, completionHandler: @escaping (Result<[SchoolDay], Error>) -> Void) {

        var urlComponents = URLComponents(string: "https://api.eljur.ru/api/getschedule")!

        guard let token = NetworkSerivce.token else {
            return
        }

        let items = [
            URLQueryItem(name: "auth_token", value: token),
            URLQueryItem(name: "vendor", value: vendor),
            URLQueryItem(name: "devKey", value: devkey),
            URLQueryItem(name: "student", value: student),
            URLQueryItem(name: "days", value: days),
            URLQueryItem(name: "rings", value: rings),
            URLQueryItem(name: "out_format", value: "json")
        ]
        urlComponents.queryItems = items

        guard let url = urlComponents.url else {
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
                            if let students = result["students"] as? [String: Any] {
                                if let students = students["49177"] as? [String: Any] {
                                    if let days = students["days"] as? [String: Any] {
                                        var schoolDays = [SchoolDay]()
                                        for day in days.values {
                                            if let day = day as? [String: Any] {
                                                let name = day["name"] as? String
                                                let title = day["title"] as? String
                                                var arrayOfClasses = [SchoolClass]()
                                                guard let items = day["items"] as? [String: [String: Any]] else {
                                                    print("ошибка при обработке items")
                                                    assertionFailure()
                                                    return
                                                }
                                                for item in items.values {
                                                    let schoolClass = self.parseItemInSchoolDay(dictionary: item)
                                                    print(schoolClass)
                                                    arrayOfClasses.append(schoolClass)
                                                }
                                                let schoolDay = SchoolDay(name: name, title: title, items: arrayOfClasses)
                                                schoolDays.append(schoolDay)
                                            }
                                        }
                                        completionHandler(.success(schoolDays))
                                    }
                                }
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

    private static func parseItemInSchoolDay(dictionary: [String: Any]) -> SchoolClass {
        let name = dictionary["name"] as? String
        let num = dictionary["num"] as? String
        let room = dictionary["room"] as? String
        let teacher = dictionary["teacher"] as? String
        let grp_short = dictionary["grp_short"] as? String
        let grp = dictionary["grp"] as? String
        let starttime = dictionary["starttime"] as? String
        let endtime = dictionary["endtime"] as? String

        return SchoolClass(name: name, num: num, room: room, teacher: teacher, grp_short: grp_short, grp: grp, starttime: starttime, endtime: endtime)
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
    
    
    static func id(login: String, password: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        //TODO: Подумать как сделать без force unwrap
        var urlComponents = URLComponents(string: "https://api.eljur.ru/api/getrules")!

        let items = [
            URLQueryItem(name: "login", value: login),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "vendor", value: vendor),
            URLQueryItem(name: "devKey", value: devkey),
            URLQueryItem(name: "out_format", value: "json")
        ]
        urlComponents.queryItems = items

        guard let url = urlComponents.url else {
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
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                    let error = httpError()
                    completionHandler(.failure(error))
                }
            }

            guard let data = data else {
                print("data error")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let response = json["response"] as? [String: Any] {
                        if let result = response["result"] as? [String: Any] {
                            if let id = result["name"] as? String {
                                print("id", id)
                                self.id = id
                                completionHandler(.success(id))
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


