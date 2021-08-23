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
    
    var currentModuleIndex = 0
    
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
        
}
    
