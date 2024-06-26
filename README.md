# Project "xiuxiueig"

> This project is under initial development

The "xiuxiueig" project is an iOS app to help dyslexic students keep up with their lessons. It will allow them to manage a library of audio snippets for their studies and automatically schedule their study sessions.

**"Xiuxiueig"** means whisper in [Catalan](https://www.wordreference.com/definicio/xiuxiueig). The name was chosen by **my son Pau**.

> Developer's note: This project is over-engineered. It could have been developed with a simple architecture and a more direct implementation. Still, I use it to practice architecture skills and experiment with new ideas. It also means that it will evolve as I practice new things.

## Documentation

Every package contains a DocC documentation bundle with documentation on the package. Three, you will also find a `Requirements.md` file with the requirements implemented. All requirements will have a reference to help identify the test that covers those requirements.

> NOTE: I have not defined a place yet to add documentation about the architecture. I'll do that soon.

## Process

Since this is a very small team project (single person) I'm following this small process with minimum overhead to move quickly but with quality.

1. I use projects on Github to plan and decide the features to tackle next.
2. I use [monodraw](https://monodraw.helftone.com) for architectural design. The files are in the `design` folder.
3. During implementations, I use the `Requirements.md` file to keep track of the individual features added to a package. You will see that the test refers to those by ID, so I can trace any test back to a requirement and better assess functional coverage.

## Swiftlint

This projects uses [`swiftlint`](https://github.com/realm/SwiftLint). Install it with homebrew `brew install swiftlint`.

## On Naming

The prefix `X` or `XX` is used to identify public containers or types designed exclusively for the app. It is used to avoid conflicts with other systems or imported types. Internal types won't generally use any prefixes.
