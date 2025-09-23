function* detectarTendencia(n) {
    let historico = [];

    while (true) {
        const leitura = yield;

        historico.push(leitura);

        if (historico.length > n) {
            historico.shift();
        }

        if (historico.length === n) {
            let crescente = true;
            let decrescente = true;

            for (let i = 1; i < historico.length; i++) {
                if (historico[i] <= historico[i-1]) crescente = false;
                if (historico[i] >= historico[i-1]) decrescente = false;
            }

            if (crescente) {
                console.log(`Tendência de aquecimento detectada: ${historico.join(", ")}`);
            } else if (decrescente) {
                console.log(`Tendência de resfriamento detectada: ${historico.join(", ")}`);
            } else {
                console.log(`Sem tendência clara: ${historico.join(", ")}`);
            }
        }
    }
}

// Uso
const monitor = detectarTendencia(3);
monitor.next();

monitor.next(25);
monitor.next(26);
monitor.next(27); // tendencia aquecimnto
monitor.next(27);
monitor.next(26);
monitor.next(25); 
monitor.next(25);
monitor.next(26);
monitor.next(25); 
