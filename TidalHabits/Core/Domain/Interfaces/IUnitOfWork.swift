//
//  IUnitOfWork.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Unit of Work pattern interface for managing transactions.
///
/// Reference: amantinband/clean-architecture
/// Similar to .NET's IUnitOfWork pattern
protocol IUnitOfWork {
    func saveChangesAsync() async throws
}
