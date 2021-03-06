//
//  ScheduleCollectionViewCell.swift
//  prkng-ios
//
//  Created by Cagdas Altinkaya on 03/04/15.
//  Copyright (c) 2015 PRKNG. All rights reserved.
//

import UIKit

class ScheduleItemView : UIView {
    
    private var containerView : UIView
    private var imageView : UIImageView
    
    var rule: ParkingRule
    
    private var didSetupSubviews : Bool
    private var didSetupConstraints : Bool
    
    convenience init(model: ScheduleItemModel) {
        self.init(frame:CGRectZero)
        
        self.rule = model.rule
        
        switch self.rule.ruleType {
        case .Free:
            //.free not supported in schedule items at the moment!
            break
        case .SnowRestriction:
            imageView = ViewFactory.snowflakeIcon(Styles.Colors.white)
            break
        case .Restriction:
            imageView = ViewFactory.forbiddenIcon(Styles.Colors.berry2)
            break
        case .TimeMax:
            imageView = ViewFactory.timeMaxIcon(Int(model.limit/60), addMaxLabel: true, color: Styles.Colors.cream2)
            break
        case .Paid:
            var rateString = model.rule.paidHourlyRateString
            if model.endInterval - model.startInterval < 4*3600 {
                rateString = ""
            }
            imageView = ViewFactory.paidIcon(rateString, color: Styles.Colors.curry)
            break
        case .PaidTimeMax:
            var rateString: String? = model.rule.paidHourlyRateString + "/H"
            if model.endInterval - model.startInterval < 4*3600 {
                rateString = nil
            }
            imageView = ViewFactory.timeMaxIcon(Int(model.limit/60), addMaxLabel: true, color: Styles.Colors.curry, secondLineString: rateString)
            break
        }
        
    }
    
    convenience init() {
        self.init(frame:CGRectZero)
    }
    
     override init(frame: CGRect) {
        
        containerView = UIView()
        imageView = UIImageView()
        
        didSetupSubviews = false
        didSetupConstraints = true
        
        rule = ParkingRule(ruleType: ParkingRuleType.Restriction)

        super.init(frame: frame)
        
    }

     required init?(coder aDecoder: NSCoder) {
         fatalError("NSCoding not supported")
     }
    
    override func layoutSubviews() {
        if (!didSetupSubviews) {
            setupSubviews()
            self.setNeedsUpdateConstraints()
        }
        
        super.layoutSubviews()
    }
    
    override func updateConstraints() {
        if(!didSetupConstraints) {
            setupConstraints()
        }
        
        super.updateConstraints()
    }
    
    
    func setupSubviews () {
        
        self.addSubview(containerView)
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        containerView.addSubview(imageView)
        
        switch self.rule.ruleType {
        case .Free:
            //.free not supported in schedule items at the moment!
            break
        case .Restriction:
            self.backgroundColor = Styles.Colors.red2
        case .SnowRestriction:
            self.backgroundColor = Styles.Colors.snowBlue
        case .TimeMax, .Paid, .PaidTimeMax:
            self.backgroundColor = Styles.Colors.midnight1
        }
        
        didSetupSubviews = true
        didSetupConstraints = false
    }
    
    
    func setupConstraints () {
        
        containerView.snp_makeConstraints { (make) -> () in
            make.edges.equalTo(self)
            make.center.equalTo(self)
        }
        
        imageView.snp_makeConstraints { (make) -> () in
            make.center.equalTo(self.containerView)
            make.size.lessThanOrEqualTo(CGSize(width: 25, height: 25))
            make.size.lessThanOrEqualTo(self.containerView).offset(-2)
        }
        
        didSetupConstraints = true
    }
    
}
