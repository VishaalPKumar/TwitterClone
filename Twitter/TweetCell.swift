//
//  TweetCell.swift
//  Twitter
//
//  Created by Vishaal Kumar on 10/11/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none;

    }

    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweet(true)
        }, failure: { (error) in
            print("Retweeting did not succeed : \(error)")
        })
        
    }
    
    var isFavourite : Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    
    func setFavourite(_ fav : Bool) {
        isFavourite = fav
        if(isFavourite) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
    }
    
    func setRetweet(_ isRetweeted : Bool) {
        retweeted = isRetweeted
        if(retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            retweetButton.isEnabled = true

        }
    }
    @IBAction func favouriteTweet(_ sender: Any) {
        let toBeFavourite = !isFavourite
        if(toBeFavourite) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavourite(true)
            }, failure: { (error) in
                print("Marking as favourite did not succeed : \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavourite(false)
            }, failure: { (error) in
                print("Marking as unfavourite did not succeed : \(error)")
            })
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
