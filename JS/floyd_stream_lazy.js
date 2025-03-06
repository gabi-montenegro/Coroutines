function coroutine(generatorFunction) {
    return function (...args) {
        let generatorObject = generatorFunction(...args);
        generatorObject.next();
        return generatorObject;
    };
}

// 1. Corrotina para normalizar espaços e eliminar linhas vazias
const normalizeText = coroutine(function* (receiver) {
    try {
        while (true) {
            let line = yield;
            if (!line.trim()) break; // Para o pipeline ao encontrar uma linha em branco
            let words = line.trim().split(/\s+/); // Divide a linha em palavras normalizando espaços
            for (let word of words) {
                receiver.next(word); // Envia palavra por palavra
            }
        }
    } finally {
        receiver.return();
    }
});

// 2. Corrotina para formatar o texto em linhas de no máximo 30 caracteres
const wrapText = coroutine(function* (receiver) {
    let buffer = "";
    try {
        while (true) {
            let word = yield;
            if (!word) break; // Se a palavra for undefined, para tudo

            if (buffer.length + word.length + (buffer ? 1 : 0) > 30) { 
                receiver.next(buffer); // Envia linha formatada
                buffer = word; // Começa nova linha
            } else {
                buffer += (buffer ? " " : "") + word;
            }
        }
    } finally {
        if (buffer) receiver.next(buffer); // Envia última linha
        receiver.return();
    }
});

// 3. Corrotina que imprime a saída
const printText = coroutine(function* () {
    try {
        while (true) {
            let line = yield;
            if (!line) break; // Para o processamento se receber um valor vazio
            console.log(line);
        }
    } finally {
        console.log("DONE");
    }
});

// 4. Função para enviar a string para o pipeline
function sendString(inputString, receiver) {
    let lines = inputString.split("\n"); // Divide a string em linhas
    for (let line of lines) {
        receiver.next(line);
        if (!line.trim()) break; // Se encontrar uma linha vazia, interrompe o envio
    }
    receiver.return();
}

// Entrada como única string
const INPUT = `asdfkj asfdlkjasd  flkajsdfzzzzz laksjdf alkj                                        
asd  flajdsf laksjd   lakjdfla skdj                                            
as dlfkjasdl   fkja d  

aaaaaasss`;

// Configuração do pipeline
const CHAIN = normalizeText(wrapText(printText()));

// Enviar os dados da string para o pipeline
sendString(INPUT, CHAIN);
