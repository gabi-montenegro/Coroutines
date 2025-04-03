function* producer() {
    yield "data1";
    yield "data3";
}

function* producer_2() {
    yield "data2";
}

const prod = producer();
const prod2 = producer_2();

console.log(prod2.next().value);


for (const value of prod) console.log(value);