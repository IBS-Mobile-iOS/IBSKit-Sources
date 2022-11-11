//
//  IBSCore.cpp
//  IBS Core
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

#include "IBSCore.hpp"
#include <iostream>



// MARK: - Main function

///
/// The main function that runs when the application starts.
///
/// - Parameters:
///    - argc: Number of arguments to accept when calling a function.
///    - argv: List of accepted arguments when calling a function.
///
/// - Authors: Dmitry Novikov
///
/// - Bug: None
///
int main(int argc,
         const char * argv[]) {
    std::cout << "Hello, IBS Core!" << std::endl;

    return EXIT_SUCCESS;
}
