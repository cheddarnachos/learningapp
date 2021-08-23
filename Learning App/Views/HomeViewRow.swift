//
//  HomeViewRow.swift
//  Learning App
//
//  Created by Xavier Cleto on 22/08/21.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image: String
    var category: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(20)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
                .shadow(radius: 4)
            
            HStack (spacing: 20){
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                VStack (alignment: .leading, spacing: 10) {
                    Text(category)
                        .font(.headline)
                    Text(description)
                        .font(.subheadline)
                    
                    HStack {
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        Text(count)
                            .font(Font.system(size: 10))
                        Spacer()
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        Text(time)
                            .font(Font.system(size: 10))
                    }
                }
            }.padding()
            
        }
            }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", category: "Swift", description: "Some Description", count: "10 Lesson", time: "3 Hours")
    }
}
