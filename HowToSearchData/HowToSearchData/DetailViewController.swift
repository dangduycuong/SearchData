//
//  DetailViewController.swift
//  HowToSearchData
//
//  Created by duycuong on 1/15/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var detailCatogeryLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var detailCatogeryText: String?
    var detailNameText: String?
    var detailImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if detailCatogeryText != nil && detailNameText != nil {
            
            detailCatogeryLabel.text = detailCatogeryText
            detailCatogeryLabel.textColor = UIColor.red
            
            detailNameLabel.text = detailNameText
            detailNameLabel.textColor = UIColor.darkGray
            
            detailImageView.image = detailImage
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 5
            scrollView.delegate = self
        }
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        scrollView.minimumZoomScale = 0.5
//        scrollView.maximumZoomScale = 5
        return detailImageView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func detailInFor(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
