// Complete as coroutine  

function* callee() {
    console.log("callee " + (yield));
}

function* caller() {
    while(true) {
        yield* callee();
    }
}

const objCaller = caller();
objCaller.next();
objCaller.next('a');
objCaller.next('b');