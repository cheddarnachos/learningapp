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
                                            .onAppear(perform: {model.beginModule(module.id)
                                            }),
                                           tag: module.id,
                                           selection: $model.selectedIndex) {
                                HomeViewRow(image: module.content.image, category: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)

                            }
                            
                            NavigationLink(destination: TestView()
                                            .onAppear(perform: {model.beginTest(module.id)}),
                                           tag: module.id,
                                           selection: $model.currentTestIndex) {
                            HomeViewRow(image: module.test.image, category: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                            }
                            
                            /* NavigationLink(destination: EmptyView()) {
                                EmptyView()
                            } */
                            
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
