function run(generator) {
    const gen = generator(); // Cria o Generator

    function nextStep(value) {
        const next = gen.next(value); // Retoma o Generator com um valor

        if (!next.done) {
            next.value.then(nextStep); // Aguarda a Promise e chama `nextStep`
        }
    }

    nextStep(); // Inicia a execução
}

// Criamos a função Generator sem `co.wrap`
function* fetchJson(url) {
    let request = yield fetch(url);
    let text = yield request.text();
    return JSON.parse(text);
}

// Chamamos a função manualmente
run(() => fetchJson("https://jsonplaceholder.typicode.com/todos/1"))
    .then(console.log);
