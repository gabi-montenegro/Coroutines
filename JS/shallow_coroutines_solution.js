async function deepCoroutine() {
    console.log("Step 1: Start the task");

    await helperFunctionAsync(); // Suspensão é possível aqui
    console.log("Step 2: Continue the task");

    console.log("Step 3: Complete the task");
}

async function helperFunctionAsync() {
    console.log("Helper function yielding...");
    return new Promise(resolve => setTimeout(resolve, 1000)); // Pausa aqui
}

// Executa
deepCoroutine();
