//
//  Step.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/27/21.
//

//file created to associate steps and date
import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
