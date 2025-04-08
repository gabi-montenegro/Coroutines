function* callee() {
    while (true) {
        console.log('callee: ' + (yield));
    }
}

function* caller() {
    const co_callee = callee();
    co_callee.next(); 

    while (true) {
        const input = yield;
        co_callee.next(input);
    }
}

const co_caller = caller();
co_caller.next();       
co_caller.next('a');     
co_caller.next('b');     
