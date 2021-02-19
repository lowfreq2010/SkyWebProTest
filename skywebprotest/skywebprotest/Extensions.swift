//
//  Extensions.swift
//  skywebprotest
//
//  Created by vns on 19.02.2021.
//

import Foundation

extension FileManager {
    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    public static func getTempDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
}


