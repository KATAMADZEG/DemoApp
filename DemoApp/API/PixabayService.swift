//
//  MainPageService.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 2/20/23.
//

import Foundation
import Combine

struct PixabayService {
    private let url = URLs()
    
    static let shared = PixabayService()
    
    
     func getDataForMainPge()->AnyPublisher<[MainPageModel],Error> {
        
         guard let url =  URL(string: url.main()) else {fatalError("Invalid Url")}
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: rresponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .map{$0.hits}
            .eraseToAnyPublisher()
    }
}

