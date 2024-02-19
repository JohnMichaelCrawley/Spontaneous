//
//  GetDirectionsViewModel.swift
//  Spontaneous
//
//  Created by John Crawley on 02/02/2024.
//

import Foundation


class GetDirectionsViewModel
{
    // MARK: - Return Place
    func returnPlaceSelected() -> Place 
    {
        let place = PlacesManager.shared.returnSinglePlace()
        return place
    }
}
