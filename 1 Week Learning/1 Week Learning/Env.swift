//
//  Env.swift
//  1 Week Learning
//
//  Created by Kardeiz Ryle on 1/27/24.
//

import Foundation

//class Env: ObservableObject {
//    
//    @Published var current_contOrder: [String]
//    @Published var current_cont: [String:Bool]
//    @Published var current_checklistName: String = "None"
//    
//    init(name: String, vm: FileManagerViewModel) {
//        self.vm = vm
//        let data = vm.returnContent(file_name: name)
//        self.current_cont = data.cont
//        self.current_contOrder = data.contOrd
//    }
//    
//    func updateChecklistName(checklistName: String) {
//        self.current_checklistName = checklistName
//    }
//    
//    func printTime() {
//        print("TEST!")
//    }
//    
//    func updateChecklistInfo(contOrder: [String], cont: [String:Bool]) {
//        print("Before update")
//        print(self.current_contOrder)
//        print(self.current_cont)
//        self.current_contOrder = contOrder
//        self.current_cont = cont
//        print("After update")
//        print(self.current_contOrder)
//        print(self.current_cont)
//    }
//    
//}
