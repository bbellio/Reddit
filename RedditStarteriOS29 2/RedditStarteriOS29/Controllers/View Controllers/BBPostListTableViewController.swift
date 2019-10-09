//
//  BBPostListTableViewController.swift
//  RedditStarteriOS29
//
//  Created by Bethany Wride on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class BBPostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        BBPostController.sharedInstance().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Posts array (source of truth) was empty")
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BBPostController.sharedInstance().posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? BBPostTableViewCell else { return UITableViewCell()}
        let post = BBPostController.sharedInstance().posts[indexPath.row]
        cell.postTitleLabel.text = post.title
//        cell.postImageView.image = nil
        BBPostController.sharedInstance().fetchImage(for: post) { (image) in
            // Could also be written as if let statement
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.postImageView.image = image
            }
        }
        return cell
    }
}
