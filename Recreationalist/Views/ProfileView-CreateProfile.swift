//
//  ProfileView-CreateAccount.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/18/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ProfileView_CreateProfile: View {
    let db = Firestore.firestore()
    //@EnvironmentObject var session: FirebaseSession
    @EnvironmentObject var appState: AppState
    //@State var uid = session.loggedInUser?.uid
    @State var fullName: String = ""
    
    var body: some View {
        VStack(spacing: 16){
            LinearGradient(gradient: Gradient(colors: [.yellow, .green]),
                           startPoint: .leading,
                           endPoint: .trailing)
                .mask(Text("Create Profile")
                        .font(.system(size: 40, weight: .heavy)))
            VStack (spacing: 16){
                //insert image
                TextField("Full Name", text: $fullName)
                    .disableAutocorrection(true)
                    .font(.system(size: 16))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary, lineWidth: 2))
            } .padding(.vertical, 16)
            .frame(width: 288)
            
            Button(action: submit) {
                Text("Submit")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.black)
                    .font(.system(size: 24, weight: .bold))
                    .background(Color.yellow)
                    .cornerRadius(5)
            }.navigationBarHidden(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 288)
            
      }.padding(.horizontal, 32)
      .padding(.vertical,32)
        
    }
    
    func writeProfileToFirebase(){
        //let data = ["uid": uid, "full_name": fullName]
        let data = ["full_name": fullName]
        
        //post it to Firebase as a new document
        var ref: DocumentReference? = nil
        ref = db.collection("profiles").addDocument(data: data as [String : Any]){ err in
            if let err = err{
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func resetTextFields(){
        fullName = ""
    }
    
    func submit(){
        writeProfileToFirebase()
        resetTextFields()
        appState.hasCreatedProfile = true
    }
}

struct ProfileView_CreateProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView_CreateProfile()
    }
}
