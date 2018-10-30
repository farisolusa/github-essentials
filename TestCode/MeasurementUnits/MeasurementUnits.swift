//
//  MeasurementUnits.swift
//  TestCode
//
//  Created by Anil Prasad on 10/19/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation
import UIKit

func measurementU() {
    // MARK: Length
    let meters = Measurement(value: 5, unit: UnitLength.meters)
    let kiloMeters = Measurement(value: 1, unit: UnitLength.kilometers)
    
    let result = meters + kiloMeters
    //type(of: result)
    print(result.value)
    
    let finalKilometers = result.converted(to: .kilometers)
    let finalMiles = result.converted(to: .miles)
    let finalMeters = result.converted(to: .meters)
    let finalScandinavianMiles = result.converted(to: .scandinavianMiles)
    let finalAstronomicalUnits = result.converted(to: .astronomicalUnits)
    
    print(finalMiles.unit.symbol) // Returns string "mi"
    
    //MARK: Angle
    let gradians = Measurement(value: 200, unit: UnitAngle.gradians)
    let finalDegree = gradians.converted(to: .degrees) //180.0 °
    
    //MARK: Time
    /*
    let trainJourneyDuration = Measurement(value: 1.25, unit: UnitDuration.hours)
     Use it directly or create an extension to save time
    */
    let trainJourneyDuration = (1.25).hours
    let trainJourneyInMinutes = trainJourneyDuration.converted(to: .minutes) // 75 minutes
    
    // Concatenate above lines of code
    let planeJourneyDuration = (320.0).minutes.converted(to: .hours) // 5.333 hr
    let boatJourneyDuration = (1500.0).seconds.converted(to: .minutes)
    
    let totalDuration = [
        trainJourneyDuration,
        planeJourneyDuration,
        boatJourneyDuration
    ]
    
    let totalJourneyTime = totalDuration.reduce(0.0) {
        return $0 + $1.converted(to: UnitDuration.minutes).value
    }
    print(totalJourneyTime)
    
    var remainingTime = Measurement(value: 1, unit: UnitDuration.minutes)
    /*
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        let secondsRemaining = remainingTime.converted(to: UnitDuration.seconds)
        
        print("\(secondsRemaining.value) seconds remaining before it stops")
        remainingTime = remainingTime - (1.0).seconds // Extension
        
        if remainingTime.value <= 0.0 {
            timer.invalidate()
        }
    }
    */
    
    //MARK: Volumes
    
    let milk = Measurement(value: 2, unit: UnitVolume.liters)
    let cream = Measurement(value: 3, unit: UnitVolume.deciliters)
    let water = Measurement(value: 1, unit: UnitVolume.pints)
    
    let total = milk + cream + water
    let totalDecileters = total.converted(to: .tablespoons)
    let totalLiters = total.converted(to: .tablespoons)
    let totalPints = total.converted(to: .cups)
    
    [totalDecileters, totalLiters, totalPints].forEach{showInfo(for: $0)}
    /*
    prints:
    187.54402575269836, tbsp
    187.54402575269836, tbsp
    11.5549, cup
    */
}

func showInfo(for measurement: Measurement<UnitVolume>) {
    let value = measurement.value
    let symbol = measurement.unit.symbol
    print("\(value), \(symbol)")
}

extension Double {
    var hours: Measurement<UnitDuration> {
        return Measurement(value: self, unit: UnitDuration.hours)
    }
    var minutes: Measurement<UnitDuration> {
        return Measurement(value: self, unit: UnitDuration.minutes)
    }
    var seconds: Measurement<UnitDuration> {
        return Measurement(value: self, unit: UnitDuration.seconds)
    }
}
