//
//  MSUEnableSearchButton.swift
//  GotchaScooterDetection
//
//  Created by Mamduh Muridi on 4/8/20.
//  Copyright © 2020 AESC Capstone Team 25. All rights reserved.
//

import UIKit

class MSUEnableSearchButton: UIButton {
    var isOn = false
    var twitterBlue = UIColor(red: 29.0/255.0, green: 161.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.borderColor = twitterBlue.cgColor
        layer.cornerRadius = frame.size.height/2
        
        setTitleColor(twitterBlue, for: .normal)
        addTarget(self, action: #selector(MSUEnableSearchButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        
        
        let color = bool ? twitterBlue : .clear
        let title = bool ? "Enable" : "Disable"
        let titleColor = bool ? .white : twitterBlue
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
    }
    

}
