//
//  LoginViewController.swift
//  SunVault
//
//  Created by Bryan Work on 6/17/21.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    var attemptedPassword: String = ""
    var currentPlace = 0
    var password: String = "1234"
    let width:CGFloat = UIScreen.main.bounds.size.width
    var dotArray:[DotView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 153/255.0, alpha: 1.0)
        setupButtons()
    }
    
    @objc func numberPressed(_ sender: PasswordButtonView) {
        if currentPlace < 4 {
            attemptedPassword += String(sender.tag)
            dotArray[currentPlace].backgroundColor = UIColor.black
            currentPlace += 1
        }
        if currentPlace == 4 {
            if password == attemptedPassword { // Success
                let navigationController = UINavigationController(rootViewController: MainViewController())
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            } else { // Fail
                let ac = UIAlertController(title: "FAIL", message: "FAIL", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: NSLocalizedString("Loser", comment: "Default action"), style: .cancel))
                self.present(ac, animated: true, completion: nil)
            }
            (dotArray[0].backgroundColor, dotArray[1].backgroundColor, dotArray[2].backgroundColor, dotArray[3].backgroundColor) =
                (UIColor.white, UIColor.white, UIColor.white, UIColor.white)
            attemptedPassword = ""
            currentPlace = 0
        }
        
    }
    
    func setupButtons() {
        let outerSpacing:CGFloat = width / 10
        let innerSpacing:CGFloat = width / 20
        let buttonWidth:CGFloat = (width-2*outerSpacing-2*innerSpacing) / 3
        let buttonHeight:CGFloat = buttonWidth
        let rowOneY:CGFloat = 100
        let rowTwoY:CGFloat = rowOneY + buttonHeight + innerSpacing
        let rowThreeY:CGFloat = rowTwoY + buttonHeight + innerSpacing
        let rowFourY:CGFloat = rowThreeY + buttonHeight + innerSpacing
        let rowDotsY:CGFloat = rowFourY + buttonHeight + 2*innerSpacing
        let colOneX:CGFloat = outerSpacing
        let colTwoX:CGFloat = colOneX+buttonWidth+innerSpacing
        let colThreeX:CGFloat = colTwoX+buttonWidth+innerSpacing
        let rows = [rowOneY, rowTwoY, rowThreeY, rowFourY]
        let columns = [colOneX, colTwoX, colThreeX]
        var titleNumber = 1
        
        for row in 0...3 {
            if row < 3 {
                for col in 0...2 {
                    let button = PasswordButtonView(frame: CGRect(x: columns[col], y: rows[row], width: buttonWidth, height: buttonHeight), title: titleNumber)
                    button.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                    self.view.addSubview(button)
                    titleNumber += 1
                }
            } else if row == 3 {
                let button = PasswordButtonView(frame: CGRect(x: colTwoX, y: rowFourY, width: buttonWidth, height: buttonHeight), title: 0)
                button.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                self.view.addSubview(button)
                titleNumber += 1
                print("x: \(button.frame.maxX)")
                print("y: \(button.frame.maxY)")
            }
        }
        setupDots(dotY: rowDotsY)
    }
    
    func setupDots(dotY: CGFloat) {
        let outerSpacing: CGFloat = width / 3
        let innerSpacing: CGFloat = width / 15
        let dotWidth: CGFloat = (width-2*outerSpacing-3*innerSpacing) / 4
        let dotOneX = outerSpacing
        let dotTwoX = outerSpacing + dotWidth + innerSpacing
        let dotThreeX = dotTwoX + dotWidth + innerSpacing
        let dotFourX = dotThreeX + dotWidth + innerSpacing
        let dotXArray = [dotOneX, dotTwoX, dotThreeX, dotFourX]
        for dot in 0...3 {
            let dot = DotView(frame: CGRect(x:dotXArray[dot], y: dotY, width: dotWidth, height: dotWidth))
            view.addSubview(dot)
            dotArray.append(dot)
        }
    }
    
    
}
