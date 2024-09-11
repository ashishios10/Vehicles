//
//  Result.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//

import UIKit

/**
 ## Result <T>
 
 This class is usiful to provide network response.
 
 */

enum Result <T>{
    case Success(T)
    case Failure(String)
    case Error(String)
}
