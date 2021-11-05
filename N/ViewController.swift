//
//  ViewController.swift
//  N
//
//  Created by Andrei Korikov on 04.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    let noteVault = NoteVault()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteVault.loadData()
        
        addToolbarButtons()
    }
    
    func addToolbarButtons() {
        let newNoteBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let notesCount = noteVault.notes.count
        let counterLabel = UILabel()
        counterLabel.text = "\(notesCount) \(notesCount > 1 ? "notes" : "note")"
        let notesCounterBtn = UIBarButtonItem(customView: counterLabel)
        
        toolbarItems = [spacer, notesCounterBtn, spacer, newNoteBtn]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noteVault.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteRow", for: indexPath)
        let note = noteVault.notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.date.formatted()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEditNote" {
            guard let tableCell = sender as? UITableViewCell else { return }
            guard let destVC = segue.destination as? DetailViewController else { return }
            
            if let indexOfCell = tableView.indexPath(for: tableCell) {
                destVC.note = noteVault.notes[indexOfCell.row]
                destVC.noteVault = noteVault
            }
        }
    }
    
    @objc func newNote() {
        let note = Note()
        noteVault.append(note)
        guard let editView = storyboard?.instantiateViewController(withIdentifier: "EditNote") as? DetailViewController else { return }
        editView.note = note
        editView.noteVault = noteVault
        navigationController?.pushViewController(editView, animated: true)
    }
}

