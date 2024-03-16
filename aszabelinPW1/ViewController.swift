//
//  ViewController.swift
//  aszabelinPW1
//
//  Created by Забелин Александр Сергеевич on 16.03.2024.
//

import UIKit

// MARK: UIColor extension)

extension UIColor {
    convenience init?(hex: String) {
        let radix = 16
        let maxRadixValue = 255.0
        
        let hexWithoutHash = hex.replacingOccurrences(of: "#", with: "")
        let rgb = UInt64(hexWithoutHash, radix: radix)!
        
        let r = CGFloat((rgb & 0xFF000000) >> 24) / maxRadixValue
        let g = CGFloat((rgb & 0x00FF0000) >> 16) / maxRadixValue
        let b = CGFloat((rgb & 0x0000FF00) >> 8) / maxRadixValue
        let a = CGFloat(rgb & 0x000000FF) / maxRadixValue
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet var views: [UIView]!
    
    // MARK: view loading handler
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeViewsAppearance(views: views)
    }
    
    // MARK: button pressing handler
    
    @IBAction func buttonWasPressed(_ sender: Any) {
        let animationDuration = 1.5
        
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                self.button.isEnabled = false
                self.changeViewsAppearance(views: self.views)
            },
            completion: { [weak self] _ in
                self?.button.isEnabled = true
            }
        )
    }
    
    // MARK: function that changes appearance of views according to TR
    
    func changeViewsAppearance(views: [UIView]!) {
        changeBackgroundColor(views: views)
        changeCornerRadius(views: views)
    }
    
    // MARK: function that changes background color of views in a random way
    
    func changeBackgroundColor(views: [UIView]!) {
        let colors = getUniqueColors(counts: views.count)
        
        for idx in 0 ..< views.count {
            views[idx].backgroundColor = colors[idx]
        }
    }
    
    // MARK: function that changes corner radius of views in a random way
    
    func changeCornerRadius(views: [UIView]!) {
        for idx in 0 ..< views.count {
            views[idx].layer.cornerRadius = .random(in: 15...50)
        }
    }
    
    // MARK: function that returns [uniqueRandomColor] with length == counts
    
    func getUniqueColors(counts: Int) -> [UIColor] {
        var colors = [UIColor]()
        
        for _ in 0 ..< counts {
            colors.append(UIColor(hex: getRandomHex())!)
        }
        
        return colors
    }
    
    // MARK: function that returns random hex
    
    func getRandomHex() -> String {
        let hexChars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
        var hex = "#"
        
        for _ in 1...8 {
            hex += hexChars[Int.random(in: 0 ..< hexChars.count)]
        }
        
        return hex
    }
}

