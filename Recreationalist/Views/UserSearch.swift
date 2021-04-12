//
//  UserSearch.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/6/21.
//

import SwiftUI
import MapKit
import UIKit

struct UserSearch: View {

    @State private var selection: String? = nil
    //anytime this throws or publishes an event it gives us the view values
    @ObservedObject private var locationManager = LocationManager()

    var body: some View {
        //checking if not nil if its not nil we unwrap it
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        return VStack(alignment: .center, spacing: 30){
            //MapView(location: $currentUserLocation)
            MapView(location: coordinate)
            //for temporary usage
            Text("User's location is: \(coordinate.latitude), \(coordinate.longitude)")
                .font(.system(size:10))
            Button(action: {
                print("Floating Button Click");
                self.selection = "All Sites"
            }, label: {
                NavigationLink(destination: SiteListView() , tag: "All Sites", selection: $selection) {
                    Text("All Sites - No Filtering")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Trails Button Click");
                self.selection = "Trails Only"
            }, label: {
                NavigationLink(destination: TrailsView(), tag: "Trails Only", selection: $selection){
                    Text("Trails")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Parks Button Click");
                self.selection = "Parks Only"
            }, label: {
                NavigationLink(destination: ParksView(), tag: "Parks Only", selection: $selection){
                    Text("Parks")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Gym Button Click");
                self.selection = "Gyms Only"
            }, label: {
                NavigationLink(destination: GymView(), tag: "Gyms Only", selection: $selection){
                    Text("Gyms")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Fields Button Click");
                self.selection = "Fields Only"
            }, label: {
                NavigationLink(destination: FieldsView(), tag: "Fields Only", selection: $selection){
                    Text("Courts & Fields")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Pools Button Click");
                self.selection = "Pools Only"
            }, label: {
                NavigationLink(destination: PoolsView(), tag: "Pools Only", selection: $selection){
                    Text("Pools")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Classes Button Click");
                self.selection = "Classes Only"
            }, label: {
                NavigationLink(destination: ClassesView(), tag: "Classes Only", selection: $selection){
                    Text("Classes")
                        .fontWeight(.semibold)
                }
            })
        }//vstack
        .navigationBarTitle("Result Filtered", displayMode: .inline)
        /*.toolbar{
            ToolbarItemGroup (placement: .navigationBarTrailing){
                Button(action: {
                    print("Trails Button Click");
                    self.selection = "Trails Only"
                }, label: {
                    NavigationLink(destination: TrailsView(), tag: "Trails Only", selection: $selection){
                        Text("Trails")
                            .fontWeight(.semibold)
                    }
                })
                Button(action: {
                    print("Parks Button Click");
                    self.selection = "Parks Only"
                }, label: {
                    NavigationLink(destination: ParksView(), tag: "Parks Only", selection: $selection){
                        Text("Parks")
                            .fontWeight(.semibold)
                    }
                })
                Button(action: {
                    print("Gym Button Click");
                    self.selection = "Gyms Only"
                }, label: {
                    NavigationLink(destination: GymView(), tag: "Gyms Only", selection: $selection){
                        Text("Gyms")
                            .fontWeight(.semibold)
                    }
                })
                Button(action: {
                    print("Fields Button Click");
                    self.selection = "Fields Only"
                }, label: {
                    NavigationLink(destination: FieldsView(), tag: "Fields Only", selection: $selection){
                        Text("Fields")
                            .fontWeight(.semibold)
                    }
                })
                Button(action: {
                    print("Pools Button Click");
                    self.selection = "Pools Only"
                }, label: {
                    NavigationLink(destination: PoolsView(), tag: "Pools Only", selection: $selection){
                        Text("Pools")
                            .fontWeight(.semibold)
                    }
                })
                Button(action: {
                    print("Classes Button Click");
                    self.selection = "Classes Only"
                }, label: {
                    NavigationLink(destination: ClassesView(), tag: "Classes Only", selection: $selection){
                        Text("Classes")
                            .fontWeight(.semibold)
                    }
                })
            }
        }*/
        //.onAppear(perform: getCurrentLocation)
    }
    
    /*func getCurrentLocation() {
            let lat = userLocation.lastLocation?.coordinate.latitude ?? 0
            let log = userLocation.lastLocation?.coordinate.longitude ?? 0

            self.currentUserLocation.latitude = lat
            self.currentUserLocation.longitude = log
    }*/
}

/*struct UserSearch_Previews: PreviewProvider {
    static var previews: some View {
        UserSearch()
    }
}*/


/*struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var currentLocation : CLLocationCoordinate2D
    
     func setupManager() {
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       locationManager.requestWhenInUseAuthorization()
       locationManager.requestAlwaysAuthorization()
     }
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {

    }
 }*/

/*
 struct MapView: UIViewRepresentable {

     @Binding var currentUserLocation : CLLocationCoordinate2D


     func makeUIView(context: Context) -> MKMapView {
         let mapView = MKMapView()
         mapView.delegate = context.coordinator
         return mapView
     }

     func updateUIView(_ view: MKMapView, context: Context) {
         view.setCenter(currentUserLocation, animated: true)

     }

     func makeCoordinator() -> Coordinator {
         Coordinator(self)
     }

  class Coordinator: NSObject, MKMapViewDelegate{

     var parent: MapView
     init(_ parent: MapView) {
         self.parent = parent
     }

     }
 }
 */


struct MapView : View {
    //@Binding var location : CLLocationCoordinate2D
    var location: CLLocationCoordinate2D

   struct IdentifiablePoint: Identifiable {
       var id = UUID()
       var location : CLLocationCoordinate2D
   }
   
   var body: some View {
       Map(coordinateRegion: .constant(
               MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))), annotationItems: [location].map { IdentifiablePoint(location: $0)}) { point in
           MapPin(coordinate: CLLocationCoordinate2D(latitude: point.location.latitude, longitude: point.location.longitude))
       }
       .ignoresSafeArea(edges: .top)
       .frame(height: 300)
   }
}

