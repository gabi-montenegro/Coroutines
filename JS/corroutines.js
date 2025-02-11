const co = require('co');

function* task() {
    const result1 = yield asyncTask1(); // Executa e espera o resultado
    const result2 = yield asyncTask2(); // Executa depois
    return result1 + result2;
}

co(task).then(result => console.log(result));
