//
//  EnableDetectionButton.swift
//  GotchaScooterDetection
//
//  Created by Muridi, Mamduh on 4/9/20.
//  Copyright © 2020 AESC Capstone Team 25. All rights reserved.
//

import UIKit

class EnableDetectionButton: UIButton {

    var isOn = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        let image = UIImage(named: "Celestial.png") as UIImage?
        setBackgroundImage(image, for: .normal)
        //setTitle("Enable", for: .normal)
        setTitleColor(.white, for: .normal)
        addTarget(self, action: #selector(EnableDetectionButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        let title = bool ? "Enable" : "Disable"
        let image = bool ? UIImage(named: "Celestial.png") as UIImage? : UIImage(named: "Purplepine.png") as UIImage?
        
        setTitle(title, for: .normal)
        setBackgroundImage(image, for: .normal)
    }

}
