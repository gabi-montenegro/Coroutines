function* profundidade() {
    console.log("Antes de pausar");
    yield;
    console.log("Depois de retomar");
}
    
function* gerador() {
    yield* profundidade();
}
    
const g = gerador();
g.next(); // "Antes de pausar"
g.next(); // "Depois de retomar"