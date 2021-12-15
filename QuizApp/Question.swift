//
//  Question.swift
//  QuizApp
//
//  Created by BPSTIL - Swift - Mrs. K on 12/1/20.
//  Copyright © 2020 Kalmbach. All rights reserved.
//

import Foundation

struct Question : Codable
{
    var question : String?
    var answers  : [String]?
    var correctAnswerIndex : Int?
    var feedback : String?
}

