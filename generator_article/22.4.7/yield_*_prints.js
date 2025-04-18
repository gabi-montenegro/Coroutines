function* numbers1to3() {
    yield 1;
    yield 2;
    yield 3;
}
  
function* numbers4to6() {
    yield 4;
    yield 5;
    yield 6;
}
  
function* composableIterator() {
    yield* numbers1to3();
    yield* numbers4to6(); 
}
  
// const resultado = [...composableIterator()];
// console.log(resultado); 

const resultado = [];
for (const x of composableIterator()) {
    resultado.push(x);
}
console.log(resultado);
