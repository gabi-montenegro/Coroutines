function* producer() {
    yield "data1";
    yield "data2";
    yield "data3";
}

function* consumer(producer) {
    //for .. of chama automaticamente o metodo next() até o done: true
    for (const data of producer) {
        console.log(`Processed: ${data}`);
        yield; // Permite controle explícito de cada passo
    }
}

const prod = producer();
const cons = consumer(prod);

cons.next(); // Processa "data1"
cons.next(); // Processa "data2"
cons.next(); // Processa "data3"
// Output:
// Processed: data1
// Processed: data2
// Processed: data3
