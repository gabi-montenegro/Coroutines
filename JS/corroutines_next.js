function* gen(x) {
    // (A)
    while (true) {
        yield x; // (B)
        x++;
        // console.log(input);
    }
}

function* gen2() {
    while(true) {
        const input = yield;
        console.log(input)
    }
}


function coroutine(generatorFunction) {
    return function (...args) {
        const genObj = generatorFunction(...args)
        genObj.next();
        return genObj;
    }
}




const obj = gen(1);
console.log(obj.next()); //1
console.log(obj.next()); //2

console.log("========SEM CORROTINAS========")
const obj2 = gen2();
obj2.next('a') //apenas incializa, para no primeiro yield
obj2.next('b') //b


console.log("======COM CORROTINA========")
const obj3 = coroutine(gen2)(); //automatiza inicializacao, tornando o generator pronto para receber o input do primeiro next()
obj3.next('a')