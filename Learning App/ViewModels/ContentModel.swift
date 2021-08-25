//
//  ContentModel.swift
//  Learning App
//
//  Created by Xavier Cleto on 16/08/21.
//

import Foundation

class ContentModel: ObservableObject{
    
    @Published var modules = [Module]()
    @Published var currentModule: Module?
    @Published var currentLesson: Lesson?
    @Published var currentQuestion: Question?
    @Published var codeText = NSAttributedString()
    @Published var selectedIndex: Int?
    @Published var currentTestIndex: Int?

    
    var currentModuleIndex = 0
    var currentLessonIndex = 0
    @Published var currentQuestionIndex = 0
    
    var style: Data?
    
    init() {
        getLocalData()
        getRemoteData()
    }
    
    func getLocalData() {
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            let data = try Data(contentsOf: jsonUrl!)
            let decoder = JSONDecoder()
            let parsedJsonData = try decoder.decode([Module].self, from: data)
            
            self.modules = parsedJsonData
            
        } catch {
            print("Couldn't parse json")
        }
        
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        do {
            let data = try Data(contentsOf: styleUrl!) 
            self.style = data
            
        } catch {
            print("Couldn't retrieve style file")
        }
    }
    
    func getRemoteData() {
        
        // Creo la variabile con l'URL da contattare
        let urlString = "https://cheddarnachos.github.io/learningapp-data/data2.json"
        
        // Creo l'oggetto URL dal mio url
        let url = URL(string: urlString)
        
        // Check che l'oggetto URL non sia nil
        guard url != nil else {
            return
        }
        
        // Creo la mia request (skippabile, ma utile nel caso dovessi aggiungere parametri e/o headers alla request)
        let request = URLRequest(url: url!)
        
        // Creo la session
        let session = URLSession.shared
        
        // Creo l'oggetto dataTask (restituito dal metodo dataTask della session) in modo da salvare il risultato della request in una costante
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            // Controllo che non ci siano errori
            guard error == nil else {
                return
            }
            
            // Gestisco la response
            let decoder = JSONDecoder()
            do {
                let parsedJsonData = try decoder.decode([Module].self, from: data!)
                
                self.modules += parsedJsonData
                
            } catch {
                print("There was an error")
            }
        }
        
        // Lancio il metodo dataTask
        dataTask.resume()
    }
    
    func beginModule(_ moduleId: Int) {
        
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                currentModuleIndex = index
                break
            }
        }
        
        currentModule = modules[currentModuleIndex]
            
    }
        
    func beginLesson(_ lessonIndex: Int) {
        
        if currentModule != nil {
            if lessonIndex < currentModule!.content.lessons.count {
                currentLessonIndex = lessonIndex
            } else {
                currentLessonIndex = 0
            }
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = setAttributedString(currentLesson!.explanation)

        }
                
    }
    
    func hasNextLesson() -> Bool {
            return (currentLessonIndex) + 1 < currentModule!.content.lessons.count
    }
    
    func beginTest(_ moduleId: Int) {
        
        // Imposto il currentModule
        beginModule(moduleId)
        
        // Imposto l'index della prima domanda a 0. Se sono presenti domande, imposto la prima domanda su domanda[0]
        currentQuestionIndex = 0
        if currentModule != nil {
            if currentModule?.test.questions.count ?? 0 > 0 {
                currentQuestion = currentModule!.test.questions[currentQuestionIndex]
                codeText = setAttributedString(currentQuestion!.content)

            }
        }
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = setAttributedString(currentLesson!.explanation)
        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = setAttributedString(currentQuestion!.content)
        } else {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    

    func setAttributedString(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add styling data
        if style != nil {
            data.append(style!)
        }
        
        // Add HTML data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        if let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) {
            
                resultString = attributedString
        }

        return resultString
    }
}
    
