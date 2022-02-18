This repro corresponds to SwiftFormat/#1142.

To repro the issue:
```
git clone https://github.com/ncooke3/repros.git

cd swiftformat-1142

mint run swiftformat main.swift

chmod +x main.swift

./main.swift
```

Expected output when running `main.swift`:
```
main.swift:11:23: error: expected expression after operator
    return try bar ?? throw CustomError.emptyValue
```
