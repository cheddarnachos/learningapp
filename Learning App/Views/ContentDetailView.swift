//
//  ContentDetailView.swift
//  Learning App
//
//  Created by Xavier Cleto on 23/08/21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.urlVideoHost + (lesson?.video ?? ""))
        
        VStack {
            VideoPlayer(player: AVPlayer(url: url!))
                .cornerRadius(10)
            
            CodeTextView()
            
            if model.hasNextLesson() {
            
                Button(action: {
                    model.nextLesson()
                }, label: {
                    ZStack{
                        Rectangle()
                            .frame(height: 55)
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Next lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                })
                
            }
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
        
        

    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
