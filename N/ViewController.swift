//
//  ViewController.swift
//  N
//
//  Created by Andrei Korikov on 04.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newNote))
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteRow", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.date.formatted()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEditNote" {
            guard let tableCell = sender as? UITableViewCell else { return }
            guard let destVC = segue.destination as? DetailViewController else { return }
            
            if let indexOfCell = tableView.indexPath(for: tableCell) {
                destVC.note = notes[indexOfCell.row]
            }
        }
    }
    
    @objc func newNote() {
        let note = Note()
        notes.append(note)
        guard let editView = storyboard?.instantiateViewController(withIdentifier: "EditNote") as? DetailViewController else { return }
        editView.note = note
        navigationController?.pushViewController(editView, animated: true)
    }
}

