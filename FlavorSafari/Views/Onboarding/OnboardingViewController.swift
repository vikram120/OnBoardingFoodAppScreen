//
//  OnboardingViewController.swift
//  FlavorSafari
//
//  Created by Vikram Kunwar on 02/08/23.
//

import UIKit
import SAConfettiView


class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    
    @IBOutlet weak var pageCntrl: UIPageControl!
    
    var slides : [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            if currentPage == slides.count {
                currentPage = 0
            } else if currentPage < 0 {
                currentPage = slides.count - 1
            }
            
            pageCntrl.currentPage = currentPage
            
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.", image: #imageLiteral(resourceName: "slide2")),
            OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: #imageLiteral(resourceName: "slide1")),
            OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "slide3"))
        ]
        
        pageCntrl.numberOfPages = slides.count

        
        
      

    }
    

    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
        let targetPage = currentPage + 1
        if targetPage >= 0 && targetPage < slides.count {
            currentPage = targetPage
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
//        else if targetPage == slides.count {
//                let storyboard = UIStoryboard(name: "Login", bundle: nil)
//                let userPortalVC = storyboard.instantiateViewController(withIdentifier: "UserPortalVC") as! UserPortalVC
//                self.navigationController?.pushViewController(userPortalVC, animated: true)
//            }
        
        else if targetPage == slides.count {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let userPortalV = storyboard.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
            self.navigationController?.pushViewController(userPortalV, animated: true)
        }
        
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        currentPage = sender.currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
extension OnboardingViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as! OnBoardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
            currentPage = indexPath.item
        }
    }
    
    
    
}
