//
//  OnBoardingCollectionViewCell.swift
//  FlavorSafari
//
//  Created by Vikram Kunwar on 02/08/23.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnBoardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    @IBOutlet weak var slideTitleLbl: UILabel!
    
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    func setup(_ slide : OnboardingSlide){
        
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
}
