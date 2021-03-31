//
//  AppState.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/30/21.
//

//import Foundation
import Combine

class AppState: ObservableObject {
    @Published var selectedOption: Tab = .site
}
