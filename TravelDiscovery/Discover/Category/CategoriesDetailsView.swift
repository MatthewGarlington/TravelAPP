//
//  CategoriesDetailsView.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/5/20.
//

import SwiftUI
import SDWebImageSwiftUI



class CategoryDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var places = [Place]()
    
    @Published var errorMessage = ""
   
    init(name: String) {
        
        //Real Working NetworkingCode
        
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            self.isLoading = false
            return
            
        }
        
        
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
          
            
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // You want to check reponse and error
                
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Bad Status: \(statusCode)"
                    return
                }
                guard let data = data else {return}
                
                do {
                    self.places =  try JSONDecoder().decode([Place].self, from: data)
               
                } catch {
                    print("Failed to decode JSON", error)
                }
                self.isLoading = false
             
                
            }
        }.resume()
        
    }
}

struct CategoriesDetailsView: View {
    
    private let name: String
    @ObservedObject private var vm: CategoryDetailsViewModel
    
    init(name: String) {
        print("Loaded CategoryDetails view and making a network request for \(name)")
        self.name = name
        self.vm = .init(name: name)
    }
    
   //  let name: String

   // @ObservedObject var vm = CategoryDetailsViewModel()
   
    var body: some View {
        
        ZStack {
            if vm.isLoading {
                VStack {
                
               ActivityIndicatorView()
               Text("Loading..")
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
                }.padding()
                .background(Color.gray.blur(radius: 6.0))
                .cornerRadius(8)
                
            } else {
                
                    ZStack {
                        if !vm.errorMessage.isEmpty {
                            VStack(spacing : 12) {
                                Image(systemName: "xmark.octagon.fill")
                                    .font(.system(size: 64, weight: .semibold))
                                    .foregroundColor(.red)
                                Text(vm.errorMessage)
                                    
                                
                            }
                    }
            ScrollView {
                    ForEach(vm.places, id: \.self) { art in
                        VStack(alignment: .leading, spacing: 0) {
                            WebImage(url: URL(string: art.thumbnail ))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade)
                                .scaledToFill()
                            Text(art.name)
                                .font(.system(size: 12, weight: .semibold))
                                .padding()
                            
                        } .asTile()
                        .padding()
                    }
                }
            }
            }
        }.navigationBarTitle(name, displayMode: .inline)
    }
}


struct CategoriesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CategoriesDetailsView(name: "Live Events")
        }
        DiscoverCategoriesView()
        DiscoverView()
    }
}
