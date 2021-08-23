//
//  ContentView.swift
//  Learning App
//
//  Created by Xavier Cleto on 22/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            LazyVStack (alignment: .leading) {
                if model.currentModule != nil {
                    ForEach(model.currentModule!.content.lessons) { lesson in
                        
                        NavigationLink(
                            destination: ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(lesson.id)
                                }),
                            label: {
                                ContentViewRow(index: lesson.id, title: lesson.title, duration: lesson.duration)
                                    .padding(.horizontal)
                            })
                                                    
                    }
                }
            
            }
            .accentColor(.black)
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}


