//
//  main.swift
//  CodeStarterCamp_Week3
//
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct Person {
    var money: Int = 0
    
    func isPaymentEnable(for beveragePrice: Int) -> Bool {
        if beveragePrice > self.money {
            print("잔액이 \(beveragePrice - self.money)원만큼 부족합니다.")
            return false
        } else {
            return true
        }
    }
    
    mutating func order(_ coffee: Coffee, of coffeeShop: inout CoffeeShop, by name: String) {
        guard let coffeePrice = coffeeShop.checkPrice(coffee) else { return }
        guard self.isPaymentEnable(for: coffeePrice) else { return }
        self.money -= coffeePrice
        coffeeShop.processPurchase(for: coffee, with: coffeePrice, from: name)
    }
}

enum Coffee: String {
    case espresso = "에스프레소"
    case americano = "아메리카노"
    case latte = "라떼"
    case decaffeinatedAmericano = "디카페인 아메리카노"
    case cappuccino = "카푸치노"
}

struct CoffeeShop {
    var menu: Dictionary<Coffee, Int>
    var barista: Person
    typealias pickUpTableTypes = (name: String, coffee: Coffee)
    var pickUpTable: Array<pickUpTableTypes> = Array<pickUpTableTypes>() {
        willSet {
            guard let name = newValue.last?.name else { return }
            guard let coffee = newValue.last?.coffee.rawValue else { return }
            print("\(name) 님이 주문하신 \(coffee)(이/가) 준비되었습니다. 픽업대에서 가져가주세요.")
        }
    }
    var revenue: Int = 0
    
    func checkPrice(_ coffee: Coffee) -> Int? {
        guard let coffeePrice = self.menu[coffee] else {
            print("주문하신 메뉴가 존재하지 않습니다.")
            return nil
        }
        return coffeePrice
    }
    
    mutating func make(_ coffee: Coffee, for name: String) {
        print("커피 추출중...")
        self.pickUpTable.append((name: name, coffee: coffee))
    }
    
    mutating func processPurchase(for coffee: Coffee, with price: Int, from name: String) {
        self.revenue += price
        self.make(coffee, for: name)
    }
}

var misterLee = Person()
var missKim = Person(money: 10000)
var zzanggoo = Person(money: 5000)
var minhyunm = Person(money: 2000)
var yagombucks = CoffeeShop(menu: [Coffee.espresso: 3000,
                                   Coffee.americano: 3500,
                                   Coffee.latte: 4000,
                                   Coffee.cappuccino: 4500],
                            barista: misterLee)

missKim.order(Coffee.cappuccino, of: &yagombucks, by: "missKim")
zzanggoo.order(Coffee.americano, of: &yagombucks, by: "커피를못마시는짱구")
minhyunm.order(Coffee.americano, of: &yagombucks, by: "minhyunm")


