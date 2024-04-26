//
//  ContentView.swift
//  1 Week Learning
//
//  Created by Kardeiz Ryle on 1/22/24.
//

import SwiftUI
import SwiftData
import Foundation


struct ContentView: View {
    
    @StateObject var vm = FileManagerViewModel()
    @State var inNav = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.ChecklistNames, id: \.self) { name in
//
                    NavigationLink("\(fileNameStrip(fileName: name))") {
//                        let data = vm.returnContent(file_name: name)
                        ChecklistView(
                            checklistName: fileNameStrip(fileName: name)
                        )
                    }
                    
                }
                .onDelete(perform: { indexSet in
                    guard let index = indexSet.first else {return}
                    vm.remFile(file_name: vm.ChecklistNames[index])
                })
                .onDisappear {
                    inNav = true
                }
                .onAppear {
                    if inNav {
                        inNav = false
                    }
                }
            }
            .navigationTitle("Checklists")
            .toolbar {
                Button(action: newChecklist) {
                    Image(systemName: "plus")
                }
            }
        }
        
        if (inNav == true) {
            Button {
                vm.wipe()
            } label: {
                Text("Wipe Checklists")
            }
            .hidden()
        }
        else {
            Button {
                vm.wipe()
            } label: {
                Text("Wipe Checklists")
            }
        }
    }
    
    private func numberOfUntitledChecklists() -> Int {
        var n : Int = 0
        for name in vm.ChecklistNames {
            if (name.range(of: DEFAULT_CHECKLIST_NAME) != nil) {
                n+=1
            }
        }
        return n
    }
    
    private func newChecklist()  {
        let nb_of_untitled = numberOfUntitledChecklists()
        let subfix = (nb_of_untitled > 0) ? "\(nb_of_untitled)" : ""
        vm.newFile(file_name: DEFAULT_CHECKLIST_NAME+subfix)
    }
    
    private func fileNameStrip(fileName: String) -> String {
        return String(fileName.split(separator: ".txt")[0])
    }
}

#Preview {
    ContentView()
}
