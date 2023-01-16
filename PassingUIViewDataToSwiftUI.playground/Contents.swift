//
//  PassingUIViewDataToSwiftUI.playground
//  PassingUIViewDataToSwiftUI
//
//  Created by Minyoung Yoo on 2023/01/16.
//
//  Simple example for passing UIViewRepresentable's data to SwiftUI View.

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State var passingText : String = "UITextField value will appear here."
    var body: some View {
        VStack {
            Text("SwiftUI Text : \(passingText)")
            UITextFieldObject(passingText: $passingText, placeholder: "This is UITextField object.")
        }
        .padding()
    }
}

struct UITextFieldObject : UIViewRepresentable {
    @Binding var passingText : String
    let placeholder : String

    func makeUIView(context: Context) -> UITextField {
        let textFieldObject = createTextField(placeholder: placeholder)
        textFieldObject.delegate = context.coordinator
        return textFieldObject
    }

    func createTextField(placeholder: String)->UITextField{
        let customPlaceholder : String = placeholder
        let textField = UITextField()
        textField.placeholder = customPlaceholder
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        return textField
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(passingText: $passingText)
    }

    class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var passingText : String

        init(passingText: Binding<String>) {
            self._passingText = passingText
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            passingText = textField.text ?? ""
        }
    }
}

let view = ContentView()
let hostingVC = UIHostingController(rootView: view)

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = hostingVC
