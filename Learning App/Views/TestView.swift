//
//  TestView.swift
//  Learning App
//
//  Created by Xavier Cleto on 24/08/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var submitted = false
    @State var correctAnswers = 0
    var body: some View {
        
        VStack {
            // Mostro index domanda attuale
            Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
            
            if model.currentQuestion != nil {
                
                // Mostro domanda
                CodeTextView()
                    .frame(height: 200)
                // Mostro possibili risposte
                ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                    
                    Button {
                        
                        // Aggiorno index della risposta selezionata al tap
                        selectedAnswerIndex = index
                        
                    } label: {
                        ZStack {
                            // Se ho premuto submit e sto generando il pulsante per la risposta corretta, evidenzio in verde
                            if (submitted && index == model.currentQuestion!.correctIndex){
                                RectangleCard(color: .green)
                                    .frame(height: 40)
                            // Se ho premuto submit e sto generando il pulsante per una risposta non corretta, evidenzio in rosso se è quella selezionata, altrimenti lascio in bianco
                            } else if (submitted && index != model.currentQuestion!.correctIndex){
                                RectangleCard(color: index == selectedAnswerIndex ? .red : .white)
                                    .frame(height: 40)
                            // Se non ho ancora premuto submit, evidenzio in grigio solo il tasto selezionato
                            } else {
                                RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                    .frame(height: 40)

                                
                            }
                            Text("\(model.currentQuestion!.answers[index])")
                                .bold()
                        }
                    }
                    .accentColor(.black)
                    .disabled(submitted)
                }
                
            }
            Spacer()
            
            // Pulsante "prossima domanda" o fine test
                        
            if !submitted {
                Button {
                    submitted = true
                    
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 50)
                        
                        Text("Submit answer")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                }
                .disabled(selectedAnswerIndex == nil)
            } else if model.currentQuestionIndex + 1 < (model.currentModule?.test.questions.count ?? 0) {
                Button {
                    updateQuestionVar()
                    model.nextQuestion()
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 50)
                        
                        Text("Next question")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                }
            } else {
                Button {
                    model.currentTestIndex = nil
                    
                } label: {
                    ZStack {
                        RectangleCard(color: .red)
                            .frame(height: 50)
                        
                        Text("Finish")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                }

            }
        }.padding()
        .navigationTitle("\(model.currentModule?.category ?? "") Test")
        
    }
    
    func updateQuestionVar() {
        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
            correctAnswers += 1
        }
        submitted = false
        selectedAnswerIndex = nil
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
