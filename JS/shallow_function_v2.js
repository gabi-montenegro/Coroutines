function* shallowCoroutine() {
    console.log("Step 1: Start the task");

    helperFunction(); // Tenta executar uma função auxiliar
    console.log("Step 2: Continue the task");

    yield; // Suspensão acontece aqui, não dentro de helperFunction
    console.log("Step 3: Complete the task");
}

function helperFunction() {
    console.log("Helper function trying to yield...");
    // Aqui, não conseguimos usar yield diretamente porque não é um generator
    // Erro seria causado se yield fosse usado aqui
}

// Gerencia a execução do generator
function executeCoroutine() {
    const coroutine = shallowCoroutine();

    console.log("Resuming coroutine...");
    coroutine.next();

    console.log("Resuming coroutine again...");
    coroutine.next();
}

// Executa
executeCoroutine();
