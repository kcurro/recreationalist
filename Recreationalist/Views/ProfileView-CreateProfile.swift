//
//  ProfileView-CreateAccount.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/18/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct ProfileView_CreateProfile: View {
    @EnvironmentObject var session: FirebaseSession
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) private var presentationMode
    
    //profile image variables
    @State private var imgPicker = false
    @State private var showSheet = false
    @State private var profileImage: Image?
    @State private var inputImg: UIImage?
    //profile image variables end
    
    let db = Firestore.firestore()
    @State var fullName: String = ""
    @State var gender: String = ""
    
    
    var body: some View {
        VStack(spacing: 16){
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                           startPoint: .leading,
                           endPoint: .trailing)
                .mask(Text("Create Profile")
                        .font(.system(size: 40, weight: .heavy)))
            
            VStack (spacing: 16){
                
                //take in user profile image from user
                ZStack{
                    if profileImage != nil {
                        profileImage?
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius:10)
                            .frame(width:100, height:100, alignment: .center)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                            .foregroundColor(Color.purple)
                    }
                }
                .onTapGesture {
                    self.imgPicker = true
                }
                //take in user profile image from user ends
                Spacer()
                
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
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                    .background(Color.purple)
                    .cornerRadius(5)
            }.navigationBarHidden(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 288)
            
      }.padding(.horizontal, 32)
      .padding(.vertical, 32)
        .sheet(isPresented: $imgPicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImg)
        }
        
    }
    
    //image picker functions
    
    func loadImage(){
        guard let inputImg = inputImg else {return}
        profileImage = Image(uiImage: inputImg)
    }
    
    func saveImage(){
        guard let userID: String = session.loggedInUser?.uid else { return }
        //store using userID
        let name = userID + ".jpeg"
        guard let profileImage = inputImg else {return}
        guard let data: Data = profileImage.jpegData(compressionQuality: 0.5) else {return}
        
        let metadata = StorageMetadata()
        metadata.contentType = "profileImage/jpg"
        
        let storage = Storage.storage().reference(withPath:"userImages/").child("\(name)")
        
        //place image into Storage
        storage.putData(data, metadata: metadata)
    }
        
    //image picker function ends
    
    func writeProfileToFirebase(){
        guard let userID: String = session.loggedInUser?.uid else { return }
        print("This is the userID: \(userID)")
        
        //need to add url images as well
        let data: [String:Any] = ["userID": userID, "full_name": fullName, "gender": gender, "profile_image": "userImages/\(userID).jpeg"]
        
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
        saveImage()
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
