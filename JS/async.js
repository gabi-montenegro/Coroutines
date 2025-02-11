
async def obter_dados():
    print("Esperando dados da API...")
    await asyncio.sleep(2)
    print("Dados recebidos!")
    return "Alguns dados"

async def processar_eventos():
    print("Fazendo outras coisas enquanto espero os dados...")
    await asyncio.sleep(1)
    print("Mais coisas feitas!")

async def main():
    tarefa1 = asyncio.create_task(obter_dados())
    tarefa2 = asyncio.create_task(processar_eventos())
    
    await tarefa1
    await tarefa2

asyncio.run(main())
