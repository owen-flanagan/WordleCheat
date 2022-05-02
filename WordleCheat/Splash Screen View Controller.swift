//
//  Splash Screen View Controller.swift
//  WordleCheat
//
//  Created by Owen Flanagan on 5/2/22.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.frame.origin.y = self.view.frame.height
        
        UIView.animate(withDuration: 4.0) {
            self.imageView.frame.origin.y = 0
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        performSegue(withIdentifier: "Main", sender: sender)
    }
    
}
