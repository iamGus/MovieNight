//
//  MovieCell.swift
//  MovieNight
//
//  Created by Angus Muller on 05/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let reuseIdentifier = "MovieCell"
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialisation code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: MovieCellViewModel) {
        artworkView.image = viewModel.image
        movieTitleLabel.text = viewModel.title
        ratingLabel.text = viewModel.avereageVote
    }

}
