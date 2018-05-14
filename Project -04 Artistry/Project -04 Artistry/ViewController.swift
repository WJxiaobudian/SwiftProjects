//
//  ViewController.swift
//  Project -04 Artistry
//
//  Created by 王洁 on 2018/5/11.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    let artists = Artist.artistsFromBundle()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("123")
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange , object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailTableViewController,
        let indexpath = tableView.indexPathForSelectedRow {
            destination.selectedArtist = artists[indexpath.row]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("12123123")
        return artists.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath ) as! ArtistTableViewCell
        
        let artist = artists[indexPath.row]
        
        cell.BioLabel.text = artist.bio
        cell.BioLabel.textColor = UIColor(white: 114/255, alpha: 1)
        
        cell.ArtistImageView.image = artist.image
        cell.NameLabel.text = artist.name
        
        cell.NameLabel.backgroundColor = UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
        cell.NameLabel.textColor = UIColor.white
        cell.NameLabel.textAlignment = .center
        cell.selectionStyle = .none
        cell.NameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.BioLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return cell
    }
}
