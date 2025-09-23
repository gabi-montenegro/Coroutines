function* suporteTecnico() {
  console.log("Olá! Bem-vindo ao suporte técnico. Qual o seu problema?");
  console.log("Digite: 'impressora' ou 'internet'");

  // Ponto de decisão 1 (raiz)
  const problema = yield;

  if (problema === "impressora") {
    console.log("Certo. A impressora está ligada?");
    const ligada = yield; // Ponto de decisão 2.1 (ramo 'impressora')

    if (ligada === "sim") {
      console.log("Verifique se há papel e tinta. Se o problema persistir, reinicie a impressora.");
    } else if (ligada === "nao") {
      console.log("Por favor, ligue a impressora e tente novamente.");
    } else {
      console.log("Não entendi sua resposta. Por favor, reinicie o atendimento.");
    }
  } else if (problema === "internet") {
    console.log("Certo. O modem está com a luz verde acesa?");
    const luzVerde = yield; // Ponto de decisão 2.2 (ramo 'internet')

    if (luzVerde === "sim") {
      console.log("Desconecte o cabo de rede e conecte novamente. Se não funcionar, reinicie o modem.");
    } else if (luzVerde === "nao") {
      console.log("Verifique se todos os cabos estão bem conectados. Se o problema persistir, entre em contato com o provedor.");
    } else {
      console.log("Não entendi sua resposta. Por favor, reinicie o atendimento.");
    }
  } else {
    console.log("Opção inválida. Por favor, reinicie o atendimento.");
  }
}

// --- Cenário 1: Problema com a impressora ---
console.log("\n--- Cenário 1: Problema com a impressora ---\n");
const bot1 = suporteTecnico();
bot1.next(); // Inicia o chatbot
bot1.next("impressora"); // O usuário entra no ramo 'impressora'
bot1.next("sim"); // A execução continua no sub-ramo 'sim'

// --- Cenário 2: Problema com a internet ---
console.log("\n--- Cenário 2: Problema com a internet ---\n");
const bot2 = suporteTecnico();
bot2.next();
bot2.next("internet"); // O usuário entra no ramo 'internet'
bot2.next("nao"); // A execução continua no sub-ramo 'nao'

// --- Cenário 3: Opção inválida ---
console.log("\n--- Cenário 3: Opção inválida ---\n");
const bot3 = suporteTecnico();
bot3.next();
bot3.next("teclado"); // O usuário fornece uma opção inválida