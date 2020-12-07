//
//  CategoryDetailsViewModel.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/5/20.
//

import SwiftUI


class CategoryDetailsViewModel: ObservableObject {
    
    @Published  var isLoading = true
    @Published var places = [Place]()
   
    init() {
        
        //Real Working NetworkingCode
        
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/category?name=art") else { return }
        
        
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // You want to check reponse and error
                
                
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
struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        aiv.color = .white
        return aiv
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}

struct CategoryDetailsViewModel_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsViewModel()
    }
}
