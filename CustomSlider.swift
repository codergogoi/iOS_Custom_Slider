//
//  CustomSlider.swift
//  LoaderView
//
//  Created by JAYANTA GOGOI on 11/26/19.
//  Copyright © 2019 JAYANTA GOGOI. All rights reserved.
//

import UIKit


extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

extension UIBezierPath {
    convenience init(heartIn rect: CGRect) {
        self.init()

        let sideOne = rect.width * 0.6
        let sideTwo = rect.height * 0.6
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/1.65

        self.addArc(withCenter: CGPoint(x: rect.width * 0.5, y: rect.height * 0.35), radius: arcRadius, startAngle: 120.degreesToRadians, endAngle: 300.degreesToRadians, clockwise: true)
        
        self.addArc(withCenter: CGPoint(x: rect.width * 0.5, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        self.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 1))
        self.close()
    }
}



class CustomSlider : UIControl{
    
    
    private var maxValue : CGFloat = 100 { // default initilizer
        didSet{
            self.setupDefaultValue()
        }
    }
    
    private  var defaultValue: CGFloat = 100{ // default initilizer
        didSet{
            self.setupDefaultValue()
        }
    }

    var currentProgress: Double = 0

    
    private var cornerRadius: CGFloat =  3
    
    private var txtLayer: CATextLayer = {
        let txtLayer = CATextLayer()
        txtLayer.fontSize = 16
        txtLayer.alignmentMode = .center
        return txtLayer
    }()
    
    private var thumbLayer : CALayer = {
        let layer = CALayer()
        return layer
    }()
    
   private  var fillLayer: CALayer = {
        let layer = CALayer()
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        setupLayer()
        self.setupDefaultValue()
        
    }
    
    func setMaxDefault(max: Double, _ defaultProgress: Double = 0){
        self.maxValue = CGFloat(max)
        self.defaultValue = CGFloat(defaultProgress) > 0 ? CGFloat(defaultProgress) : CGFloat(max)
    }
    
    var onChangeSlider: ((Double) -> Void)?
    
    private func setupLayer(){
        
        let sliderBGColor = CALayer()
        sliderBGColor.frame = CGRect(x: 0, y: self.layer.frame.height -  5, width: self.layer.frame.size.width, height: 5)
        sliderBGColor.backgroundColor = UIColor.lightGray.cgColor
        sliderBGColor.cornerRadius = cornerRadius
        self.layer.addSublayer(sliderBGColor)
        
        self.fillLayer.frame = CGRect(x: 0, y: self.layer.frame.height - 5, width: self.layer.frame.size.width, height: 5)
        self.fillLayer.backgroundColor = UIColor.AppColor().cgColor
        self.fillLayer.cornerRadius = cornerRadius
        self.layer.addSublayer(fillLayer)
        
        self.thumbLayer.frame = CGRect(x: 0, y: self.frame.size.height / 2, width: 40, height: 40)
        self.layer.addSublayer(thumbLayer)
        
        let heartPath = UIBezierPath(heartIn: CGRect(x: 0, y: 0, width: 40, height: 40))

        let dropLayer = CAShapeLayer()
        dropLayer.path = heartPath.cgPath
        dropLayer.fillColor = UIColor.AppColor().cgColor
        self.thumbLayer.addSublayer(dropLayer)
        
        txtLayer.frame = CGRect(x: 0, y: 5, width: 40, height: 40)
        txtLayer.foregroundColor = UIColor.white.cgColor
        self.thumbLayer.addSublayer(txtLayer)
        
        self.thumbLayer.position.x = 0
        
    }
    
    
   private func setupDefaultValue(){
                
        let currentPosition = Double(bounds.width / maxValue) * Double(defaultValue)
        self.currentProgress = Double(defaultValue / maxValue * 100)
        self.transformSlider(positionX: CGFloat(currentPosition), progress: Double(defaultValue))
        self.onChangeSlider?(Double(defaultValue))
        
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        let currentValue = Double(location.x * maxValue / bounds.width)
        
        if(currentValue > 0 && currentValue <= Double(maxValue)){
            self.currentProgress = currentValue
            self.transformSlider(positionX: location.x, progress: currentValue)
        }
 
        return true
    }
    
    private func transformSlider(positionX: CGFloat, progress: Double){
        self.thumbLayer.position = CGPoint(x: positionX, y: self.frame.size.height/2)
        self.txtLayer.string = String(format: "%.01f", progress)
        let totalWidth =   Double(positionX + (bounds.width / maxValue))
        self.fillLayer.frame = CGRect(x: 0, y: self.frame.size.height - 5, width:  CGFloat(totalWidth), height: 5)
        self.onChangeSlider?(progress)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
