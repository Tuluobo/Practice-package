//
//  YYClassInfo.swift
//  YYModel.Swift
//
//  Created by WangHao on 15/11/27.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import Foundation

enum YYEncodingType: UInt {
    case Mask       = 0x1F
    case Unknown    = 0
    case Void
    case Bool
    case Int8
    case UInt8
    case Int16
    case UInt16
    case Int32
    case UInt32
    case Int64
    case UInt64
    case Float
    case Double
    case LongDouble
    case Object
    case Class
    case SEL
    case Block
    case Pointer
    case Struct
    case Union
    case CString
    case CArray
    
    
}