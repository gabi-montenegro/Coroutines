function* foo() {
    yield 'a';
    yield 'b';
}

function* bar() {
    yield 'x';
    yield* foo(); // ou yield* ['a', 'b']
    yield 'y';
}

console.log([...bar()]); // ['x', 'y']
