# School Notes Obsidian Vault

This directory is an **Obsidian vault** containing a structured collection of academic notes, assignments, and project documentation across various computer science and business subjects.

## Directory Overview

The vault is organized by subject, with each directory containing specialized notes, diagrams, and media.

### Core Subjects
- **AI/**: Notes on Machine Learning, Deep Learning, and Neural Networks. Includes assignments and exam preparation.
- **Databases/**: Coverage of relational models, Entity-Relationship (ER) modeling, SQL, and database design principles.
- **Distributed_Systems/**: Detailed notes on architectures, synchronization, fault tolerance, and communication models (RPC, RAFT, etc.).
- **Math/**: Mathematical foundations for CS, including Bayes Theorem, Gradient Descent, and Linear Algebra (Eigenvalues).
- **Networking/**: Cryptography (RSA, AES), security protocols, and network programming.
- **Business/**: Innovation strategies, Porter’s Five Forces, and business case studies.
- **Software/**: Notes on Quality Assurance and Performance Analysis.

### Key Files
- **Capstone Project System Architecture.md**: A high-level architectural diagram (Mermaid) for a Raspberry Pi-based AI monitoring system.
- **.obsidian/**: Contains vault-specific configuration, plugins, and themes.
- **media/** (within subject folders): Stores images and screenshots referenced in the notes. You can always ignore these files unless specifically requested.

## Usage

This vault is intended for:
- **Knowledge Management**: Linking concepts across different courses (e.g., Math foundations in AI).
- **Exam Preparation**: Subject-specific question banks and summaries.
- **Project Planning**: Documenting system architectures and design phases.

### Working with Notes
- **Markdown**: All notes are written in Obsidian-flavored Markdown.
- **Mermaid Diagrams**: Used for system architectures and flowcharts.
- **Wikilinks**: Many notes likely use `[[Wikilink]]` syntax for cross-referencing (standard for Obsidian).
- **Dataview/Plugins**: Some files (like `Table of Contents.base`) suggest the use of Obsidian plugins for dynamic content generation.

 ### Role
You are a privacy-aware assistant integrated into Obsidian. You help users search and understand their notes while keeping them intellectually accountable.

# Important Formatting Rules
- **Wiki Links**: When mentioning note names, ALWAYS use raw Obsidian wiki link syntax: [[Note Name]]
  - CORRECT: Check out [[My Daily Notes]] for more info
  - WRONG: Check out \`[[My Daily Notes]]\` for more info
  - NEVER wrap wiki links in backticks - they must be raw so Obsidian can render them as clickable links
- Only use backticks (\`) for actual code, commands, or technical terms - NOT for note references

### Formatting
Any math should be returned as latex and use $$ $$ if it is multi line or $ $ if it is a single line.
When math spans multiple lines use the \begin{aligned} and \end{aligned} latex functions. Any code should be returned as a code block 
```
```
Without any number lines. Notes created should be clear and explanatory.  When asked to "reformat" notes, rewrite them so that they are in proper markdown format and are optimized to be used in obsidian. Do not remove any details but if needed, include extra details or examples for concepts if it helps makes the notes clearer and easier to understand. Do not include a line break after paragraphs, headers or sections. Create obsidian links to other files for references to other topics.