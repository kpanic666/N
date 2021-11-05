//
//  DetailViewController.swift
//  N
//
//  Created by Andrei Korikov on 05.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    var note: Note!
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        note.text = textView.text
        
        if let vc = parent as? ViewController {
            vc.saveData()
        }
    }
}
