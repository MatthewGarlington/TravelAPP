//
//  DiscoverCategoriesView.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/4/20.
//

import SwiftUI


struct DiscoverCategoriesView: View {
    
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sports", imageName: "sportscourt.fill"),
        .init(name: "Live Events", imageName: "music.mic"),
        .init(name: "Food", imageName: "tray.fill"),
        .init(name: "History", imageName: "book.fill"),
    ]
   
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(categories, id: \.self){category in
                    NavigationLink(
                        destination :
                            NavigationLazyView(CategoriesDetailsView(name: category.name)),
                        label: {
                            VStack(spacing: 4) {
                               
                                Image(systemName: category.imageName)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .frame(width: 50, height: 50)
                                    .background(Color(.white ))
                                    .cornerRadius(25)
                                    .shadow(color: .gray, radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                                Text(category.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                        
                    }.frame(width: 60)
                    
                        })
                }
            }.padding(.horizontal)
        }
    }
}



struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
       
        DiscoverCategoriesView()
        DiscoverView()
    }
}
