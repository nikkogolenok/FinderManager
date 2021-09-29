//
//  UserDefaultsManager.swift
//  FinderManager
//
//  Created by Никита Коголенок on 21.09.21.
//

import Foundation

enum UserDefaultsError: Error {
    case elementMissing
}

struct UserDefaultsManager {
    private let presentationModeKey = "presentationMode"
    static var shared = UserDefaultsManager()
    
    var presentationMode: PresentationMode {
        get {
            guard let userDefaultsString = UserDefaults.standard.string(forKey: presentationModeKey),
                  let selectedMode = PresentationMode(rawValue: userDefaultsString) else {
                return .tableView
            }
            
            return selectedMode
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: presentationModeKey)
        }
    }
    
    private init() { }
    
    func getSelectedMode() throws -> PresentationMode {
        guard let userDefaultsString = UserDefaults.standard.string(forKey: presentationModeKey),
              let selectedMode = PresentationMode(rawValue: userDefaultsString)
        else { throw UserDefaultsError.elementMissing }
        
        return selectedMode
    }
}
