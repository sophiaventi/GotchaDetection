//
//  EnableDetectionButton.swift
//  GotchaScooterDetection
//
//  Created by Muridi, Mamduh on 4/9/20.
//  Copyright © 2020 AESC Capstone Team 25. All rights reserved.
//

import UIKit

class EnableDetectionButton: UIButton {

    var isOn = false
    let twitterBlue = UIColor(red: 29.0/255.0, green: 161.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        let image = UIImage(named: "Maldives.png") as UIImage?
        setBackgroundImage(image, for: .normal)
        setTitleColor(.white, for: .normal)
        addTarget(self, action: #selector(EnableDetectionButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        let title = bool ? "Enable" : "Disable"
        let image = bool ? UIImage(named: "Maldives.png") as UIImage? : UIImage(named: "Purplepine.png") as UIImage?
        
        setTitle(title, for: .normal)
        setBackgroundImage(image, for: .normal)
    }

}
