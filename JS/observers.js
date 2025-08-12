function* verificarLogin() {
    const usuariosAutorizados = {
    "alice": "12w3",
    "rafael": "4re5"
    };

    while (true) {
        const credenciais = yield;
        const { usuario, senha } = credenciais;
    
        if (usuariosAutorizados[usuario] === senha) {
            console.log(`Acesso concedido para ${usuario}`);
        } else {
            console.log("Credenciais inválidas");
        }
    }
    }
    
const sistema = verificarLogin();
sistema.next(); 

sistema.next({ usuario: "alice", senha: "12w3" }); // Acesso concedido
sistema.next({ usuario: "rafael", senha: "xyz" }); // Credenciais inválidas
sistema.next({ usuario: "rafael", senha: "4re5" }); // Acesso concedido