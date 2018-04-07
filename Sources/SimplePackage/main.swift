
import Foundation

let args = Array(CommandLine.arguments.dropFirst())

func ask() {
    standardOut("Ask a question? (y/n)")
    let line = readLine()
    if line == "y" {
        ask()
    }
}

func printHello() {
    standardOut("hello \(Date())")
    sleep(2)
    printHello()
}

func standardOut(_ string: String, terminator: String = "\n") {
    guard let data = "\(string)\(terminator)".data(using: .utf8) else { return }
    FileHandle.standardOutput.write(data)
}

func standardError(_ string: String, terminator: String = "\n") {
    guard let data = "\(string)\(terminator)".data(using: .utf8) else { return }
    FileHandle.standardError.write(data)
}

if args.first == "help" || args.first == "-h" || args.first == "--help" {
    standardOut("commands:\n  input - asks for input\n  continue - continually prints\n  error - returns error\n  help - this help")
} else if args.first == "input" {
    ask()
} else if args.first == "error" {
    standardError("this is an error")
    exit(1)
} else if args.first == "continue" {
    printHello()
} else {
    standardOut("4.0.0")
}
