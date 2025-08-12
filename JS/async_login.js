function autenticar({ usuario, senha }) {
    const usuariosAutorizados = {
      "alice": "12w3",
      "rafael": "4re5"
    };
  
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (usuariosAutorizados[usuario] === senha) {
          resolve(`Acesso concedido para ${usuario}`);
        } else {
          reject("Credenciais inválidas");
        }
      }, 500);
    });
  }
  
async function fluxoLogin() {
    try {
        const resultado1 = await autenticar({ usuario: "alice", senha: "12w3" });
        console.log(resultado1);

        const resultado2 = await autenticar({ usuario: "rafael", senha: "xyz" });
        console.log(resultado2);

    } catch (erro) {
        console.log(erro);
    }

    try {
        const resultado3 = await autenticar({ usuario: "rafael", senha: "4re5" });
        console.log(resultado3);
        
    } catch (erro) {
        console.log(erro);
    }
}
  
fluxoLogin();