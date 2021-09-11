//
//  Errors.swift
//  Reciplease
//
//  Created by Birkyboy on 07/09/2021.
//

import Foundation
import Alamofire

protocol ErrorPresenter: AnyObject {
    func presentErrorAlert(with message: String)
}

enum IngredientError: Error {
    case noName
    case alreadyExist(ingredientName: String)

    var description: String {
        switch self {
        case .noName:
                return "You did not enter any ingredient!"
        case .alreadyExist(let name):
                return "\(name.capitalized) already in your list!"
        }
    }
}

enum ApiError: Error {
    case noInputData
    case noData
    case noRecipeFound
    case badURL
    case alamofireError(AFError)

    var description: String {
        switch self {
        case .badURL:
            return "Could not locate the data"
        case .alamofireError(let error):
            return error.errorDescription ?? ""
        case .noInputData:
            return "Please add ingredients in your list before looking for recipes."
        case .noData:
            return "Unable to find anything matching your request."
        case .noRecipeFound:
            return "Unable to get directions"
        }
    }
}
