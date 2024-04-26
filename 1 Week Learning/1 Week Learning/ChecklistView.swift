//
//  ChecklistView.swift
//  1 Week Learning
//
//  Created by Kardeiz Ryle on 1/22/24.
//

import SwiftUI
import SwiftData
import Foundation

struct ChecklistView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    @FocusState private var isFocused: Bool
    @State private(set) var checklistName: String
    @State var inEditMode: Bool = false
    @State var old_checklistName: String = ""
    
    var body: some View {
        let data = vm.returnContent(file_name: checklistName)
        @State var contOrder : [String] = data.contOrd
        @State var cont: [String:Bool] = data.cont
        
        
        NavigationStack {
            // TOP DISPLAY
            VStack {
                HStack {
                    if !inEditMode {
                        Text(checklistName)
                            .padding([.leading, .top],20)
                            .font(.largeTitle)
                        Spacer()
                    } else {
                        //              Text Filed for Edit Mode
                        TextField (
                            DEFAULT_CHECKLIST_PLACEHOLDER,
                            text: $checklistName,
                            onEditingChanged: { changed in
                                print("!")
                            }
                        )
                        .padding([.leading, .top],20)
                        .disableAutocorrection(true)
                        .onSubmit {
                            // HERE WILL BE THE File Creation SAVE
                            if (checklistName != old_checklistName) {
                                print("Checklist Name: ", checklistName)
                            }
                        }
                        .font(.largeTitle)
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        inEditMode.toggle()
                    } label: {
                        Text((!inEditMode) ? "Edit": "Done")
                    }
                }
                
            }
            .padding(.top, 0)
            // Displaying your Checklist
            ScrollView {
                if !inEditMode {
                    NormalViewModel(vm: vm, contOrder: contOrder, cont: cont, checklistName: checklistName)
                } else {
                    EditModeViewModel(vm: vm, checklistName: checklistName, contOrder: contOrder, cont: cont)
                }
            }
            .padding(.all,0)
        }
        .padding(.horizontal,3)
        .padding(.top,-50)
    }
    
    private func copyArray(target_array: [String]) -> [String] {
        var array : [String] = []
        for element in target_array {
            array.append(element)
        }
        return array
    }
    
}

//, contentOrder: ["Give Ryle His Money","Give Ryan his food"], content: ["Give Ryle His Money": true, "Give Ryan his food": false]


struct NormalViewModel: View {
    
    @ObservedObject var vm: FileManagerViewModel
    
    @State var contOrder : [String]
    @State var cont: [String:Bool]
    @State var txt: String = ""
    var checklistName: String
    
    var body: some View {
        ScrollView {
            // Tasks Display
            ForEach(contOrder, id: \.self) { taskName in
                HStack {
                    Button {
                        // update task
                        cont[taskName] = !cont[taskName]!
                        let encodedString = encodeString(contentOrder: contOrder, content: cont)
                        vm.updateChecklist(file_name: checklistName, content: encodedString)
                    } label: {
                        Image(systemName: cont[taskName]! ? "circle.fill": "circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.yellow)
                    }
                    Text(taskName)
                    .font(.title2)
                    Spacer()
                }.padding(.horizontal)
            }
            
            // Adding New Task Part
            HStack {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.yellow)
                    
                TextField(
                    DEFAULT_TASK_PLACEHOLDER,
                    text: $txt
                )
                .onSubmit{
                    sub()
                }
                .font(.title2)
            }.padding(.horizontal)
        }
    }
    
    private func alr_in_list() -> Bool {
        for task_name in contOrder {
            if task_name == txt {
                return true
            }
        }
        return false
    }
    
    
    private func sub() {
        if txt.isEmpty { print("empty text field"); return}
        
        // Anti Repeating Detect
        if alr_in_list() {
            txt=""
            return
        }
        
        // adding task to checklist
        contOrder.append(txt)
        cont[txt] = false
        print(contOrder,cont)
        txt=""
        
        // Updating checklist data
        let encodedString = encodeString(contentOrder: contOrder, content: cont)
        vm.updateChecklist(file_name: checklistName, content: encodedString)
    }
    
}

struct EditModeViewModel: View {
    @ObservedObject var vm: FileManagerViewModel
    var checklistName : String
    @State var contOrder : [String]
    @State var cont: [String:Bool]
    
    var body: some View {
        ScrollView {
            ForEach(Array(contOrder.indices), id: \.self) { i in
                HStack {
                    Image(systemName: "circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)
                    TextField(DEFAULT_TASK_PLACEHOLDER, text: $contOrder[i])
                        .font(.title2)
                        .onSubmit {
                            let encodedString = encodeString(contentOrder: contOrder, content: cont)
                            vm.updateChecklist(file_name: checklistName, content: encodedString)
                        }
                    Spacer()
                }
            }.padding(.all)
        }
    }
}


#Preview {
    ChecklistView(checklistName: "Untitled")
}
