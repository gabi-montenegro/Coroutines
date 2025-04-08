function* calleeFunc() {
    console.log("callee: " + (yield "Yield 1")); //'A' implicito?
    console.log("callee: " + (yield "Yield 2")); //'B' implicito?
    return "Final Value";
}

function* callerFunc() {
    let yieldStartResult;

    const calleeObj = calleeFunc();
    let prevReceived = undefined;

    while (true) {
        try {
            const { value, done } = calleeObj.next(prevReceived);
            console.log(value);
            if (done) {
                yieldStartResult = value;
                break;
            }
            prevReceived = yield value; // envia o value para o chamador, no caso eh o generator no main
            console.log("Prev received: " + prevReceived);
        } catch (e) {
            calleeObj.throw(e);
        }
    }

    return yieldStartResult;
}

const generator = callerFunc();

console.log(generator.next());   // { value: 'Yield 1', done: false }
console.log(generator.next('A')); // "callee: A", { value: 'Yield 2', done: false }
console.log(generator.next('B')); // "callee: B", { value: 'Final Value', done: true }
console.log(generator.return());   // { value: undefined, done: true } ou .next()

