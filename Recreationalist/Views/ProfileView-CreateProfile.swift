//
//  ProfileView-CreateAccount.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/18/21.
//

import SwiftUI
import FirebaseFirestore

struct ProfileView_CreateProfile: View {
    let db = Firestore.firestore()
    @EnvironmentObject var session: FirebaseSession
    @EnvironmentObject var appState: AppState
    @State var fullName: String = ""
    @State var gender: String = ""
    
    //image picker variables
    
    @State private var isShowImagePicker : Bool     = false
    @State private var profileImage      : Image    = Image(systemName: "person")
    @State private var inputImage        : UIImage? = nil
    
    //image picker variables end
    
    var body: some View {
        VStack(spacing: 16){
            LinearGradient(gradient: Gradient(colors: [.yellow, .green]),
                           startPoint: .leading,
                           endPoint: .trailing)
                .mask(Text("Create Profile")
                        .font(.system(size: 40, weight: .heavy)))
            
            VStack (spacing: 16){
                
                //take in user profile image from user
                profileImage
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius:7)
                    .frame(width:95, height:95, alignment: .center)
                    //.onTapGesture {
                        //clickProfileImage()
                    //}
                Spacer()
                //profile image ends
                
                //full name
                TextField("Full Name", text: $fullName)
                    .disableAutocorrection(true)
                    .font(.system(size: 16))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary, lineWidth: 2))
                
                //gender
                TextField("Gender", text: $gender)
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
    
    //image picker functions

    //image picker function ends
    
    func writeProfileToFirebase(){
        guard let userID: String = session.loggedInUser?.uid else { return }
        print("This is the userID: \(userID)")
        
        //need to add url images as well
        let data: [String:Any] = ["full_name": fullName, "gender": gender]
        
        db.collection("profiles").document(userID).setData(data){ err in
            if let err = err{
                print("Error adding document: \(err)")
            } else {
                print("Document successfully written!")
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
