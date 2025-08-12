const dadosPaginados = [
["Artigo 1", "Artigo 2"],
["Artigo 3", "Artigo 4"],
["Artigo 5"]
];

function* carregarArtigos(dadosPaginados) {
    
    for (const pagina of dadosPaginados)
        yield pagina; 

    }

const gerador = carregarArtigos(dadosPaginados);

const primeiraPagina = gerador.next();
console.log("Página 1:", primeiraPagina.value);

const segundaPagina = gerador.next();
console.log("Página 2:", segundaPagina.value);

const terceiraPagina = gerador.next();
console.log("Página 3:", terceiraPagina.value);

const fim = gerador.next();
console.log("Fim da iteração:", fim.done); // true