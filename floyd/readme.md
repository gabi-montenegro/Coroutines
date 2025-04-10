# File Read implementation and Floyd Problem
File read implementation from https://github.com/rauschma/generator-examples/blob/gh-pages/node/readlines.js

## Floyd Problem Description

The problem consists of reading a text file and printing its content to the console while adhering to the following conditions:

1. **Line Character Limit:** Each line printed to the console should contain a maximum of **30 characters**.
2. **No Word Breaks:** Words must not be broken across lines. That is, a word should be printed in full, without being split in the middle, even if it exceeds the 30-character limit. If a word doesn't fit on the current line, it should be moved to the next line.
3. **Empty Line:** The reading and printing process should stop once an empty line is encountered in the file.

### Objective

The goal is to create a solution that reads a file and arranges the text such that the content is printed to the console while respecting the 30-character per line limit and ensuring that words are not split. The program should also stop reading when an empty line is found in the file.

### Coroutine-Based Solution

Using coroutines for this problem is particularly interesting because it allows for efficient management of reading and printing without blocking. By leveraging coroutines, we can simulate a pipeline where each line or word is processed and printed incrementally, making the solution more memory-efficient and responsive. This approach is well-suited for problems like this, where the input size may vary and processing can be done asynchronously, step by step, without the need to load the entire file into memory at once.

The coroutine solution provides a more elegant way to handle the flow of data, allowing the program to pause and resume operations (such as reading and printing lines) based on the constraints of the problem, making the entire process smoother and more adaptable.
