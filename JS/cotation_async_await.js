async function getQuotation(currency) {
  const url = `https://economia.awesomeapi.com.br/json/last/${currency}-BRL`;

  try {
    const response = await fetch(url);
    const data = await response.json();
    console.log(`Cotação do ${currency} em BRL:`, data[`${currency}BRL`].bid);
  } catch (error) {
    console.log("Falha ao obter a cotação:", error);
  }
}

getQuotation("USD");