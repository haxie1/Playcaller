//
//  PlaysheetTableViewController.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/28/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit
struct PlayViewModel {
    var title: String = ""
    init(title: String) {
        self.title = title
    }
}

class PlaysheetTableViewController: UITableViewController {
    var plays: [PlayViewModel] = [PlayViewModel(title: "I Right 21 Dive"), PlayViewModel(title: "Wing Right 35 Blast"), PlayViewModel(title: "Pro Pass Right")]
    private var expandedCell: PlaysheetTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 56
        
        self.tableView.tableFooterView = UIView() // disable the empty cell separator lines.
        self.decorate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.plays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playsheetTableViewCell", for: indexPath) as! PlaysheetTableViewCell
        cell.selectionStyle = .none
        cell.viewModel = self.plays[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? PlaysheetTableViewCell {
            let shouldExpand = cell.playResultSlab.isHidden
            
            if shouldExpand {
                self.expandedCell?.hidePlaybackResultsSlab = true
                cell.hidePlaybackResultsSlab = false
                self.expandedCell = cell
            } else {
                cell.hidePlaybackResultsSlab = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func decorate() {
        let image = UIImage(named: "MainBackgroundImage")!
        let imageView = UIImageView(image: image)
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = self.tableView.bounds
        imageView.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [blurView.topAnchor.constraint(equalTo: imageView.topAnchor),
                           blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                           blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                           blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)]
        
        self.tableView.backgroundView = imageView
        imageView.frame = self.tableView.bounds
        NSLayoutConstraint.activate(constraints)
    }

}
