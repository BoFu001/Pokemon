//
//  BaseViewModel.swift
//  Pokemon
//
//  Created by BoFu on 01/04/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import Foundation

class BaseViewModel {
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoading?(isLoading)
        }
    }
    var updateLoading: ((_ isLoading: Bool) -> ())?
    var dataLoaded: ((_ success: Bool) -> ())?
}
