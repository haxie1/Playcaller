//
//  PlaysheetTableViewCell.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/28/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import UIKit
class TitleSlab: UIView {
    @IBOutlet weak var title: UILabel!
}

enum PlayResultType: Int {
    case progress
    case penalty
    case turnover
}

class ResultPickerSlab: UIView {
    var handleResultPickerChange: (PlayResultType) -> Void = { _ in }
    @IBOutlet var detailSlabs: [PlayResultDetailSlab]!
    @IBOutlet weak var resultPicker: UISegmentedControl!
    @IBOutlet weak var slabDetailContainer: UIStackView!
    
    @IBAction func resultPickerChanged(sender: AnyObject?) {
        let pickerIndex = self.resultPicker.selectedSegmentIndex
        let result = PlayResultType(rawValue: pickerIndex)!
        if let current = self.slabDetailContainer.arrangedSubviews.first {
            current.removeFromSuperview()
        }
        
        switch result {
        case .progress:
            let slab = self.detailSlabs.first { $0 is ProgressSlab }!
            self.slabDetailContainer.addArrangedSubview(slab)
            break
        case .penalty:
            let slab = self.detailSlabs.first { $0 is PenaltySlab }!
            self.slabDetailContainer.addArrangedSubview(slab)
            break
        case .turnover:
            let slab = self.detailSlabs.first { $0 is TurnoverSlab }!
            self.slabDetailContainer.addArrangedSubview(slab)
            break
        }
        self.slabDetailContainer.layoutIfNeeded()
        self.handleResultPickerChange(result)
    }
    
    @IBOutlet weak var detailSlabContainer: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isHidden: Bool {
        set {
            super.isHidden = newValue
            if !newValue {
                if let resultPicker = self.resultPicker {
                    self.resultPickerChanged(sender: resultPicker)
                }
            }
        }
        get {
            return super.isHidden
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // keep this event from reaching the tableview so that a touch on the background doesn't dismiss the expanded view, which can be easy to do when trying to quickly tap on controls.
    }
}

class PlayResultDetailSlab: UIView {
    
}

class ProgressSlab: PlayResultDetailSlab {
    @IBOutlet weak var progressSlider: UISlider!
    @IBAction func progressChanged(sender: UISlider?) {
        
    }
}

class PenaltySlab: PlayResultDetailSlab {}
class TurnoverSlab: PlayResultDetailSlab {}

class PlaysheetTableViewCell: UITableViewCell {
    @IBOutlet weak var slabStackView: UIStackView!
    
    @IBOutlet weak var titleSlab: TitleSlab!
    @IBOutlet weak var playResultSlab: ResultPickerSlab! {
        didSet {
            if let resultSlab = playResultSlab {
                resultSlab.isHidden = true
                resultSlab.handleResultPickerChange = { (playResultType) in
                    print("got a picker change")
                }
            }
        }
    }
    
    var viewModel: PlayViewModel? {
        didSet {
            self.titleSlab.title.text = viewModel?.title ?? "Untitled"
        }
    }
    
    var hidePlaybackResultsSlab: Bool = true {
        didSet {
            if !hidePlaybackResultsSlab {
                self.backgroundColor = UIColor.white.withAlphaComponent(0.1)
            } else {
                self.backgroundColor = UIColor.clear
            }

            self.playResultSlab.isHidden = self.hidePlaybackResultsSlab
            self.slabStackView.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
