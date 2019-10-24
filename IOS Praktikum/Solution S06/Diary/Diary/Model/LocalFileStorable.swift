//
//  LocalFileStorable.swift
//  Diary
//
//  Created by Mehmet Baris Yaman on 13.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

// MARK: Imports
import Foundation

// MARK: - LocalFileStorable
protocol LocalFileStorable: Codable {
    static var fileName: String { get }
}

// MARK: Extension: LocalFileStorable: URL
extension LocalFileStorable {
    
    static var localStorageURL: URL {
        guard let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Can't access the document directory in the user's home directory.")
        }
        return documentsDirectory.appendingPathComponent(Self.fileName).appendingPathExtension("json")
    }
}

// MARK: Extension: LocalFileStorable: Load & Save
extension LocalFileStorable {
    
    static func loadFromFile() -> [Self] {
        do {
            let fileWrapper = try FileWrapper(url: Self.localStorageURL, options: .immediate)
            guard let data = fileWrapper.regularFileContents else {
                throw NSError()
            }
            
            return try JSONDecoder().decode([Self].self, from: data)
        } catch _ {
            print("Could not load \(Self.self)s, the Model uses an empty collection")
            return []
        }
    }
    
    static func saveToFile(_ collection: [Self]) {
        do {
            let data = try JSONEncoder().encode(collection)
            let jsonFileWrapper = FileWrapper(regularFileWithContents: data)
            try jsonFileWrapper.write(to: Self.localStorageURL, options: FileWrapper.WritingOptions.atomic, originalContentsURL: nil)
        } catch _ {
            print("Could not save \(Self.self)s")
        }
    }
}

// MARK: Extension: Array: Save
extension Array where Element: LocalFileStorable {
    func saveToFile() {
        Element.saveToFile(self)
    }
}
