//
//  Note.swift
//  N
//
//  Created by Andrei Korikov on 04.11.2021.
//

import Foundation

class Note: Codable {
    var text = ""
    var date = Date()
    var title: String {
        if let titleEnd = text.firstIndex(of: "\n") {
            return String(text.prefix(upTo: titleEnd))
        } else {
            return text
        }
    }
}

class NoteValue: Codable {
    var notes = [Note]()
    
    static let dataFileName = "notes.json"
    
    init(notes: [Note]) {
        self.notes = notes
    }
    
    func loadData() {
        let loadURL = getDocumentsDirectory().appendingPathComponent(Self.dataFileName)
        
        do {
            let data = try Data(contentsOf: loadURL)
            notes = try JSONDecoder().decode([Note].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveData() {
        let saveURL = getDocumentsDirectory().appendingPathComponent(Self.dataFileName)
        
        do {
            let encoded = try JSONEncoder().encode(notes)
            try encoded.write(to: saveURL, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
}
