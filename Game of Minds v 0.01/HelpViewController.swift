//
//  HelpViewController.swift
//  Game of Minds v 0.01
//
//  Created by Dream on 08.04.20.
//  Copyright © 2020 Dream Team. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var mainScroll: UIScrollView! {
        didSet { mainScroll.delegate = self }
    }
    @IBOutlet weak var navigationImages: UIStackView!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        navigationImages.subviews[0].frame = CGRect(x: navigationImages.subviews[0].frame.origin.x, y: navigationImages.subviews[0].frame.origin.y, width: 12.5, height: 12.5)
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addInteractions()
        updateImagesWithSelect(0)
        
    }
    
    func addInteractions() {
        
        for item in navigationImages.subviews {
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePressed(_:))))
        }
    }
    
    @objc private func imagePressed(_ sender: Any) {
        
        var curentIV = 0
        guard let gesture = sender as? UITapGestureRecognizer else { return }
        guard let imageView = gesture.view as? UIImageView else { return }
        for i in 0..<navigationImages.subviews.count {
            if imageView == navigationImages.subviews[i] {
                curentIV = i
            }
        }
        updateImagesWithSelect(curentIV)
        let currentPoint = CGPoint(x: Int(viewContainer.frame.size.width) * curentIV, y: 0)
        mainScroll.scrollRectToVisible(CGRect(origin: currentPoint, size: viewContainer.frame.size), animated: true)
        
    }
    
    func updateImagesWithSelect(_ selectImage: Int) {
        
        for i in 0..<navigationImages.subviews.count {
            if let currentImage = navigationImages.subviews[i] as? UIImageView {
                if i == selectImage {
                    currentImage.isHighlighted = true
                    currentImage.frame = CGRect(x: currentImage.frame.origin.x, y: currentImage.frame.origin.y, width: 12.5, height: 12.5)
                } else {
                    currentImage.isHighlighted = false
                    currentImage.frame = CGRect(x: currentImage.frame.origin.x, y: currentImage.frame.origin.y, width: 10, height: 10)
                }
            }
        }
    }
}

extension HelpViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / viewContainer.frame.size.width)
        updateImagesWithSelect(index)
        
    }
}
