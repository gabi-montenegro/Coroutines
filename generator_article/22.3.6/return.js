function* foo() {
    yield 'a';
    yield 'b';
    return 'The result'; // Valor final da iteração
}

function* bar() {
    const result = yield* foo(); // somente yield* foo, obtem apenas 'a' e 'b', sem o return
    console.log(result); // (A) Captura 'The result'
}

const obj = bar();
console.log(obj.next().value); // {value: 'a', done: false}
console.log(obj.next().value); // {value: 'b', done: false}
console.log(obj.next().value); // The result + {value: undefined, done: true}
