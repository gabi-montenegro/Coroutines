// Lazy Evaluation with Generators

const END_OF_SEQUENCE = Symbol();

/**
 * Helper function to get the next item from an iterator.
 */
function getNextItem(iterator) {
    const { value, done } = iterator.next();
    return done ? END_OF_SEQUENCE : value;
}

/**
 * Helper function to check if a character is part of a word.
 */
function isWordChar(ch) {
    return typeof ch === 'string' && /^[A-Za-z0-9]$/.test(ch);
}

/**
 * Returns an iterable that transforms the input sequence
 * of characters into an output sequence of words.
 */
function* tokenize(chars) {
    const iterator = chars[Symbol.iterator]();
    let ch;
    do {
        ch = getNextItem(iterator);
        if (isWordChar(ch)) {
            let word = '';
            do {
                word += ch;
                ch = getNextItem(iterator);
            } while (isWordChar(ch));
            yield word;
        }
        // Ignore all other characters
    } while (ch !== END_OF_SEQUENCE);
}

/**
 * Returns an iterable that filters the input sequence
 * of words and only yields those that are numbers.
 */
function* extractNumbers(words) {
    for (const word of words) {
        if (/^[0-9]+$/.test(word)) {
            yield Number(word);
        }
    }
}

/**
 * Returns an iterable that contains, for each number in
 * `numbers`, the total sum of numbers encountered so far.
 */
function* addNumbers(numbers) {
    let result = 0;
    for (const n of numbers) {
        result += n;
        yield result;
    }
}

/**
 * Logs and yields each item from an iterable, useful for debugging.
 */
function* logAndYield(iterable, prefix = '') {
    for (const item of iterable) {
        console.log(prefix + item);
        yield item;
    }
}

// Testing the implementation
const CHARS = '2 apples and 5 oranges.';

// Pull-based approach
// const CHAIN = addNumbers(extractNumbers(tokenize(CHARS)));
// console.log([...CHAIN]); // Output: [2, 7]
const CHAIN2 = logAndYield(addNumbers(extractNumbers(tokenize(logAndYield(CHARS)))), '-> ');
console.log([...CHAIN2])