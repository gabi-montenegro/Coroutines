import asyncio

async def tarefa_demorada():
    print("Iniciando tarefa...")
    await asyncio.sleep(30)  # Simula uma operação demorada
    print("Tarefa concluída!")

async def main():
    print("Iniciando programa principal...")
    await tarefa_demorada()  # Pausa aqui, mas não bloqueia o programa
    print("Programa principal continuando...")

asyncio.run(main())