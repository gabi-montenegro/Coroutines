function* generator() {
    console.log("Inicio da geradora");
    helper();
    yield;
    console.log("Fim da geradora");
}

function helper() {
    console.log("Tentativa de suspender aqui");
    yield;
}

const g = generator();
g.next();
g.next();