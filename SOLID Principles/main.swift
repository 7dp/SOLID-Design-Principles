//
//  main.swift
//  SOLID Principles
//
//  Created by Crocodic on 21/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//
// MARK: - S.O.L.I.D Principles
// MARK: Single Responsibility Principle
// MARK: Open/Closed Principle
// MARK: Liskov Substitution Principle
// MARK: Interface Segregation Principle
// MARK: Dependency Inversion Principle -

import Foundation

// MARK: - Protocol
protocol SwitchOption {
	func turnOn()
	func turnOff()
}

protocol ModeOption {
	func changeMode()
}

protocol SpeedOption {
	func changeFanSpeed()
}

protocol HumidityOption {
	func changeHumidity(humidityNumber: Int)
}

protocol Cost {
	func price() -> Int
}

protocol AutoOffOption {
	func autoShutdownAfter(duration: Int)
}

protocol StandardACFeatures: SwitchOption, ModeOption, SpeedOption, HumidityOption, Cost {
	
}

protocol EliteACFeatures: StandardACFeatures, AutoOffOption {
	
}

// MARK: - Implementation Class
class Switch: SwitchOption {
	func turnOn() {
		print("Turn on AC")
	}
	
	func turnOff() {
		print("Turn off AC")
	}
}

class Mode: ModeOption {
	func changeMode() {
		print("Mode has been changed")
	}
}

class Speed: SpeedOption {
	func changeFanSpeed() {
		print("Fan speed changed")
	}
}

class Humidity: HumidityOption {
	func changeHumidity(humidityNumber: Int) {
		print("Humidity has been changed to", humidityNumber)
	}
}

class AutoOff: AutoOffOption {
	func autoShutdownAfter(duration: Int) {
		print("AC will shutdown in \(duration) minutes")
	}
}


// MARK: - Class
class FullPriceAirConditioner: StandardACFeatures {
	let switchController = Switch()
	let modeController = Mode()
	let speedController = Speed()

	func turnOn() {
		self.switchController.turnOn()
	}
	
	func turnOff() {
		self.switchController.turnOff()
	}
	
	func changeMode() {
		self.modeController.changeMode()
	}
	
	func changeFanSpeed() {
		self.speedController.changeFanSpeed()
	}
	
	func price() -> Int {
		let price = 1_000_000
		print("FullPriceAirConditioner price = ", price)
		return price
	}
}

extension FullPriceAirConditioner: HumidityOption, AutoOffOption {
	func changeHumidity(humidityNumber: Int) {
		let humidityController = Humidity()
		humidityController.changeHumidity(humidityNumber: humidityNumber)
	}
	
	func autoShutdownAfter(duration: Int) {
		let autoOffController = AutoOff()
		autoOffController.autoShutdownAfter(duration: duration)
	}
}

class ExpensiveAirConditioner: EliteACFeatures {
	private let switchCtrl = Switch()
	private let modeCtrl = Mode()
	private let speedCtrl = Speed()
	private let humidityCtrl = Humidity()
	private let autoOffCtrl = AutoOff()
	
	func turnOn() {
		switchCtrl.turnOn()
	}
	
	func turnOff() {
		switchCtrl.turnOff()
	}
	
	func changeMode() {
		modeCtrl.changeMode()
	}
	
	func changeFanSpeed() {
		speedCtrl.changeFanSpeed()
	}
	
	func changeHumidity(humidityNumber: Int) {
		humidityCtrl.changeHumidity(humidityNumber: humidityNumber)
	}
	
	func price() -> Int {
		let price = 1_950_000
		print("ExpensiveAirConditioner price = ", price)
		return price
	}
	
	func autoShutdownAfter(duration: Int) {
		autoOffCtrl.autoShutdownAfter(duration: duration)
	}
}


class DiscountedAirConditioner: StandardACFeatures {
	private let acProduct: EliteACFeatures
	
	init(_ ac: EliteACFeatures) {
		self.acProduct = ac
	}
	
	func turnOn() {
		self.acProduct.turnOn()
	}
	
	func turnOff() {
		self.acProduct.turnOff()
	}
	
	func changeMode() {
		self.acProduct.changeMode()
	}
	
	func changeFanSpeed() {
		self.acProduct.changeFanSpeed()
	}
	
	func changeHumidity(humidityNumber: Int) {
		self.acProduct.changeHumidity(humidityNumber: humidityNumber)
	}
	
	func price() -> Int {
		let discountedPrice = Double(self.acProduct.price()) * 0.75
		print("DiscountedAirConditioner price = ", discountedPrice)
		return Int(discountedPrice)
	}
	
}

let fullPriceAC = FullPriceAirConditioner()
fullPriceAC.changeHumidity(humidityNumber: 10)
fullPriceAC.autoShutdownAfter(duration: 25)

let samsungAC = ExpensiveAirConditioner()
samsungAC.turnOn()
samsungAC.changeMode()
samsungAC.changeHumidity(humidityNumber: 13)
samsungAC.changeFanSpeed()
samsungAC.autoShutdownAfter(duration: 60)

let discountedAC = DiscountedAirConditioner(samsungAC)
let _ = discountedAC.price()
discountedAC.changeHumidity(humidityNumber: 5)

