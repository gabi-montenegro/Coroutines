function* gerador() {
    [1, 2, 3].forEach((n) => {
    yield n; // SyntaxError
    });
    }

const ger = gerador();
ger.next();