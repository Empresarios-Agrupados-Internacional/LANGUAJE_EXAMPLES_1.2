# LANGUAJE_EXAMPLES_1.2
EcosimPro LANGUAJE_EXAMPLES workspace. Libraries and examples.

# Introduction

This repository contains **source code examples and reference manuals for EcosimPro libraries**.

The libraries referenced in this repository are **not intended to be downloaded or installed from here**. They are part of the EcosimPro installation. This repository is meant to provide readable source material and documentation that can be indexed, searched, and used as technical context by AI systems.

> Note: the repository name is kept as `LANGUAJE_EXAMPLES_1.2` to preserve the original project naming.

## Purpose

The main goal of this repository is to make EcosimPro language examples, library source snippets, and manuals available in a format that can be easily consulted by AI-based tools.

## Important clarification

This repository is **not** a distribution channel for EcosimPro libraries.

The libraries themselves are delivered with the official EcosimPro installation. The content in this repository is provided for consultation, documentation, and AI-assisted knowledge retrieval.

## Repository contents

The repository is organized by library or topic area:

```text
LANGUAJE_EXAMPLES_1.2/
├── ALGEBRA/
│   └── sources/
├── CONTAINERS/
│   └── sources/
├── FUNCPOINTERS/
│   └── sources/
├── MATH/
│   ├── include/
│   ├── sources/
│   └── MATH_Library_Reference_Manual.md
├── MODELLING_LANGUAGE/
│   ├── includeFiles/
│   └── sources/
├── MODELLING_LANGUAGE_OBJECTS/
│   └── sources/
└── README.md
```

## Main sections

### ALGEBRA

Contains examples related to algebraic operations, matrices, vectors, linear systems, and related modelling patterns.

The examples illustrate topics such as:

* Basic matrix and vector operations.
* Matrix resizing and value assignment.
* Matrix addition, scalar multiplication, and matrix-vector products.
* Determinants and inverse matrices.
* Linear system solving.
* Example models involving circuits, structures, reactors, and algebraic calculations.

### CONTAINERS

Contains examples showing how to use container-like data structures in EcosimPro.

Topics include:

* `EVector`
* `EMatrix`
* `ESet`
* `EDictionary`
* Classes with constructor parameters.
* Auxiliary methods such as `asString()`.

These examples are useful for understanding how data can be grouped, accessed, and manipulated in EcosimPro models.

### FUNCPOINTERS

Contains examples about function pointers and dynamic function invocation patterns.

The folder includes several numbered examples, such as `funcPtrExamples01.el`, `funcPtrExamples02.el`, and related files, which are intended to demonstrate different use cases progressively.

### MATH

Contains mathematical source material and reference documentation.

This section includes:

* Mathematical constants.
* Scientific constants.
* Standardized units.
* Basic and advanced mathematical functions.
* Utility functions for arrays, interpolation, polynomials, numerical derivatives, and simulation support.
* The reference manual `MATH/MATH_Library_Reference_Manual.md`.

### MODELLING_LANGUAGE

Contains general examples of the EcosimPro modelling language.

This section is useful for consulting language syntax, modelling constructs, include files, and basic modelling patterns.

### MODELLING_LANGUAGE_OBJECTS

Contains examples focused on modelling language objects, classes, and external functions.

This section helps illustrate object-oriented and modular modelling concepts in EcosimPro.

## How AI assistants should use this repository

AI tools can use this repository as a knowledge source for answering EcosimPro-related questions.

Recommended usage:

1. Search the relevant folder according to the topic of the question.
2. Use source files as examples of valid EcosimPro syntax and modelling style.
3. Use Markdown manuals as reference documentation.
4. Prefer examples from the closest matching topic area before generalizing.
5. Clearly distinguish between documented library behavior and inferred usage patterns.

Suggested mapping:

| User question topic                      | Recommended location          |
| ---------------------------------------- | ----------------------------- |
| Algebraic operations, matrices, vectors  | `ALGEBRA/sources/`            |
| Containers and data structures           | `CONTAINERS/sources/`         |
| Function pointers                        | `FUNCPOINTERS/sources/`       |
| Mathematical functions, constants, units | `MATH/`                       |
| General EcosimPro language syntax        | `MODELLING_LANGUAGE/`         |
| Classes, objects, external functions     | `MODELLING_LANGUAGE_OBJECTS/` |

## How humans should use this repository

This repository can be browsed directly to inspect examples and manuals.

Recommended workflow:

1. Identify the topic of interest.
2. Open the corresponding folder.
3. Read the `.el` source files and Markdown manuals.
4. Compare the examples with the EcosimPro installation available in your environment.
5. Use the examples as reference material, not as a replacement for the installed libraries.

## Requirements

To execute or validate the examples in an EcosimPro environment, you need:

* A valid EcosimPro installation.
* The corresponding libraries included with that installation.
* An EcosimPro-compatible workspace or project setup.

However, to consult this repository as documentation or AI context, no EcosimPro installation is required.

## Example consultation scenario

A user may ask an AI assistant:

> How do I perform basic matrix operations in EcosimPro?

The assistant can inspect files under:

```text
ALGEBRA/sources/
```

For example, examples such as `Basic_Operations.el` can be used to understand matrix creation, resizing, assignment, addition, scalar multiplication, and matrix-vector products.

## Documentation

The repository currently includes Markdown reference documentation, including:

```text
MATH/MATH_Library_Reference_Manual.md
```

Additional manuals can be added in Markdown format to improve AI retrieval and human readability.

## Recommended documentation format

When adding new material intended for AI consultation, prefer:

* Markdown files for manuals and explanations.
* Clear headings and topic-based sections.
* Small, focused code examples.
* Descriptive file names.
* Short comments explaining non-obvious code.
* Tables for functions, constants, units, parameters, or component summaries.

## Suggested metadata for examples

When adding or updating source examples, consider including a short header:

```ecosimpro
/*-----------------------------------------------------------------------------------------
 LIBRARY: <LIBRARY_NAME>
 FILE: <FILE_NAME>
 PURPOSE: Short description of the example
 TOPICS: keyword1, keyword2, keyword3
-----------------------------------------------------------------------------------------*/
```

This makes the examples easier to retrieve and understand through AI-based search.

## Maintainer

Maintained by **Empresarios Agrupados Internacional**.
