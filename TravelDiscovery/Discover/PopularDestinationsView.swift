//
//  PopularDestinationsView.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/4/20.
//

import SwiftUI
import MapKit

struct PopularDestinationsView: View {
    
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.855014, longitude: 2.341231),
        .init(name: "Tokyo", country: "Japan", imageName: "japan", latitude: 35.67988, longitude: 139.7695),
        .init(name: "New York", country: "US", imageName: "new_york", latitude: 40.71592, longitude: -74.0055),
        
    ]
    
    var body: some View {
        VStack {
            HStack {
            Text("Popular Destinations")
                .font(.system(size: 14, weight: .semibold))
            Spacer()
            Text("See All")
                .font(.system(size: 14, weight: .semibold))
        }.padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8.0) {
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink(
                            destination:
                                NavigationLazyView(
                                PopularDestinationDetailsView(destinations: destination)),
                           
                            label: {
                           
                        PopularDestinationTile(destinations: destination)
                          
                           
                            .padding(.bottom)
                      
                                       })
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct DestinationDetails: Decodable {
    let description: String
    let photos: [String]
}

class DestinationDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var destinationDetails: DestinationDetails?
    
    init(name: String) {
     
        // Make a Network call
        
     //   let name = "paris"
        let fixedURLString = "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: fixedURLString)
        else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            // Make sure to check err and resp
          
            DispatchQueue.main.async {
                guard let data = data else { return }
     
                
                do {
                    
                    self.destinationDetails = try JSONDecoder().decode(DestinationDetails.self, from: data)
                    
                } catch {
                    
                    print("Failed to decode JSON", error)
                }
            }
            
            
           
            
        }.resume()
    }
}

struct PopularDestinationDetailsView: View {
    
    @ObservedObject var vm: DestinationDetailsViewModel
    
    let destinations: Destination
   
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = false
    
    
    init(destinations: Destination) {
        
        self.destinations = destinations
        self._region = State(initialValue:
                                MKCoordinateRegion(center: . init(latitude: destinations.latitude, longitude: destinations.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))

        self.vm = .init(name: destinations.name)
    }
 
    
    let imageURLStrings = [
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/b1642068-5624-41cf-83f1-3f6dff8c1702",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531"
    ]
    var body: some View {
        
        ScrollView {
         
            if let photos = vm.destinationDetails?.photos {
                DestinationHeaderContainer(imageURLStrings: photos)
                   .frame(height: 350)
            }
            
            
           

//                .resizable()
//                .scaledToFill()
                //This solution might not work depending on the Frame of the text and image that is added
              
//                .clipped()
            VStack(alignment: .leading) {
                Text(destinations.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destinations.country)
                
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                         
                    }
                }.padding(.top, 2)
                
                HStack {
                Text(vm.destinationDetails?.description ?? "")
                    .padding(.top, 4)
                    .font(.system(size: 14))
                Spacer()
                    
            }
      //          HStack { Spacer() }
            }.padding(.horizontal)
            
            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button(action: {
                    isShowingAttractions.toggle()
                }, label: {
                    Text("\(isShowingAttractions ? "Hide" : "Show") Attractions")
                        .font(.system(size: 12, weight: .semibold))
                })
                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()
            }.padding(.horizontal)
            
            
       //     Map(coordinateRegion: $region)
               
            
            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in
                
      //          MapMarker(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude), tint: .orange)
                MapAnnotation(coordinate: .init(latitude:
                                                    attraction.latitude, longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
                
            }
            
            .frame(height: 300)
            
        }.navigationBarTitle(destinations.name, displayMode: .inline)
    }
    
    let attractions: [Attraction] = [
        .init(name: "Effiel Tower", imageName: "eiffel_tower", latitude: 48.858605, longitude: 2.2946),
        .init(name: "Champs-Elysees",imageName: "new_york", latitude: 48.866867, longitude: 2.311780),
        .init(name: "Louvre Museum", imageName: "art2", latitude: 48.860288, longitude: 2.337789)
    ]

}

struct CustomMapAnnotation: View {
    let attraction: Attraction
    
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .frame(width: 80, height: 60)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5))))
            Text(attraction.name)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.gray]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .border(Color.black)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5))))
                
            
        }.shadow(radius: 5)
    }
}




struct PopularDestinationTile: View {
    
    let destinations: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Image(destinations.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .cornerRadius(5)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
            
            
            Text(destinations.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .foregroundColor(Color(.label))
            Text(destinations.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        //                         .frame(width: 125)
        
        .asTile()
        
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularDestinationDetailsView(destinations: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235))
        }
        PopularDestinationsView()
        DiscoverView()
    }
}
