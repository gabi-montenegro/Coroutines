function objectEntries(obj) {
    let index = 0; // Mantém o controle da posição na lista de propriedades.
    let propKeys = Reflect.ownKeys(obj); // Obtém as chaves do objeto.

    return {
        [Symbol.iterator]() { // Implementa o protocolo de iteração.
            return this;
        },
        next() { // Define como os valores são retornados.
            if (index < propKeys.length) {
                const key = propKeys[index];
                index++;
                return { value: [key, obj[key]] }; // Retorna o par [chave, valor].
            } else {
                return { done: true }; // Indica o fim da iteração.
            }
        }
    };
}


const jane = { first: 'Jane', last: 'Doe' };

for (const [key, value] of objectEntries(jane)) {
    console.log(`${key}: ${value}`);
}
// Saída:
// first: Jane
// last: Doe
