function * objectEntries(obj) {
    const propKeys = Reflect.ownKeys(obj); // Obtém todas as chaves (strings e símbolos) do objeto.
    
    for (const propKey of propKeys) { // Itera sobre as chaves.
        yield [propKey, obj[propKey]]; // "Retorna" um par [chave, valor] por vez.
    }
}

const jane = { first: 'Jane', last: 'Doe', middle: 'Sarah' };
for(const [key, value] of objectEntries(jane)){ // for-of: simula o next()
    console.log(`${key}: ${value}`);

}