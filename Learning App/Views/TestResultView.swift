//
//  TestResultView.swift
//  Learning App
//
//  Created by Xavier Cleto on 24/08/21.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    var correctAnswers: Int
    var body: some View {
        VStack (spacing: 40){
            Text("Great")
                .font(.title)
            if model.currentModule != nil {
                Text("You got \(correctAnswers) correct answers out of \(model.currentModule!.test.questions.count)")
            }
            // Pulsante per terminare il quiz
            Button {
                model.currentTestIndex = nil
            } label: {
                ZStack {
                    RectangleCard(color: .blue)
                        .frame(height: 48)
                    
                    Text("Complete!")
                        .foregroundColor(.white)
                }
            }

        }
        .padding()
        
    }
}

