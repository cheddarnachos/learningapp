//
//  ContentViewRow.swift
//  Learning App
//
//  Created by Xavier Cleto on 23/08/21.
//

import SwiftUI

struct ContentViewRow: View {
    var index: Int
    var title: String
    var duration: String
    var body: some View {
        
        ZStack (alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 70)
                .cornerRadius(20)
                .shadow(radius: 3)
            
            HStack (spacing: 30){
                Text(String(index + 1))
                
                VStack (alignment: .leading){
                    Text(title)
                        .bold()
                    Text(duration)
                }
            }
            .padding()
        }
        
    }
}

