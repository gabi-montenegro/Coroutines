function* genFunc() {
    throw new Error('Problema!');
}

const genObj = genFunc();
genObj.next(); // Lança um erro: "Error: Problema!"
