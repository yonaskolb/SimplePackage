
import Foundation

invalid
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

func standardError(_ string: String, terminator: String = "\n") -> Never {
    guard let data = "\(string)\(terminator)".data(using: .utf8) else { exit(1) }
    FileHandle.standardError.write(data)
    exit(1)
}

if args.first == "help" || args.first == "-h" || args.first == "--help" {
    standardOut("commands:\n  input - asks for input\n  continue - continually prints\n  error - returns error\n  help - this help")
} else if args.first == "input" {
    ask()
} else if args.first == "error" {
    standardError("this is an error")
} else if args.first == "continue" {
    printHello()
} else if args.first == "env" {
    guard args.count >= 2 else {
        standardError("must pass env name")
    }
    let envName = args[1]
    guard let env = ProcessInfo.processInfo.environment[envName] else {
        standardError("\(envName) not found")
    }
    print(env)
} else {
    standardOut("5.0.0")
}
