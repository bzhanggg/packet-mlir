# Parpack MLIR Project

The Parallel Packet Processing (Parpack) project is an attempt to build a DSL for network packet processing, specifically for optimizing single-threaded code into multi-threaded code.

## Repository Structure

This repository is split as follows:

```none
.
├── external
│   └── llvm-project
├── src
│   └── Dialect
│       ├── Packet
│       └── Parallel
├── tests
├── tools
│   └── parpack-opt.cpp
└── *.sh
```

The `llvm-project` is included as a submodule for build dependencies, such as headers and TableGen files.

The `src` directory contains the MLIR Dialect definitions for our DSL, split broadly into two categories, `Packet` and `Parallel`.

- The `Packet` dialect focuses on packet-related data structures such as TCP/IP/ethernet headers.
- The `Parallel` dialect focuses on synchronization and multithreading primitives.

The `tests` contains the regression tests for the project, which uses LLVM-lit to detect and run on `.mlir` files. You can inspect the `lit.cmake` files to see how these testing functions work. More on testing can be found below.

The `tools` directory is where the primary MLIR runner resides. `parpack-opt.cpp` is responsible for registering our custom dialects so MLIR actually recognizes our language at runtime and can get the necessary contexts needed for our custom types, operations, optimizations, etc. The target binary that is created by CMake will be `parpack-opt`.

## Building and Testing

For convenience, we have included three shell scripts that automate the building and testing of the project. Everything here has been done on a MacOS system using `AppleClang 16.0.0.x` for the C/CXX compiler. It should be easy to adapt this to a Linux system too.

- `build_deps.sh` is responsible for setting up the LLVM/MLIR project and creating the binaries needed for TableGen, lit testing, etc. You should only have to run this once on your machine to set up the LLVM binaries.
- `build_tests.sh` will build the `parpack-opt` binary and our custom Dialects. It will also run the lit tests using the `check-mlir-parpack` CMake target.
- `run_tests.sh` only runs lit tests using the `check-mlir-parpack` CMake target. Use this to quickly check if the tests you write are sound.

To learn more about how CMake build works, see the [CMake Tutorial](https://cmake.org/cmake/help/latest/guide/tutorial/index.html). To learn more about LLVM lit and FileCheck testing, see [lit](https://llvm.org/docs/CommandGuide/lit.html) and [FileCheck](https://llvm.org/docs/CommandGuide/FileCheck.html), as well as the [MLIR testing docs](https://mlir.llvm.org/getting_started/TestingGuide/). You can also try snooping around the LLVM discussion forums to see what other people are trying with testing, for example my question about [e2e testing](https://discourse.llvm.org/t/understanding-lit-testing-with-mlir/85622).

> Note (2025.5): I have been having issues with getting `mlir-runner` and FileCheck to work for MLIR integration testing. You can try running the `increment_counter.mlir` test and FileCheck will complain that `<stdin>` is empty, even though the necessary pipe has been specified, and the resulting value is outputted to the text file specified in the `mlir-runner` command.

## Working with MLIR

There's not a lot of material out there that is really user-friendly with MLIR. There is a steep learning curve and very few guides that truly assume zero knowledge about LLVM/MLIR. The official MLIR tutorial is difficult to follow along, and focuses mostly on ML applications, but it's better than nothing. Here are a few resources:

1. The official [MLIR Toy tutorial](https://mlir.llvm.org/docs/Tutorials/Toy/)
2. Jeremy Kun's [MLIR for Beginners tutorial](https://github.com/j2kun/mlir-tutorial)
3. The UT NS lab's [Alkali](https://github.com/utnslab/Alkali) networking project written in MLIR

### Some Personal Takeaways of MLIR development

(2025.5) One of the most difficult learning curves regarding MLIR is really understanding how Dialects are defined and how a compiler engineer interacts with it. At a surface level, a Dialect is just a collection of grammatical syntax with no well-defined attached meaning to it. What I mean by this is that it is very easy to fall into the trap of having one idea of what a particular Operation should do, or what a Type should represent, without actually attaching some known behavior to it. To attach behavior, you have to turn every one of your custom Dialect constructs into a known MLIR one through a sequence of lowerings. What you'll often see in MLIR discussions or in documentation is the `-lower-to-affine` or `-lower-to-llvm` flag, where you start rewriting your custom operations or types into something MLIR actually can recognize.

Another way of understanding this is that everything you do ultimately serves the purpose of writing AST-to-AST transformations. Types and Operations allow you to create an AST of your Dialect, and Optimizations are AST-to-AST transformations that map from your Dialect to your Dialect, but somehow change the behavior of the Dialect. If you are familiar with algebraic maps, you may call this an endomorphism of AST trees.

On the other hand, a Lowering pass is an AST-to-AST transformation that maps from one (set of) Dialects to another, distinct (set of) Dialects. In algebra, you might call this an isomorphism of AST trees. Here, the behavior of the input and output ASTs are the same, just expressed in a different Dialect.

> I say a "set of" Dialects here because Dialects are designed to coexist with each other. You can have two Dialects present at the same time in the same program, for example combining `affine` and `scf` to allow for both `for` loops (defined in affine) and `while` loops (defined in scf).

The goal of a successful MLIR pipeline, then, is to combine a sequence of optimizations and lowerings to map from your custom Dialect AST down to the LLVM dialect's AST. Once you have everything written in terms of the LLVM dialect, we can compile down to machine code and have a working binary.

## Specific Knowledge for Parpack

Parpack is widely partitioned into two dialects, one for parallelism and another to represent the TCP/IP stack. They are being developed in two separate branches:

- `/main` develops the parallel dialect.
- `/packet-dialect` and `/proto_enum` develop the packet dialect.

Our goal is to flesh out the parallel dialect first, and only then work on developing the necessary tooling to adapt parallelism to packet processing via the packet dialect. You can explore the barebones packet dialect for yourself, but the following discussion will exclusively be on the parallel dialect.

### The Parallel Dialect

The Parallel dialect currently consists of exactly one type, called `counter`. This type a wrapper around a simple unsigned 32-bit integer, which can be represented in MLIR's LLVM dialect as a `llvm.mlir.global : i32`. The intent of the counter is to allow for safe atomic operations to allow for implementation of locks, mutexes, semaphores, etc. I define a few operations on the counter, as follows:

| Operation    | Description |
| -------- | ------- |
| `inc`  | Increment a counter by 1. |
| `set` | Set a counter to a value.  |
| `get`    | Retrieve a value of a counter. |

See the [`ParallelOps.td`](src/Dialect/Parallel/ParallelOps.td) file for more details on how the operation calls and arguments are formatted. We intend to design lowering passes to transform these operations into LLVM native operations. The desired behavior of all of these operations can be found in [`increment_counter.mlir`](tests/increment_counter.mlir).
