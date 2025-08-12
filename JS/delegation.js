function* artigosTecnologia() {
    yield "Artigo: IA e Ética";
    yield "Artigo: Redes Neurais";
    }
    
function* artigosCiencia() {
    yield "Artigo: Física Quântica";
    yield "Artigo: Astronomia Moderna";
}

function* carregarArtigos() {
    yield* artigosTecnologia();
    yield* artigosCiencia();
}
    
const gerador = carregarArtigos();

console.log(gerador.next().value); // Artigo: IA e Ética
console.log(gerador.next().value); // Artigo: Redes Neurais
console.log(gerador.next().value); // Artigo: Física Quântica
console.log(gerador.next().value); // Artigo: Astronomia Moderna