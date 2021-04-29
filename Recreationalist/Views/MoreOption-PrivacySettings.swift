//
//  MoreOption-PrivacySettings.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/25/21.
//

import SwiftUI

struct MoreOption_PrivacySettings: View {
    //MARK: -PROPERTIES
    @State private var status1 = false
    @State private var status2 = false
    @State private var status3 = false
    //MARK: -BODY
    var body: some View {
        //MARK: -INTERMEDIARY BINDING
        let s1 = Binding<Bool>(get: { self.status1 }, set: { self.status1 = $0; self.status2 = false; self.status3 = false })
                let s2 = Binding<Bool>(get: { self.status2 }, set: { self.status1 = false; self.status2 = $0; self.status3 = false })
                let s3 = Binding<Bool>(get: { self.status3 }, set: { self.status1 = false; self.status2 = false; self.status3 = $0 })//: INTERMEDIARY BINDING
        //MARK: -NAVIGATION VIEW
        NavigationView{
            //MARK: -VSTACK
            VStack(alignment: .center, spacing:0){
                //MARK: -FORM
                Form{
                    Section(header:Text("Recreational Sites Visibility Settings")){
                        VStack{
                            Toggle(isOn: s1) {
                                VStack(alignment:.leading, spacing:0){
                                    Text("My name and Recreationalist Profile")
                                        .font(.headline)
                                    Text("First name and last initial, link to profile, and gender")
                                        .font(.subheadline)
                                }
                            }.toggleStyle(CheckboxToggleStyle())
                        }
                        VStack{
                            Toggle(isOn: s2) {
                                VStack(alignment:.leading,spacing:0){
                                    Text("My demographics")
                                        .font(.headline)
                                    Text("Gender")
                                        .font(.subheadline)
                                }
                            }.toggleStyle(CheckboxToggleStyle())
                        }
                        VStack{
                            Toggle(isOn: s3) {
                                VStack(alignment:.leading, spacing:0){
                                    Text("Basic information")
                                        .font(.headline)
                                    Text("No additional details")
                                        .font(.subheadline)
                                }
                            }.toggleStyle(CheckboxToggleStyle())
                        }
                    }
                }//: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            }//: VSTACK
            .navigationBarTitle("Privacy Settings", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }//: NAVIGATION VIEW
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .onTapGesture { configuration.isOn.toggle()
                }
        }
    }
}

//MARK: -PREVIEW
struct MoreOption_PrivacySettings_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_PrivacySettings()
    }
}
