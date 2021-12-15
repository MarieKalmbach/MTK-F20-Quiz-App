//
//  QuizModel.swift
//  QuizApp
//
//  Created by BPSTIL - Swift - Mrs. K on 12/1/20.
//  Copyright © 2020 Kalmbach. All rights reserved.
//

import Foundation

protocol QuizProtocol
{
    // REQUIREMENTS of protocol:
    // Whoever implements this protocol
    // MUST provide some code for this method!
    //
    func questionsRetrieved(_ questions:[Question])
        
}//end of QuizProtocol
 

class QuizModel
{
    // SECOND part of pattern, QuizModel needs a delegate property
    //
    var delegate:QuizProtocol?
    
    
    func getQuestions()
    {
        // Fetch the questions
        getLocalJsonFile()
        
        // Notify delegate of retrieved questions
        //
        // delegate?.questionsRetrieved([Question]())
        
        // The ? above is an example of OPTIONAL CHAINING.
        // This means that if no one is assigned
        // to the delegate property, then everything after ?
        // is ignored safely, and app will NOT crash.
        
    }//end of getQuestions() method
    
    
    func getLocalJsonFile()
    {
        // get bundle path for JSON file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // make sure path is not nil
        guard path != nil
        else
        {
            print("Could NOT find JSON data file.")
            return
        }
        
        // create URL object from path
        let url = URL(fileURLWithPath: path!)
        
        do
        {
            // try to get data from URL
            let data = try Data(contentsOf: url)
            
            // try to decode the JSON data
            let decoder = JSONDecoder()
            let questionArray = try
                        decoder.decode([Question].self, from: data)
            
            // notify delegate - JSON data is parsed into quesion objects
            delegate?.questionsRetrieved(questionArray)
            
        }// end of do - try block
        catch
        {
            // could not download or decode JSON data
        }
        
    }//end of getLocalJsonFile()
    
    
    func getRemoteJsonFile()
    {
        
    }//end of getRemoteJsonFile()
    
    
}//end of QuizModel class
