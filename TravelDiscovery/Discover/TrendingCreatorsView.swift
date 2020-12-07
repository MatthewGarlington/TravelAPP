//
//  TrendingCreatorsView.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/4/20.
//

import SwiftUI

struct TrendingCreatorsView: View {
    let users: [User] = [
        .init(name: "Amy Adams", imageName: "amy"),
        .init(name: "Billy", imageName: "billy"),
        .init(name: "Sam Smith", imageName: "sam"),
    ]
    
    var body: some View {
        VStack {
            HStack {
            Text("Trending Creators")
                .font(.system(size: 14, weight: .semibold))
            Spacer()
            Text("See All")
                .font(.system(size: 12, weight: .semibold))
        }.padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(users, id: \.self){user in
                        VStack {
                            Image(user.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .cornerRadius(60)
                               
                            Text(user.name)
                                .font(.system(size: 11, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }
                          
                         .frame(width: 60)
                         .shadow(color: .gray, radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                         .padding(.bottom)
                    }
                
            }.padding(.horizontal)
        }
    }
}
}

struct TrendingCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCreatorsView()
        DiscoverView()
    }
}
