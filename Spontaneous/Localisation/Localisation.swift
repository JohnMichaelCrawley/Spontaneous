//
//  Localisation.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 09/05/2023.
//

import Foundation


class Localisation
{
    
}
extension String
{
    func localised() -> String
    {
        return NSLocalizedString(self,
                                 tableName: "Localisable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
