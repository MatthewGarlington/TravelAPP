//
//  UserDetailsView.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/8/20.
//

import SwiftUI
import KingfisherSwiftUI

//https://travel.letsbuildthatapp.com/travel_discovery/user?id=0

struct UserDetails: Decodable {
    let username, firstName, lastName, profileImage: String
    let followers, following: Int
    let posts: [Post]
}

struct Post: Decodable, Hashable {
    let title, imageUrl, views: String
    let hashtags: [String]
}

class UserDetailViewModel: ObservableObject {
    
    @Published var userDetails: UserDetails?
    
    init(userId : Int) {
        
        //network code
        
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/user?id=\(userId)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.async {
              
            guard let data = data else { return }
            
          
            do {
                
                self.userDetails = try JSONDecoder().decode(UserDetails.self, from: data)
        } catch let jsonError {
            print("Decoding failed for UserDetails", jsonError)
        }
       
            }
        }.resume()
    }
}
struct UserDetailsView: View {
    
    @ObservedObject var vm: UserDetailViewModel
   
    let user: User
    
    init(user: User) {
        self.user = user
        self.vm = .init(userId: user.id)
        
    }
  
    
    var body: some View {
        ScrollView{
            VStack(spacing: 12) {
                Image(user.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.top)
                Text(user.name)
                    .font(.system(size: 14, weight: .semibold))
                HStack {
                    Text("@AmyAdams28 •")
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 10, weight: .semibold))
                    
                    Text("2541")
                    
                }.font(.system(size: 12, weight: .regular))
                
                Text("Youtuber, Vlogger, Travel Creator")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(.lightGray))
                
                HStack(spacing: 8) {
                    VStack {
                        Text("59,394")
                            .font(.system(size: 13, weight: .bold))
                        Text("Followers")
                            .font(.system(size: 9, weight: .regular))
                    }
                    
                    Spacer()
                        .frame(width: 1, height: 10)
                        .background(Color(.lightGray))
                    
                    
                    VStack {
                        Text("2,112")
                            .font(.system(size: 13, weight: .bold))
                        Text("Following")
                            .font(.system(size: 9, weight: .regular))
                    }
                }
                HStack(spacing: 12) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack{
                            Spacer()
                            Text("Follow")
                               
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .background(Color.pink)
                        .cornerRadius(100)
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack{
                            Spacer()
                            Text("Contact")
                            
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .background(Color(white: 0.8))
                        .cornerRadius(100)
                    })
                }
                .font(.system(size: 13, weight: .semibold))
                
                ForEach(vm.userDetails?.posts ?? [], id: \.self) { post in
                    VStack(alignment: .leading, spacing: 12) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                        
                        HStack {
                            Image("amy")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 34)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(post.title)
                                .font(.system(size: 14, weight: .semibold))
                                Text("\(post.views) Views")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.gray)
                            }
                        }.padding(.horizontal, 8)
                        HStack {
                            ForEach(post.hashtags, id: \.self) { hashtag in
                        Text("#\(hashtag)")
                            .foregroundColor(Color(#colorLiteral(red: 0.3619318604, green: 0.6622257829, blue: 0.9613088965, alpha: 1)))
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color(#colorLiteral(red: 0.9266451001, green: 0.9417328238, blue: 0.9799485803, alpha: 1)))
                            .cornerRadius(20)
                          
                            }
                        }.padding(.horizontal, 8)
                        .padding(.bottom)
                           
                    }
                    
                   
     //                   .frame(height: 200)
                        .background(Color(white: 1))
                        .cornerRadius(12)
                        .shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 4 )
                    }
                
            }.padding(.horizontal)
            
            
        }.navigationBarTitle(user.name, displayMode: .inline)
        
    }
}
struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
        NavigationView {
            UserDetailsView(user: .init(id: 0, name: "Amy Adams", imageName: "amy"))
        }
    }
}
