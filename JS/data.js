function* transformSequence(x) {
    console.log("Created");
    let y = yield x * 3; // Suspende e retorna x * 3
    return y - 1;        // Retoma com y e retorna y - 5
}

const co = transformSequence(10);

let b = co.next().value; // { value: 30, done: false }
console.log(b); // { value: 30, done: false }

let c = co.next(b + 2); // { value: 25, done: true }
console.log(c); // { value: 25, done: true }