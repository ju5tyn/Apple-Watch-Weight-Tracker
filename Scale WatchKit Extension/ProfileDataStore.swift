//
//  ProfileDataStore.swift
//  Scale WatchKit Extension
//
//  Created by Justyn Henman on 29/09/2020.
//  Copyright © 2020 Justyn Henman. All rights reserved.
//

import HealthKit

class ProfileDataStore {
    
    
    
    
    
    class func getCurrentBodyMass(for sampleType: HKSampleType, completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
        
        let currentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: currentPredicate, limit: limit, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            DispatchQueue.main.async {
                guard let samples = samples,
                    let currentSample = samples.first as? HKQuantitySample else{
                        completion(nil, error)
                        return
                }
                
                completion(currentSample, nil)
            }
            
            
        }
        
        
        HKHealthStore().execute(sampleQuery)
    }
    
    
}
