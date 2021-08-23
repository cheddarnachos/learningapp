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
    @Published var lessonDescription = NSAttributedString()
    
    var currentModuleIndex = 0
    var currentLessonIndex = 0
    var style: Data?
    
    init() {
        getLocalData()
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
            lessonDescription = setAttributedString(currentLesson!.explanation)

        }
                
    }
    
    func hasNextLesson() -> Bool {
            return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = setAttributedString(currentLesson!.explanation)
        } else {
            currentLessonIndex = 0
            currentLesson = nil
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
    
