//
//  FileLoader.swift
//  iORA
//
//  Created by Jared Rossberg on 9/28/21.
//  Copyright © 2021 Gabriel Reed. All rights reserved.
//

import Foundation

public enum ReadFileError: Error {
    case invalidFileFormat
    case noFileProvided
    case doesNotExist
    case couldNotOpen
}

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}

public class FileLoader {
    private var ignoreLinesStart: Int
    private var ignoreLinesEnd: Int
    private var numAtoms: Int
    private var numBonds: Int
    private var arrayAtoms: [Atom]
    private var arrayBonds: [Bond]
    private var reaction = Reaction()
    
    public init() {
        self.ignoreLinesStart = 0
        self.ignoreLinesEnd = 0
        self.numAtoms = 0
        self.numBonds = 0
        self.arrayAtoms = []
        self.arrayBonds = []
        self.reaction = Reaction()
    }
    
    public func parseReactionFile(inputFile: URL?) throws -> FileLoader {
        self.reaction = Reaction()
        self.resetVars()
        if let inputFile = inputFile {
            try self.parseSdfFile(inputFile: inputFile)
        } else {
            throw ReadFileError.noFileProvided
        }
        return self
    }
    
    public func getReaction() -> Reaction {
        return self.reaction
    }
    
    private func resetVars() {
        self.ignoreLinesStart = 3
        self.ignoreLinesEnd = 2
        self.numAtoms = -1
        self.numBonds = -1
        self.arrayAtoms = []
        self.arrayBonds = []
    }
    
    private func parseSdfFile(inputFile: URL) throws {
        guard FileManager.default.fileExists(atPath: inputFile.path) else {
            throw ReadFileError.doesNotExist
        }
        guard let filePointer:UnsafeMutablePointer<FILE> = fopen(inputFile.path ,"r") else {
            throw ReadFileError.couldNotOpen
        }
        defer {
            fclose(filePointer)
        }
        
        var lineByteArrayPointer: UnsafeMutablePointer<CChar>? = nil
        var lineCap: Int = 0
        let nextLine = {
            return getline(&lineByteArrayPointer, &lineCap, filePointer)
        }
        defer {
            lineByteArrayPointer?.deallocate()
        }
        var bytesRead = nextLine()
        
        while (bytesRead > 0) {
            guard let linePointer = lineByteArrayPointer else {
                break
            }
            var lineString = String.init(cString: linePointer)
            if lineString.last?.isNewline == true {
                lineString = String(lineString.dropLast())
            }
            
            try self.processLine(lineString)
            
            bytesRead = nextLine()
        }
    }
    
    private func processLine(_ lineString: String) throws {
        if self.ignoreLinesStart > 0 {
            self.ignoreLinesStart -= 1
        }
        else if self.numAtoms < 0 && self.numBonds < 0 {
            let words = lineString.condenseWhitespace().components(separatedBy: " ")
            guard words.count >= 2 else {
                throw ReadFileError.invalidFileFormat
            }
            if let numAtoms = Int(words[0]),
               let numBonds = Int(words[1]) {
                self.numAtoms = numAtoms
                self.numBonds = numBonds
            } else {
                throw ReadFileError.invalidFileFormat
            }
        }
        else if self.numAtoms > 0 {
            let words = lineString.condenseWhitespace().components(separatedBy: " ")
            guard words.count >= 4 else {
                throw ReadFileError.invalidFileFormat
            }
            let symbol = words[3]
            if let xPos = Double(words[0]),
               let yPos = Double(words[1]),
               let zPos = Double(words[2]) {
                self.arrayAtoms.append(Atom(symbol: symbol, x: xPos, y: yPos, z: zPos))
                self.numAtoms -= 1
            } else {
                throw ReadFileError.invalidFileFormat
            }
        }
        else if self.numBonds > 0 {
            let words = lineString.condenseWhitespace().components(separatedBy: " ")
            guard words.count >= 3 else {
                throw ReadFileError.invalidFileFormat
            }
            if let atom1 = Int(words[0]),
               let atom2 = Int(words[1]),
               let order = Int(words[2]) {
                guard self.arrayAtoms.count >= atom1 && self.arrayAtoms.count >= atom2 else {
                    throw ReadFileError.invalidFileFormat
                }
                self.arrayBonds.append(Bond(self.arrayAtoms[atom1-1], self.arrayAtoms[atom2-1], order))
                self.numBonds -= 1
            } else {
                throw ReadFileError.invalidFileFormat
            }
        }
        else if self.ignoreLinesEnd > 0 {
            self.ignoreLinesEnd -= 1
        }
        
        if self.ignoreLinesStart == 0 && self.numAtoms == 0 && self.numBonds == 0 {
            if self.ignoreLinesEnd == 1 {
                self.reaction.addState(State.init(atoms: self.arrayAtoms, bonds: self.arrayBonds))
            }
            else if self.ignoreLinesEnd == 0 {
                self.resetVars()
            }
        }
    }
    
}

