//
//  WelcomeViewController.swift
//  Game of Minds v 0.01
//
//  Created by Dream on 03.10.19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var scMainScroll: UIScrollView! { didSet { scMainScroll.delegate = self } }
    @IBOutlet weak var scNavigationImages: UIStackView!
 
    @IBAction func bSkip(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = sb.instantiateViewController(withIdentifier: "LoginMenu") as? LoginMenu else { return }
        show(viewController, sender: self)
        
    }
    
        override func viewDidLoad() {
            
        super.viewDidLoad()
        addInteractions()
        updateImagesWithSelect(0)
            
    }

    func addInteractions() {
        
        for item in scNavigationImages.subviews {
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePressed(_:))))
            
        }
    }
    
    @objc private func imagePressed(_ sender: Any) {
        
        var curentIV = 0
        guard let gesture = sender as? UITapGestureRecognizer else { return }
        guard let imageView = gesture.view as? UIImageView else { return }
        for i in 0..<scNavigationImages.subviews.count {
            if imageView == scNavigationImages.subviews[i] {
                curentIV = i
            }
        }
        updateImagesWithSelect(curentIV)
        let currentPoint = CGPoint(x: Int(vContainer.frame.size.width) * curentIV, y: 0)
        scMainScroll.scrollRectToVisible(CGRect(origin: currentPoint, size: vContainer.frame.size), animated: true)
        
    }
    
    func updateImagesWithSelect(_ selectImage: Int) {
        
        for i in 0..<scNavigationImages.subviews.count {
            if let currentImage = scNavigationImages.subviews[i] as? UIImageView {
                currentImage.isHighlighted = i == selectImage ? true : false
                
            }
        }
    }
}

extension WelcomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / vContainer.frame.size.width)
        updateImagesWithSelect(index)
        
    }
}
