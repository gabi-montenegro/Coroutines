const { createReadStream } = require('fs');


function readFile(fileName, target) {
    let readStream = createReadStream(fileName, { encoding: 'utf8' });
    readStream.on('data', buffer => {
        target.next(buffer);  // Envia os dados do arquivo para o gerador
    });
    readStream.on('end', () => {
        target.return();  // Finaliza o processo quando o arquivo é lido
    });
}

const splitLines = coroutine(function* (target) {
    let previous = '';
    let blankLine = false;
    try {
        while (true) {
            previous += yield;  // Recebe mais dados do arquivo
            let lineIndex;
            while ((lineIndex = previous.indexOf('\n')) >= 0) {
                let line = previous.slice(0, lineIndex);  // Extrai a linha
                
                if (line.trim() === '') {
                    blankLine = true;
                    break;  // Interrompe se encontrar uma linha vazia
                }
                
                target.next(line);  // Envia a linha para ser impressa
                previous = previous.slice(lineIndex + 1);  // Atualiza o buffer com o restante
            }
        }
    } finally {
        if (!blankLine && previous.length > 0) { //processa ultimo chunk se a linha em branco nao foi detectada
            target.next(previous);  // Envia o restante do buffer
        }
        target.return();  // Finaliza o processo
    }
});


const normalizeWordsLines = coroutine(function* (target) {
    try {
        while (true) {
            let line = yield;
            if (!line.trim()) break;  // Para o pipeline ao encontrar uma linha em branco
            let words = line.trim().replace(/\s+/g, ' ').split(' ');  // Divide a linha em palavras normalizando espaços
            for (let word of words) {
                target.next(word);  // Envia a linha completa
            }
        }
    } finally {
        target.return();  // Finaliza o processo
    }
});

const wrapText = coroutine(function* (target) {
    let buffer = '';
    try {
        while (true) {
            let word = yield;
            // if (!word) break;  // Se a palavra for undefined, para tudo
            if (buffer.length + word.length + (buffer ? 1 : 0) > 30) { // o ternario eh para contabilizar o espaco entre as palavras caso haja um buffer
                target.next(buffer);  // Envia a linha formatada
                buffer = word;  // Começa nova linha
            } else {
                buffer += (buffer ? ' ' : '') + word;
            }
        }

    } finally {
        if (buffer) target.next(buffer); // Envia última linha
        target.return();
    }
});

const printLines = coroutine(function* () {
    while (true) {
        let line = yield;
        console.log(line);
    }
});

function coroutine(generatorFunction) {
    return function (...args) {
        let generatorObject = generatorFunction(...args);
        generatorObject.next();  // Inicializa o gerador
        return generatorObject;
    };
}

let fileName = process.argv[2];
readFile(fileName, splitLines(normalizeWordsLines(wrapText(printLines()))));
