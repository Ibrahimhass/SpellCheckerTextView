//
//  ViewController.swift
//  SpellCheckerTextView
//
//  Created by Ibrahimhass on 07/20/2018.
//  Copyright (c) 2018 Ibrahimhass. All rights reserved.
//

import UIKit
import SpellCheckerTextView

class ViewController: UIViewController {

    @IBOutlet weak var spellCheckerView: SpellCheckerTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spellCheckerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController : SpellCheckerTextViewDataSource {
    
    func textHightlightingColor() -> UIColor {
        return .green
    }
    
}
