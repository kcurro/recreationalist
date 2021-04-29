//
//  HealthStore.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/27/21.
//

import Foundation
import HealthKit

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func calculateSteps(completion: @escaping(HKStatisticsCollection?) -> Void){
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        //start date retrieving a week of step counts but only want current day
        //might have to change later on for now leave as it is
        let startDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        
        //what time day actually starts, this is anchor date
        //day starts at 12am
        let anchorDate = Date.mondayAt12AM()
        
        //interested in calculating daily
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        //cumulative sum means that calculate all devices
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        //gets fired whenever query is executed
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        //execute query 
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
        
        
    }
    
    func requestAuthorization(completion: @escaping (Bool)-> Void){
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
            completion(success)
        }
    }
    
}
