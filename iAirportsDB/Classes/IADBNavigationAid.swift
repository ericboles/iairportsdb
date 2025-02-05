//
//  IADBNavigationAid.swift
//  iAirportsDB
//
//  Created by Christopher Hobbs on 8/21/16.
//  Copyright © 2016 Toonsy Net. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

@objc(IADBNavigationAid)
open class IADBNavigationAid: IADBLocation {
    @NSManaged open var dmeKhz: Int32
    @NSManaged open var elevationFeet: NSNumber?
    @NSManaged open var khz: Int32
    @NSManaged open var name: String
    @NSManaged open var type: String
    
    open lazy var mhz:Double = {
        return Double(self.khz) / 1000.0
    }()

    override open func setCsvValues( _ values: [String: String] ) {
        //"id","filename","ident","name","type","frequency_khz","latitude_deg","longitude_deg","elevation_ft","iso_country","dme_frequency_khz","dme_channel","dme_latitude_deg","dme_longitude_deg","dme_elevation_ft","slaved_variation_deg","magnetic_variation_deg","usageType","power","associated_airport",
        //print(values)
        
        self.dmeKhz = Int32(values["dme_frequency_khz"]!) ?? -1
        self.elevationFeet = IADBModel.parseIntNumber(text:values["elevation_ft"])
        self.identifier = values["ident"] ?? ""
        self.khz = Int32(values["frequency_khz"]!) ?? -1
        self.latitude = Double(values["latitude_deg"]!)!
        self.longitude = Double(values["longitude_deg"]!)!
        self.name = values["name"] ?? ""
        self.type = values["type"] ?? ""
    }

    //begin convenience functions for type casting
    open override class func findNear(_ location: CLLocation, withinNM distance: CLLocationDistance) -> IADBCenteredArrayNavigationAids {
        return IADBCenteredArrayNavigationAids(centeredArray: super.findNear(location, withinNM: distance))
    }
    
    
    open override class func find(identifier: String) -> IADBNavigationAid? {
        let model = super.find(identifier:identifier)
        guard let typed = model as? IADBNavigationAid else {
            print("Invalid type found \(String(describing: model))")
            return nil
        }
        return typed
    }
    open override class func findAll(identifier: String) -> IADBCenteredArrayNavigationAids {
        return IADBCenteredArrayNavigationAids(centeredArray: super.findAll(identifier:identifier))
    }
    open override class func findAll(identifier: String, types: [String]?) -> IADBCenteredArrayNavigationAids {
        return IADBCenteredArrayNavigationAids(centeredArray: super.findAll(identifier:identifier, types: types))
    }
    open override class func findAll(identifiers: [String], types: [String]?) -> IADBCenteredArrayNavigationAids {
        return IADBCenteredArrayNavigationAids(centeredArray: super.findAll(identifiers:identifiers, types: types))
    }
    open override class func findAll(predicate: NSPredicate) -> IADBCenteredArrayNavigationAids {
        return IADBCenteredArrayNavigationAids(centeredArray: super.findAll(predicate:predicate))
    }
    //end convenience functions
}
