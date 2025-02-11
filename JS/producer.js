function* producer() {
    yield "data1";
    yield "data2";
    yield "data3";
}

function consumer(producer) {
    for (const data of producer) {
        console.log(`Processed: ${data}`);
    }
}

const prod = producer();
consumer(prod);
// Output:
// Processed: data1
// Processed: data2
// Processed: data3
