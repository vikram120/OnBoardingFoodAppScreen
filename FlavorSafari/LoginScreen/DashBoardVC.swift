//
//  DashBoardVC.swift
//  FlavorSafari
//
//  Created by Vikram Kunwar on 03/09/23.
//

import UIKit

class DashBoardVC: UIViewController {
    
    
    @IBOutlet weak var foodCollection: UICollectionView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var logo: UIImageView!
    
    
    var foodImg = ["kfc","BurgerI","StarBucks","Pizza","Subway"]
    
    var logoImage = ["KFCLogo","MCLogo","StarBucksLogo","PizzaHutLogo","SubwayLogo"]
    
    var foodname = ["KFC","McDonald's","Starbucks","Pizza Hut","Subway"]
    
    var foodDesp = ["⭐️ 4.5  Chicken, American","⭐️ 4.8  Burger, American","⭐️ 4.9  Coffee, American","⭐️ 4.6  Pizza, American","⭐️ 4.5  Drinks, American"]
    
    var foodpri = ["$10","$7","$9","$12","$5"]
    
    var backgroundColorChanged = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Food DashBoard"
        
        navigationItem.leftBarButtonItem?.isHidden = true
        
        
        
        if let navigationBar = self.navigationController?.navigationBar {
                let titleTextAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.white
                ]
                navigationBar.titleTextAttributes = titleTextAttributes
            }
        
        foodCollection.layer.cornerRadius = 20  // Set corner radius
        foodCollection.layer.masksToBounds = true  // Clip to bounds
        
        foodCollection.backgroundView = UIView()
        foodCollection.backgroundView?.layer.cornerRadius = 20
        foodCollection.backgroundView?.layer.masksToBounds = true
        
       
        

        
    }
    


    
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the back button
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the back button when leaving this view controller
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    
           

    
}

extension DashBoardVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foodCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodCVC
        
           cell.layer.cornerRadius = 20
           cell.layer.masksToBounds = true
        
        cell.foodImage.image = UIImage(named: foodImg[indexPath.row])
        cell.foodImage.contentMode = .scaleAspectFit
        cell.foodName.text = foodname[indexPath.row]
        cell.foodDescription.text = foodDesp[indexPath.row]
        cell.foodPrice.text = foodpri[indexPath.row]
        return cell
        
    }
    
    func applyParallaxAnd3DZoomEffect(to cell: FoodCVC, xOffset: CGFloat) {
            let parallaxOffset = xOffset * 150  // Adjust the parallax factor as needed
            
            // Calculate zoom scale based on the parallaxOffset
        let zoomScale = 1.0 - abs(parallaxOffset) / 400.0
            
            // Apply the parallax effect using CGAffineTransform
            cell.transform = CGAffineTransform(translationX: parallaxOffset, y: 0)
            
            // Apply 3D-like zoom effect
        let rotation = CATransform3DMakeRotation(-parallaxOffset / 800.0, 0, 1, 0)
            let scale = CATransform3DMakeScale(zoomScale, zoomScale, 1.0)
            cell.layer.transform = CATransform3DConcat(rotation, scale)
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            for case let cell as FoodCVC in foodCollection.visibleCells {
                let xOffset = (cell.center.x - foodCollection.contentOffset.x - foodCollection.bounds.width / 2) / foodCollection.bounds.width
                applyParallaxAnd3DZoomEffect(to: cell, xOffset: xOffset)
                
                
            }
            
           
                let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2),
                                     y: (scrollView.frame.height / 2))
                guard let centerIndexPath = foodCollection.indexPathForItem(at: center) else { return }
                
                switch centerIndexPath.row {
                case 0:
                    mainView.backgroundColor = UIColor(hex: "#EA4335")// Red
                case 1:
                    mainView.backgroundColor = UIColor(hex: "#FF6D00")  // Yellow
                case 2:
                    mainView.backgroundColor = UIColor(hex: "#34A853")  // Green
                case 3:
                    mainView.backgroundColor = UIColor(hex: "#4285F4")  // Blue
                case 4:
                    mainView.backgroundColor = UIColor(hex: "#34A853")  //Green
                default:
                    break
                }
            
          
            
            // Get current center cell
                guard let centerCell = foodCollection.cellForItem(at: centerIndexPath) as? FoodCVC else { return }
                
                // Set background color of foodView in center cell
                centerCell.foodView.backgroundColor = mainView.backgroundColor
                // Update logo image
                logo.image = UIImage(named: logoImage[centerIndexPath.row])

            }

        }
    
    
    

