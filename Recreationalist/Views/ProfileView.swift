//
//  ProfileView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI

struct ProfileView: View {
    //MARK: -PROPERTIES
    @EnvironmentObject var session: FirebaseSession
    
    //MARK: -BODY
    @ViewBuilder
    var body: some View {
        if session.isSignedIn {
            SignedInView()
        } else {
            AuthenticationView() //if forget to sign out and crashed comment out this line and line in More View
        }
    }
}

struct SignedInView: View {
    //MARK: -PROPERTIES
    //@EnvironmentObject var session: FirebaseSession
    private var data = ["186,467\nACTIVITES","0\nREVIEWS"]
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var activitiesAlert = false

    //MARK: -BODY
    var body: some View {
        //MARK: -NAVIGATION VIEW
        ScrollView{
            //MARK: -VSTACK
            VStack{
                Section{
                    //MARK: -HSTACK
                    HStack{
                        CircleImage(image:Image("roronoazoro").resizable())
                            .padding()
                        //MARK: -VSTACK
                        VStack(alignment:.leading){
                            Text("Zoro Roronoa")
                                .font(.title2)
                                .fontWeight(.semibold)
                            LazyVGrid(columns: threeColumnGrid) {
                             ForEach(data, id: \.self){
                                item in Text(item).font(.caption)
                             }
                            }
                        }//: VSTACK
                        }//:HSTACK
                }
                Section(header: Text("My Stats").font(.headline)){
                    Spacer()
                }
                Section(header: Text("Activities").font(.headline)){
                    Spacer()
                    HStack{
                       Button(action: { print("I was clicked!")}) {
                            Image(systemName: "list.bullet")
                                .resizable()
                                .frame(width:60, height:55)
                                .foregroundColor(Color.yellow)
                                .padding()
                                    }
                        Text("186,467\nTRACKED").font(.body)
                    }
                }
                Section(header: Text("Reviews").font(.headline)){
                    Spacer()
                    HStack{
                       Button(action: { print("I was clicked!")}) {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width:60, height:55)
                                .foregroundColor(Color.yellow)
                                .padding()
                                    }
                        Text("0\nREVIEWS").font(.body)
                    }
                }
            }//: VSTACK
        }//: NAVIGATION VIEW
        
    }
}

//MARK: -PREVIEW
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(FirebaseSession())
    }
}
