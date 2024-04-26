//
//  Macros.swift
//  1 Week Learning
//
//  Created by Kardeiz Ryle on 1/24/24.
//

import Foundation

let DEFAULT_CHECKLIST_NAME = "Untitled"
let DEFAULT_CHECKLIST_PLACEHOLDER = "Checklist Name"
let DEFAULT_TASK_PLACEHOLDER = "Task Name"

public func encodeString(contentOrder: [String],content: [String:Bool]) -> String {
    var encodedString = ""
    for string in contentOrder {
        encodedString += string + "/" + String(content[string] ?? false) + "\n"
    }
    return encodedString
}



//ForEach(contOrder, id: \.self) { item in
//    @State var text: String = item
//    HStack {
//        Button {
//            cont[item]?.toggle()
//            let EncodedString = encodeString(contentOrder: contOrder, content: cont)
//            vm.updateChecklist(file_name: checklistName, content: EncodedString)
//        } label: {
//            Image(systemName: (cont[item] == false) ? "circle" : "circle.fill")
//                .resizable()
//                .padding(.horizontal)
//                .foregroundColor(.yellow)
//                .frame(width:65, height:35)
//        }
//        TextField (
//            DEFAULT_TASK_PLACEHOLDER,
//            text: $text
//        )
//        .onSubmit {
//            print(text)
//        }
//        .strikethrough((cont[item] == true))
//        .font(.title2)
//        Spacer()
//    }
//    .padding(.bottom,10)
//}
//HStack {
//    Image(systemName: "circle")
//        .resizable()
//        .padding(.horizontal)
//        .foregroundColor(.yellow)
//        .frame(width:65, height:35)
//
//    TextField (
//        DEFAULT_TASK_PLACEHOLDER,
//        text: $txt
//    )
//    .onSubmit {
//        print("new task with name \(txt)")
//        var found_repeat : Bool = false
//        for name in contOrder {
//            if name == txt {
//                found_repeat = true
//                break
//            }
//        }
//        if found_repeat {txt = ""; return} else {}
//        contOrder.append(txt)
//        cont[txt] = false
//        txt = ""
//        let EncodedString = encodeString(contentOrder: contOrder, content: cont)
//        vm.updateChecklist(file_name: checklistName, content: EncodedString)
//    }
//    .font(.title2)
//    Spacer()
//}
//.padding(.bottom,10)


