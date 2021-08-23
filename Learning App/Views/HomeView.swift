//
//  ContentView.swift
//  Learning App
//
//  Created by Xavier Cleto on 16/08/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVStack (spacing: 20) {
                    ForEach(model.modules) {module in
                        
                        VStack (spacing: 20) {
                            NavigationLink(destination: ContentView()
                                            .onAppear(perform: {
                                                model.beginModule(module.id)
                                            })) {
                                HomeViewRow(image: module.content.image, category: module.category, description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)

                            }
                                                        
                            HomeViewRow(image: module.test.image, category: module.category, description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                        }
                        
                        
                    }
                    
                }
                .padding(.horizontal)
                .accentColor(.black)
            }
            .navigationTitle("Get started!")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
