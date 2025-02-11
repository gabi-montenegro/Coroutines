function * gen1() {
    yield 1;
    return 2;
    yield 3;
}

function * gen2() {
    yield 1;
    yield 2;
    return 3;
}

const genObj = gen1();

console.log("===gen1====")
console.log(genObj.next()); // { value: 1, done: false }
console.log(genObj.next()); // { value: 2, done: true }
console.log(genObj.next()); // { value: undefined, done: true }

const genObj2 = gen2();

console.log("===gen2====")
console.log(gen2().next()); // { value: 1, done: false }
console.log(gen2().next()); // { value: 2, done: false }
console.log(gen2().next()); // { value: 3, done: true }

