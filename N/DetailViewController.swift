//
//  DetailViewController.swift
//  N
//
//  Created by Andrei Korikov on 05.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    var note: Note!
    var noteVault: NoteVault!
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note.text
        
        addToolbarButtons()
    }
    
    func addToolbarButtons() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let deleteBtn = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeNote))
        let activityBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        toolbarItems = [deleteBtn, spacer, activityBtn]
    }
    
    @objc func removeNote() {
        noteVault.remove(note)
        noteVault.saveData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func shareNote() {
        let avc = UIActivityViewController(activityItems: [note.text], applicationActivities: [])
        present(avc, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        note.text = textView.text
        noteVault.saveData()
    }
}
