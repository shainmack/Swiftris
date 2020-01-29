//
//  Array2D.swift
//  Swiftris
//
//  Created by Shain Toth on 1/29/20.
//  Copyright © 2020 Shain Toth. All rights reserved.
//

class Array2D<T> {
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(repeating: nil, count:rows * columns)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(row * column) + column]
        }
        set(newValue){
            array[(row * column) + column] = newValue
        }
    }
}
