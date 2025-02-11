// Simula uma operação assíncrona
function asyncOperation(message, delay) {
    return new Promise((resolve) => {
        setTimeout(() => resolve(message), delay);
    });
}

// Usando um generator para multitarefa cooperativa
function* shallowCoroutine() {
    console.log("Step 1: Start task");
    const result1 = yield asyncOperation("Result of step 2", 1000); // Suspende aqui
    console.log("Step 2:", result1);

    const result2 = yield asyncOperation("Result of step 3", 1000); // Suspende aqui
    console.log("Step 3:", result2);

    console.log("Step 4: Task complete");
}

// Executor de generator para multitarefa cooperativa
function runGenerator(genFunc) {
    const generator = genFunc();

    function step(nextValue) {
        const { value, done } = generator.next(nextValue);
        if (!done) {
            // Garantir que o valor seja uma Promise antes de continuar
            Promise.resolve(value).then(step).catch((err) => generator.throw(err));
        }
    }

    step();
}

// Executa a coroutine rasa
console.log("Starting shallow coroutine:");
runGenerator(shallowCoroutine);
