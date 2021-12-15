//
//  ViewController.swift
//  QuizApp
//
//  Created by BPSTIL - Swift - Mrs. K on 12/1/20.
//  Copyright © 2020 Kalmbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                      QuizProtocol,
                      UITableViewDelegate,
                      UITableViewDataSource,
                      ResultViewControllerProtocol
{
    @IBOutlet weak var quesstionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var model                = QuizModel()
    var questions            = [Question]()
    var numCorrect           = 0
    var currentQuestionIndex = 0
    
    var resultDialog: ResultViewController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // initialize the Result Display
        //
        resultDialog = storyboard?.instantiateViewController(identifier: "ResultVC")
            as? ResultViewController
        
        resultDialog?.modalPresentationStyle = .overCurrentContext
        
        resultDialog?.delegate = self       // added in Lesson 8
        
        
        // set self as the delegate and dataSource for Table View
        //
        tableView.delegate = self
        tableView.dataSource = self
        
        // set self as the delegate for the model
        //
        model.delegate = self
        
        // Go get the questions!
        //
        model.getQuestions()
        
    }//end of viewDidLoad() method
    
    
    func displayQuestion()
    {
        // make sure there are some questions &
        // make sure currentQuestionIndex is not out of bounds
        //
        guard questions.count > 0
                &&
            currentQuestionIndex < questions.count
        else
        {
            return      // exit immediately
        }
        
        // display text of question
        //
        quesstionLabel.text =
         questions[currentQuestionIndex].question
        
        // reload the Table View
        //
        tableView.reloadData()
        
    }//end of displayQuestion() method
    
    
    // MARK: - QuizProtocol Methods
    //
    func questionsRetrieved(_ questions: [Question])
    {
        // get a reference to the questions
        //
        self.questions = questions
        
        // display first question
        //
        displayQuestion()
        
    }
    
    
    // MARK: - UITableView Delegate Methods
    //
    
    // Method: numberOfRowsInSection
    //
    func tableView(_                     tableView: UITableView,
                   numberOfRowsInSection section:   Int
                  )
                    -> Int
    {
        // make sure array of questions has at least one element
        //
        guard questions.count > 0
        else
        {
            return 0
        }
        
        // return number of answers for current question
        //
        let currentQuestion = questions[currentQuestionIndex]
        
        if currentQuestion.answers != nil
        {
            return currentQuestion.answers!.count
        }
        else
        {
            return 0
        }
        
    }//end of "numberOfRowsInSection" method
    
    
    
    // Method: cellForRowAt
    //
    func tableView(_            tableView: UITableView,
                   cellForRowAt indexPath: IndexPath
                  )
                    -> UITableViewCell
    {
        
        // get a cell for the Table View
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        // customize the cell
        //
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil
        {
            let question = questions[currentQuestionIndex]
            
            // if any answers exist AND current row is < # of answers
            //
            if question.answers != nil
                &&
               indexPath.row < question.answers!.count
            {
                // set the answer text for the label
                //
                label!.text = question.answers![indexPath.row]
            }
            
        }// end "if label != nil"
        
        
        // return the cell
        //
        return cell
        
    }//end of "cellForRowAt" method
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // user has tapped an answer -- handle this event
        
        var titleText = ""
        
        // get current question
        //
        let question = questions[currentQuestionIndex]
        
        // see if tapped answer is correct
        //
        if question.correctAnswerIndex! == indexPath.row
        {
            print ("user is RIGHT")
            titleText = "YES!"
            numCorrect += 1
        }
        else
        {
            print ("user is WRONG")
            titleText = "OOPS!"
        }
        
        // show popup dialog with feedback for the user
        //
        if resultDialog != nil
        {
            // set fields of dialog box to feedback for current question
            //
            resultDialog!.titleText     = titleText
            resultDialog!.feedbackText  = question.feedback!
            resultDialog!.buttonText    = "Next"
            
            present(resultDialog!, animated: true, completion: nil)
        }
        
        
        // In Lesson 8 (Customize Pop Up Dialog)
        // the following code gets moved
        // to the new dialogDismissed() method
        
        // move on to next question
        //
//        currentQuestionIndex += 1
//        displayQuestion()
        
    }// end of "didSelectRowAt" method
    
    
    // MARK: - ResultViewControllerProtocol methods
    
    func dialogDismissed()
    {
        // move on to next question or the summary in popup
        //
        currentQuestionIndex += 1
        
        if currentQuestionIndex == questions.count
        {
            // user just answered last question, so show SUMMARY
            //
            if resultDialog != nil
            {
                // set fields of dialog box with Quiz SUMMARY info
                //
                resultDialog!.titleText     = "Summary"
                resultDialog!.feedbackText  = "\(numCorrect) out of \(questions.count) questions answered correctly"
                resultDialog!.buttonText    = "take Quiz again"
                
                present(resultDialog!, animated: true, completion: nil)
            }
        }
        else if currentQuestionIndex > questions.count
        {
            // user tapped the RESTART button,
            // so reset to the initial state of quiz and begin again
            //
            numCorrect           = 0
            currentQuestionIndex = 0
            displayQuestion()
        }
        else if currentQuestionIndex < questions.count
        {
            // more questions to be answered, so display the next one
            //
            displayQuestion()
        }
            
        displayQuestion()
        
    }//end of dialogDismissed() method

    
}//end of ViewController class
