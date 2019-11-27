//
//  ViewController.swift
//  LoaderView
//
//  Created by JAYANTA GOGOI on 11/26/19.
//  Copyright © 2019 JAYANTA GOGOI. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func rgba(r: Float, g: Float, b: Float,a: Float) -> UIColor{
          return UIColor(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: CGFloat(a))
      }
      
}


class ViewController : UIViewController{
    
    
    let lblProgressOutPut: UILabel = {
       
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font =  UIFont.systemFont(ofSize: 20)
        
        return  lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(lblProgressOutPut)
        self.view.addConstraintWithFormat(formate: "H:|[v0]|", views: lblProgressOutPut)
        self.view.addConstraintWithFormat(formate: "V:|-200-[v0]", views: lblProgressOutPut)
        
       
        let sliderView = CustomSlider(frame: CGRect(x: 50, y: self.view.frame.size.height/2 - 25, width: 320, height: 50))
        self.view.addSubview(sliderView)
        
        // Max  and Default same
        //sliderView.setMaxDefault(max: 32)
        
        //Max and Default both different
        sliderView.setMaxDefault(max: 32, 15)
        

        sliderView.onChangeSlider = { [weak self] (progress) in
            self?.lblProgressOutPut.text = String(format: "%.01f", progress)
        }
        
    }
    
    
    
    
    
    
    
    
}
