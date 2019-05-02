//
//  LocationAnnotationView.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/30/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit
import MapKit
class LocationAnnotationView: MKAnnotationView , DisplayableCell {

    static var identifier: String = "LocationAnnotation"
    static var nibName: String = "LocationAnnotationView"
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var containerView : UIView?
    @IBOutlet weak var contentView : UIView?
    @IBOutlet weak var label: UILabel!
    // ... Other outlets
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    func setup() {
        
        guard let nibView = loadViewFromNib() else {
            return
        }
        
        contentView = nibView
        
        backgroundColor = UIColor.clear
        contentView?.backgroundColor = UIColor.clear
//        contentView?.layer.cornerRadius = 10
//        containerView?.layer.cornerRadius = 10
        containerView?.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        containerView?.layer.shadowOpacity = 0.4
        containerView?.layer.shadowOffset = CGSize.zero
        containerView?.layer.shadowRadius = 4
        
        bounds = nibView.frame
        addSubview(nibView)
        
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        containerView?.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        containerView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let name =  "LocationAnnotationView"
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bounds = containerView!.bounds
    }
    override func prepareForReuse() {
        super.layoutSubviews()
        bounds = containerView!.bounds
        
    }

}
