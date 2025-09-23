function* getQuotation(currency) {
  const url = `https://economia.awesomeapi.com.br/json/last/${currency}-BRL`;

  try {
    const response = yield fetch(url);        
    const data = yield response.json(); 
    console.log(`Cotação do ${currency} em BRL:`, data[`${currency}BRL`].bid);
  } catch (error) {
    console.log("Falha ao obter a cotação:", error);
  }
}

const quotationUSD = getQuotation("USD");

quotationUSD.next().value                     
  .then(res => quotationUSD.next(res).value)  
  .then(json => quotationUSD.next(json).value); 