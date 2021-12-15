//
//  ResultViewController.swift
//  QuizApp
//
//  Created by BPSTIL - Swift - Mrs. K on 12/3/20.
//  Copyright © 2020 Kalmbach. All rights reserved.
//

import UIKit

protocol ResultViewControllerProtocol
{
    func dialogDismissed()
}


class ResultViewController: UIViewController
{

    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
        
    @IBOutlet weak var dismissButton: UIButton!
    
    // additional properties for the dynamic text
    //
    var titleText      = " "       // "Right" or "Wrong"
    var feedbackText    = " "       // feedback for current question
    var buttonText      = " "       // "Next" or "Summary"
    
    var delegate: ResultViewControllerProtocol?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // round corners of dialog box
        //
        dialogView.layer.cornerRadius = 25

        // Now that elements have loaded, set dynamic text fields
        //
        resultLabel.text    = titleText
        feedbackLabel.text  = feedbackText
        
        dismissButton.setTitle(buttonText, for: .normal)
        
    }//end of viewDidLoad() method
    

    // this was added in M5-L8 time stamp 13:37
    //
    override func viewDidAppear(_ animated: Bool)
    {
        // set dynamic text fields of the elements of dialog box
        // as view appears again
        //
        resultLabel.text    = titleText
        feedbackLabel.text  = feedbackText
        
        dismissButton.setTitle(buttonText, for: .normal)
    }
    
    @IBAction func dismissTapped(_ sender: Any)
    {
        // dismiss the popup dialog window
        //
        dismiss(animated: true, completion: nil)
        
        // notify delegate that POPUP dialog was dismissed
        //
        delegate?.dialogDismissed()
        
    }//end of dismissTapped() IBAction method
    
    
}//end of ResultViewController
