//
//  FileManaging.swift
//  1 Week Learning
//
//  Created by Kardeiz Ryle on 1/24/24.
//

import Foundation

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func getChecklistNames() -> [String] {
        var DATA: [String] = []
        do {
            let documentsUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let fileUrls = try FileManager.default.contentsOfDirectory(at: documentsUrls, includingPropertiesForKeys: nil)
            
            DATA = fileUrls.map({$0.lastPathComponent})
        } catch {
            print("Failed to return checklistDATA")
        }
        
        return DATA
    }
    
    
    func createFile(name: String) {
        let documentsUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileUrl = documentsUrls.appendingPathComponent(name)
        
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            FileManager.default.createFile(atPath: fileUrl.path, contents: nil)
        }
        else {
            print("File already exists")
        }
    }
    
    func updateFileData(file_name: String, content: String) {
        let documentsUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileUrl = documentsUrls.appendingPathComponent(file_name)
        guard let data = content.data(using: .utf8) else {return}
        
        do {
            try data.write(to: fileUrl)
        } catch let error {
            print("Failed to update data to file. \(error)")
        }
    }
    
    func deleteFile(name: String) {
        
        let documentsUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileUrl = documentsUrls.appendingPathComponent(name)
        
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            do {
                try FileManager.default.removeItem(atPath: fileUrl.path)
            } catch {
                print("Failed to Deleted File: \(name)")
            }
        }
        else {
            print("File does not exists")
        }
    }
    
    func wipeFiles() {
        do {
            let documentsUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let fileUrls = try FileManager.default.contentsOfDirectory(at: documentsUrls, includingPropertiesForKeys: nil)
            
            
            for URL in fileUrls {
                deleteFile(name: URL.lastPathComponent)
            }
            print("wiped all files")
        } catch {
            print("Failed to wiped all files")
        }
    }
    
    func readFile(file_name: String) -> String {
        let documentsUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileUrl = documentsUrls.appendingPathComponent(file_name)
        
        if FileManager.default.isReadableFile(atPath: fileUrl.path) {
            do {
                let ContentString = try String(contentsOf: fileUrl)
                return ContentString
            } catch let error {
                print("Failed to read file data. \(error)")
            }
        }
        
        return ""
    }
    
}

class FileManagerViewModel: ObservableObject {
    
    @Published var ChecklistNames: [String] = []
    let manager = LocalFileManager.instance
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        ChecklistNames = manager.getChecklistNames().sorted(by: { (str1, str2) -> Bool in
            return (str1.lowercased()).compare(str2.lowercased(), options: .numeric) == .orderedAscending
        })
    }
    
    func saveData() {
        
    }
    
    func updateChecklist(file_name: String,content: String) {
        manager.updateFileData(file_name: file_name, content: content)
    }
    
    func remFile(file_name: String) {
        manager.deleteFile(name: file_name)
        fetchData()
    }
    
    func newFile(file_name: String) {
        manager.createFile(name: file_name)
        fetchData()
    }
    
    func returnContent(file_name: String) -> (contOrd: [String], cont: [String:Bool])  {
        var ContentOrder : [String] = []
        var Content: [String:Bool] = [:]
        let decodedString = manager.readFile(file_name: file_name)
        
        let LineSplit = decodedString.split(separator: "\n")
        for line in LineSplit {
            let taskName_taskValue = line.split(separator: "/")
            ContentOrder.append(String(taskName_taskValue[0]))
            Content[String(taskName_taskValue[0])] = Bool(String(taskName_taskValue[1]))
        }
        
        return (ContentOrder, Content)
    }
    
    func changeChecklistName(file_name: String, new_name: String) {
        let contentString = manager.readFile(file_name: file_name)
        manager.deleteFile(name: file_name)
        manager.createFile(name: new_name)
        manager.updateFileData(file_name: new_name, content: contentString)
    }
    
    func wipe() {
        manager.wipeFiles()
        fetchData()
    }
    
}
