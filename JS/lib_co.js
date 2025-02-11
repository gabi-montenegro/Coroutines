// Função que simula a obtenção de dados a partir de uma string
function getStringData(input) {
    return new Promise((resolve) => {
        setTimeout(() => resolve(input), 1000); // Simula atraso assíncrono
    });
}

// Implementação da função "co"
function co(genFunc) {
    const genObj = genFunc(); // (1) chamada da funcao geradora
    step(genObj.next());      // (2) começa a execucao da fn geradora, para no primeiro yield

    function step({value, done}) {
        if (!done) {          // (3)
            value
            .then(result => {
                step(genObj.next(result)); // (A) resultado eh passado de volta ao gerador
            })
            .catch(error => {
                step(genObj.throw(error)); // (B) eroo passado para o gerador
            });
        }
    }
}

// Uso da função "co" com uma tarefa geradora
co(function* () {
    try {
        const [data1, data2] = yield Promise.all([
            getStringData('This is data 1'),
            getStringData('This is data 2'),
        ]);

        console.log('Data 1:', data1);
        console.log('Data 2:', data2);
    } catch (e) {
        console.log('Failure to process: ' + e);
    }
});

//O yield pausa a execução até que a Promise seja resolvida.
//O co cuida de avançar a execução chamando next() ou lidando com erros via throw().