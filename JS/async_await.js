function asyncTask(generatorFn) {
    const generator = generatorFn(); //instancia do gerador

    //result representa o eatado atual do gerador
    function handle(result) {
        if (result.done) return Promise.resolve(result.value);
        return Promise.resolve(result.value).then(
            res => handle(generator.next(res)),
            err => handle(generator.throw(err))
        );
    }

    return handle(generator.next()); //inicia o gerador
}

// Tarefa simulando uma Promise com um gerador
asyncTask(function* () {
    const result1 = yield Promise.resolve("Task 1 complete");
    console.log(result1);
    const result2 = yield Promise.resolve("Task 2 complete");
    console.log(result2);
});
// Output:
// Task 1 complete
// Task 2 complete


// Passos:

// asyncTask recebe uma função geradora e a executa.
// O gerador pausa no primeiro yield e retorna a Promise resolvida "Task 1 complete".


// O valor da Promise ("Task 1 complete") é passado de volta para o gerador via generator.next(res).
// O gerador continua e pausa no próximo yield, retornando a próxima Promise.


// O valor da segunda Promise ("Task 2 complete") é passado ao gerador via generator.next(res).
// O gerador termina (done: true) e o handle finaliza.
