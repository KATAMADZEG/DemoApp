//
//  MainPageViewModel.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 2/20/23.
//

import Foundation
import Combine


protocol MainPageViewModelInputs {
     func fetchData()
   
}

protocol MainPageViewModelOutputs {
    func response(data:[MainPageModel])
  
}
protocol MainPageViewModelType {
    var inputs: MainPageViewModelInputs { get }
    var outputs: MainPageViewModelOutputs? { get }
}

final class MainPageViewModel : MainPageViewModelType {
    
    var inputs: MainPageViewModelInputs {self}
    var outputs: MainPageViewModelOutputs?
    
    var mainPageModel = [MainPageModel]()
    var imageDetailModel = [[ImageDetailModel]]()
    
    private var cancellable = Set<AnyCancellable>()
    
}


//MARK: - MainPageViewModelInputs
extension MainPageViewModel : MainPageViewModelInputs {
    func fetchData() {
        PixabayService.shared.getDataForMainPge()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error \(error.localizedDescription)")

                case .finished:
                    print("finished")
                }
            }
    receiveValue: {  data in
        self.outputs?.response(data: data)
    }

    .store(in: &cancellable)
    }
}
