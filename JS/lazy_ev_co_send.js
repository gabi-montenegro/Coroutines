function coroutine(generatorFunction) {
    return function (...args) {
        let generatorObject = generatorFunction(...args);
        generatorObject.next();
        return generatorObject;
    };
}

function send(iterable, receiver, {log = false} = {}) {
    for (let x of iterable) {
        if (log) {
            console.log(x);
        }
        receiver.next(x); //envia para o gerador
    }
    receiver.return(); // signal end of stream
}

const simpleReceiver = coroutine(function* () {
    try {
        while (true) {
            let value = yield; // Espera um valor ser enviado por next()
            console.log("Recebido:", value);
        }
    } finally {
        console.log("Stream finalizada!");
    }
});

// Criamos o gerador receiver
const receiver = simpleReceiver();

// Enviamos valores
send([1, 2, 3], receiver);
