//
//  ApiManager.swift
//  CurrencyConversion
//
//  Created by Mahmoud Mohamed Atrees on 24/08/2023.
//

import Foundation
import RxSwift

protocol fetchData{
    func getData<T: Decodable>(modelDTO: T.Type ,_ endpoint: Endpoints, attributes: [String: String]?) -> Observable<T>
}

enum Endpoints {
    case getExchangeRate
    case getAllCurrencies
    case getAllCurrenciesData
    case convertCurrency(from: String, to: String, amount: String)
    case compareCurrencies(from: String, amount: String, toFirst: String, toSecond: String)

    var stringUrl: URL {
        
        switch self {
        case .getExchangeRate:
            return URL(string: "https://v6.exchangerate-api.com/v6/ecf10bab01b34bf0de9636e1/latest/USD")!
        case .getAllCurrencies:
            return URL(string: "http://16.171.161.38/api/v1")!
        case .getAllCurrenciesData:
            return URL(string: "http://51.20.8.87/api/v1")!
        case .convertCurrency(let from, let to, let amount):
            return URL(string: "http://51.20.8.87/api/" + "v2/conversion?from=\(from)&to=\(to)&amount=\(amount)")!
        case .compareCurrencies(let from, let amount, let toFirst, let toSecond):
            return URL(string: "http://www.amrcurrencyconversion.site/api/v2/comparison?from=\(from)&amount=\(amount)&list=\(toFirst),\(toSecond)")!
            
        }
    }
}

class ApiClient {
    
    private static let sharedInstance = ApiClient()

        static func shared() -> ApiClient {
            return ApiClient.sharedInstance
        }
        private init() {}
    
    func getData<T>(modelDTO: T.Type ,_ endpoint: Endpoints) -> Observable<T> where T : Decodable {
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: endpoint.stringUrl) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let exchangeRate = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(exchangeRate)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}


