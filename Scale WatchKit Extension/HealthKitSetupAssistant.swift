
import HealthKit

class HealthKitSetupAssistant {
  
  private enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
  }
  
  class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
    
    //checks if healthkit is available on watch (always true)
    guard HKHealthStore.isHealthDataAvailable() else {
        
        completion(false, HealthkitSetupError.notAvailableOnDevice)
        return
    }
    
    //prepare data types that will interact with healthkit
    guard let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass) else {
        completion(false, HealthkitSetupError.dataTypeNotAvailable)
        return
    }
    
    //prepare list of data types that healthkit will read and write
    let healthKitTypesToWrite: Set<HKSampleType> = [bodyMass]
    let healthKitTypesToRead: Set<HKObjectType> = [bodyMass]
    
    //authorise healthkit
    HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) in
        completion(success, error)
    }
    
    
    
    
  }
}
